# litert_patcher.cmake
message(STATUS "[LITERTLM] Initializing Surgical Patching...")

# --- 1. CONFIGURATION & HELPERS ---
set(LITERT_INTERNAL_ROOT "${LITERT_SOURCE_DIR}/litert")
set(ROOT_LIST "${LITERT_INTERNAL_ROOT}/CMakeLists.txt")

function(patch_file_content FILE_PATH MATCH_STR REPLACE_STR IS_REGEX)
    if(EXISTS "${FILE_PATH}")
        file(READ "${FILE_PATH}" CONTENT)
        if(IS_REGEX)
            string(REGEX REPLACE "${MATCH_STR}" "${REPLACE_STR}" CONTENT "${CONTENT}")
        else()
            string(REPLACE "${MATCH_STR}" "${REPLACE_STR}" CONTENT "${CONTENT}")
        endif()
        file(WRITE "${FILE_PATH}" "${CONTENT}")
    endif()
endfunction()

# litert_patcher.cmake -> Section 2 Refactor

if(EXISTS "${ROOT_LIST}")
    file(READ "${ROOT_LIST}" ROOT_CONTENT)
    
    # Check for our guard to prevent double-patching
    if(NOT ROOT_CONTENT MATCHES "LITERTLM_ROOT_SHIM")
        message(STATUS "[LITERTLM] Applying Root-Level Global Shims...")

        # We use a pure-prepended block. No regex replacement of original text.
        set(ROOT_SHIM "
# --- LITERTLM_ROOT_SHIM ---
# This block MUST be at the top to ensure global visibility
cmake_minimum_required(VERSION 3.16) # Ensure a base version is set if we are at line 1

if(NOT TARGET LiteRTLM::absl::absl)
    add_library(LiteRTLM::absl::absl INTERFACE IMPORTED GLOBAL)
    set_target_properties(LiteRTLM::absl::absl PROPERTIES 
        INTERFACE_LINK_LIBRARIES \"-Wl,--start-group;${ABSL_LIBS_FLAT};-Wl,--end-group\"
        INTERFACE_INCLUDE_DIRECTORIES \"${ABSL_INCLUDE_DIR}\")
endif()

if(NOT TARGET LiteRTLM::flatbuffers::flatbuffers)
    add_library(LiteRTLM::flatbuffers::flatbuffers STATIC IMPORTED GLOBAL)
    set_target_properties(LiteRTLM::flatbuffers::flatbuffers PROPERTIES
        IMPORTED_LOCATION \"${FLATBUFFERS_LIB_DIR}/libflatbuffers.a\"
        INTERFACE_INCLUDE_DIRECTORIES \"${FLATBUFFERS_INCLUDE_DIR}\")
endif()

if(NOT TARGET flatc)
    add_executable(flatc IMPORTED GLOBAL)
    set_target_properties(flatc PROPERTIES IMPORTED_LOCATION \"${FLATC_EXECUTABLE}\")
endif()

# Global Hammer for headers and linking
link_libraries(\"-Wl,--start-group;${ABSL_LIBS_FLAT};-Wl,--end-group\")
include_directories(SYSTEM \"${ABSL_INCLUDE_DIR}\")

# Define target-level redirection targets for sub-projects
if(NOT TARGET flatbuffers::flatbuffers)
    add_library(flatbuffers::flatbuffers INTERFACE IMPORTED GLOBAL)
    target_link_libraries(flatbuffers::flatbuffers INTERFACE LiteRTLM::flatbuffers::flatbuffers)
endif()
# --------------------------\n\n")

        # Prepending is safer than regex replacing the project line
        file(WRITE "${ROOT_LIST}" "${ROOT_SHIM}${ROOT_CONTENT}")
    endif()
endif()


# --- 3. TARGET REDIRECTION (THE SURGICAL FIX) ---
file(GLOB_RECURSE ALL_CMAKELISTS "${LITERT_INTERNAL_ROOT}/*.cmake" "${LITERT_INTERNAL_ROOT}/CMakeLists.txt")

foreach(C_FILE ${ALL_CMAKELISTS})
    # SAFETY: Do not patch the root CMakeLists.txt! 
    # It contains our definitions. Patching it will mangle the shim.
    if("${C_FILE}" STREQUAL "${ROOT_LIST}")
        continue()
    endif()

    # Redirect modular internal calls to our global shims
    patch_file_content("${C_FILE}" "absl::[a-zA-Z0-9_]+" "LiteRTLM::absl::absl" TRUE)
    patch_file_content("${C_FILE}" "flatbuffers::flatbuffers" "LiteRTLM::flatbuffers::flatbuffers" FALSE)
    
    # Kill hardcoded TFLite _deps paths specifically
    patch_file_content("${C_FILE}" ".*/_deps/flatbuffers-build/libflatbuffers.a" "LiteRTLM::flatbuffers::flatbuffers" TRUE)
endforeach()

# --- 4. SURGICAL COMPILATION FIXES (ORDER: LAST) ---
patch_file_content("${LITERT_INTERNAL_ROOT}/runtime/compiled_model.cc" 
    " return litert_cpu_buffer_requirements" 
    "return litert::Expected<const LiteRtTensorBufferRequirementsT*>(litert_cpu_buffer_requirements)" FALSE)

patch_file_content("${ROOT_LIST}" "add_subdirectory(compiler_plugin)" "add_subdirectory(compiler)" FALSE)

# Lobotomize Vendors
set(V_LIST "${LITERT_INTERNAL_ROOT}/vendors/CMakeLists.txt")
if(EXISTS "${V_LIST}")
patch_file_content("${V_LIST}" "message\\(FATAL_ERROR \"FlatBuffers 'flatc' target not available[^\"]*\"\\)" "message(STATUS \"Bypassing flatc\")" TRUE)
file(READ "${V_LIST}" V_CONTENT)
    if(NOT V_CONTENT MATCHES "LITERT_ENABLE_QUALCOMM")
        file(WRITE "${V_LIST}" "if(NOT LITERT_ENABLE_QUALCOMM)\n  return()\nendif()\n\n${V_CONTENT}")
    endif()
endif()

message(STATUS "[LITERTLM] Patching Complete.")
