# ==============================================================================
# LITERT-LM SURGICAL PATCHER
# Purpose: Inject the Hermetic Shim and neutralize internal dependency fetching.
# ==============================================================================
include("${LITERTLM_MODULES_DIR}/utils.cmake")

message(STATUS "[LITERTLM] Initializing Surgical Build-System Remediation for LiteRT...")

# --- 0. ENVIRONMENT SETUP ---
set(LITERT_INTERNAL_ROOT "${LITERT_SOURCE_DIR}/litert")
set(ROOT_LIST "${LITERT_INTERNAL_ROOT}/CMakeLists.txt")

# Path to the Shim Hub we just created
set(SHIM_PATH "${LITERTLM_RECIPES_DIR}/litert/litert_shims.cmake")

# --- 1. INTEGRITY CHECKS ---
if(NOT EXISTS "${ROOT_LIST}")
    message(FATAL_ERROR "[LITERTLM] Integrity Failure: Root manifest not found at ${ROOT_LIST}.")
endif()

# --- 2. ROOT MANIFEST INJECTION (The Single-Line Piercing) ---
file(READ "${ROOT_LIST}" ROOT_CONTENT)

# Check for idempotency so we don't inject twice
if(NOT ROOT_CONTENT MATCHES "litert_shims.cmake")
    message(STATUS "[LITERTLM] Injecting Global Dependency Shims into Root Manifest...")
    
    # We simply include the Hub. All aliases and targets are defined there.
    set(INJECTION "include(\"${SHIM_PATH}\")\n")
    
    file(WRITE "${ROOT_LIST}" "${INJECTION}${ROOT_CONTENT}")
else()
    message(STATUS "[LITERTLM] Root manifest already shimmed. Skipping injection.")
endif()


# --- 3. THE SUBMODULE GUILLOTINE ---
# Prevent LiteRT from entering these directories and triggering downloads/errors.

set(GUILLOTINE_PATHS
    "${LITERT_INTERNAL_ROOT}/third_party/tensorflow/CMakeLists.txt"       # The 2GB Download
    "${LITERT_INTERNAL_ROOT}/tflite/CMakeLists.txt"                       # Legacy Internal TFLite
    "${LITERT_INTERNAL_ROOT}/tflite/tools/cmake/CMakeLists.txt"           # Conflicting Toolchains
)

foreach(TARGET_HEAD ${GUILLOTINE_PATHS})
    # Ensure directory exists so we can plant the dummy file
    get_filename_component(TARGET_DIR "${TARGET_HEAD}" DIRECTORY)
    if(NOT EXISTS "${TARGET_DIR}")
        file(MAKE_DIRECTORY "${TARGET_DIR}")
    endif()

    message(STATUS "[LITERTLM] Decapitating legacy build path: ${TARGET_HEAD}")
    file(WRITE "${TARGET_HEAD}" "message(STATUS \"[LITERTLM] Path Guillotined: ${TARGET_HEAD}\")\n")
endforeach()


# --- 4. TRANSITIVE TARGET REDIRECTION (Recursive Sweep) ---
# We scan for hardcoded paths and FetchContent calls that aliases can't fix.
file(GLOB_RECURSE ALL_CMAKELISTS "${LITERT_INTERNAL_ROOT}/*.cmake" "${LITERT_INTERNAL_ROOT}/**/CMakeLists.txt")

foreach(C_FILE ${ALL_CMAKELISTS})
    if("${C_FILE}" STREQUAL "${ROOT_LIST}")
        continue()
    endif()
    patch_file_content("${C_FILE}" "absl::[a-zA-Z0-9_]+" "LiteRTLM::absl::absl" TRUE)
   
    # A. Neutralize Hardcoded Flatbuffer Paths (Crucial)
    # TFLite/LiteRT loves to look for ".../flatbuffers-build/libflatbuffers.a" directly.
    patch_file_content("${C_FILE}" "[^\" ]*/_deps/flatbuffers-build/libflatbuffers.a" "LiteRTLM::flatbuffers::flatbuffers" TRUE)
    patch_file_content("${C_FILE}" "flatbuffers-build/libflatbuffers.a" "LiteRTLM::flatbuffers::flatbuffers" FALSE)
    patch_file_content("${C_FILE}" "TFLITE_FLATBUFFERS_LIB" "LiteRTLM::flatbuffers::flatbuffers" FALSE)

    # B. Kill Internal Discovery Logic
    # We want it to use the "flatc" target we defined in the Shim, not look for one.
    patch_file_content("${C_FILE}" "find_program\\(FLATC_EXECUTABLE[^\\)]+\\)" "# [LITERTLM] Suppressed: Using Global Shim" TRUE)
    # Ensure variables point to the target name "flatc", not a file path
    patch_file_content("${C_FILE}" "set\\(FLATC_EXECUTABLE \\$<TARGET_FILE:flatc>\\)" "set(FLATC_EXECUTABLE flatc)" TRUE)

    # C. Neutralize FetchContent (The "Anti-Download" Shield)
    patch_file_content("${C_FILE}" "FetchContent_Declare\\([^\\)]+\\)" "# [LITERTLM] Suppressed: External fetch prohibited" TRUE)
    patch_file_content("${C_FILE}" "FetchContent_MakeAvailable\\([^\\)]+\\)" "# [LITERTLM] Suppressed: Using Global Manifest" TRUE)
endforeach()


# --- 5. SOURCE-LEVEL REMEDIATION ---
# Correcting C++ API signature drifts.
patch_file_content("${LITERT_INTERNAL_ROOT}/runtime/compiled_model.cc" 
    " return litert_cpu_buffer_requirements" 
    "return litert::Expected<const LiteRtTensorBufferRequirementsT*>(litert_cpu_buffer_requirements)" FALSE)

# Fix directory structure mismatch
patch_file_content("${ROOT_LIST}" "add_subdirectory(compiler_plugin)" "add_subdirectory(compiler)" FALSE)


# --- 6. VENDOR SUBSYSTEM DECOUPLING ---
set(V_LIST "${LITERT_INTERNAL_ROOT}/vendors/CMakeLists.txt")
if(EXISTS "${V_LIST}")
    file(READ "${V_LIST}" V_CONTENT)
    
    # 1. Find the start of the MediaTek block
    string(FIND "${V_CONTENT}" "if(VENDOR STREQUAL \"MediaTek\")" START_POS)
    
    if(NOT START_POS EQUAL -1)
        # 2. Find the FIRST 'endif()' that occurs AFTER the start pos
        # We look for the anchor first to make sure we're in the right place
        string(FIND "${V_CONTENT}" "add_custom_target(mediatek_schema_gen" ANCHOR_POS)
        
        if(NOT ANCHOR_POS EQUAL -1)
            message(STATUS "[LITERTLM] Decoupling Vendor Dependencies (Surgical Slice)...")
            
            # Find the endif() relative to the anchor
            string(SUBSTRING "${V_CONTENT}" ${ANCHOR_POS} -1 POST_ANCHOR)
            string(FIND "${POST_ANCHOR}" "endif()" ENDIF_REL_POS)
            
            # Calculate total end position (Anchor + Relative End + 'endif()' length)
            math(EXPR END_POS "${ANCHOR_POS} + ${ENDIF_REL_POS} + 7")

            # 3. Slice it out
            string(SUBSTRING "${V_CONTENT}" 0 ${START_POS} PRE_BLOCK)
            string(SUBSTRING "${V_CONTENT}" ${END_POS} -1 POST_BLOCK)

            # 4. Stitch in the include
            set(INJECTION "\n# [LITERTLM] MediaTek Logic Virtualized\ninclude(\"${VENDOR_SHIM_PATH}\")\n")
            file(WRITE "${V_LIST}" "${PRE_BLOCK}${INJECTION}${POST_BLOCK}")
        endif()
    endif()
endif()


# --- 7. MANDATORY BUILD CONFIGURATION ---
# Enforce deterministic GPU/NPU flags via a generated header.
message(STATUS "[LITERTLM] Enforcing deterministic build_config.h...")
set(LITERT_GEN_DIR "${LITERT_INTERNAL_ROOT}/build_common") 

if(NOT EXISTS "${LITERT_GEN_DIR}")
    file(MAKE_DIRECTORY "${LITERT_GEN_DIR}")
endif()

if(NOT DEFINED LITERT_BUILD_CONFIG_DISABLE_GPU_VAL)
    set(LITERT_BUILD_CONFIG_DISABLE_GPU_VAL 1)
endif()
if(NOT DEFINED LITERT_BUILD_CONFIG_DISABLE_NPU_VAL)
    set(LITERT_BUILD_CONFIG_DISABLE_NPU_VAL 1)
endif()

set(BUILD_CONFIG_CONTENT "/* Generated by LiteRTLM Patcher - Deterministic Configuration */
#ifndef LITE_RT_BUILD_COMMON_BUILD_CONFIG_H_
#define LITE_RT_BUILD_COMMON_BUILD_CONFIG_H_

#define LITERT_BUILD_CONFIG_DISABLE_GPU ${LITERT_BUILD_CONFIG_DISABLE_GPU_VAL}
#define LITERT_BUILD_CONFIG_DISABLE_NPU ${LITERT_BUILD_CONFIG_DISABLE_NPU_VAL}

#endif  /* LITE_RT_BUILD_COMMON_BUILD_CONFIG_H_ */\n")

file(WRITE "${LITERT_GEN_DIR}/build_config.h" "${BUILD_CONFIG_CONTENT}")

message(STATUS "[LITERTLM] Surgical Patching Phase Complete.")