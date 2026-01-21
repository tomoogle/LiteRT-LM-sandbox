# ==============================================================================
# LiteRT-LM Flatbuffers Shim
# Purpose: Neutralize TFLite internal discovery and force pre-built tools.
# ==============================================================================

# --- 1. GLOBAL VARIABLE OVERRIDES (The "Nuclear" Option) ---
# We use CACHE INTERNAL FORCE to ensure these cannot be overwritten by TFLite's
# internal set() calls or find_program() logic.
set(FIXED_FLATC "${FLATC_EXECUTABLE}" CACHE INTERNAL "Forced" FORCE)

set(FLATC_TARGET                 "${FIXED_FLATC}" CACHE INTERNAL "Forced" FORCE)
set(FLATC_BIN                    "${FIXED_FLATC}" CACHE INTERNAL "Forced" FORCE)
set(FLATBUFFERS_FLATC_EXECUTABLE "${FIXED_FLATC}" CACHE INTERNAL "Forced" FORCE)
set(flatbuffers_FLATC_EXECUTABLE "${FIXED_FLATC}" CACHE INTERNAL "Forced" FORCE)

# Satisfy TFLite host tools check
set(TFLITE_HOST_TOOLS_DIR        "${FIXED_FLATC}" CACHE PATH     "Forced" FORCE)
set(FLATC_PATHS                  "${FIXED_FLATC}" CACHE STRING   "Forced" FORCE)

# Convince TFLite discovery that Flatbuffers is already present
set(flatbuffers_FOUND            TRUE             CACHE INTERNAL "Forced" FORCE)
set(FlatBuffers_FOUND            TRUE             CACHE INTERNAL "Forced" FORCE)


# --- 2. NAMESPACE TARGETS: flatbuffers::flatbuffers ---
if(NOT TARGET LiteRTLM::flatbuffers::flatbuffers)
    add_library(LiteRTLM::flatbuffers::flatbuffers INTERFACE IMPORTED GLOBAL)
    set_target_properties(LiteRTLM::flatbuffers::flatbuffers PROPERTIES 
        INTERFACE_LINK_LIBRARIES "imp_flatbuffers"
        INTERFACE_INCLUDE_DIRECTORIES "${FLATBUFFERS_INCLUDE_DIR}"
    )
    # Alias to the names TFLite expects
    if(NOT TARGET flatbuffers::flatbuffers)
        add_library(flatbuffers::flatbuffers ALIAS LiteRTLM::flatbuffers::flatbuffers)
    endif()
endif()


# --- 3. EXECUTABLE TARGETS: flatbuffers-flatc ---
# TFLite custom commands often DEPEND on these target names. 
# We mock them as IMPORTED targets pointing to our absolute binary path.
foreach(_target_name flatbuffers-flatc flatbuffers-flatc-NOTFOUND)
    if(NOT TARGET ${_target_name})
        add_executable(${_target_name} IMPORTED GLOBAL)
        set_target_properties(${_target_name} PROPERTIES 
            IMPORTED_LOCATION "${FIXED_FLATC}"
        )
    endif()
endforeach()


# --- THE GLOBAL DEPENDENCY STRIKE ---
# We target both the TFLite source AND the downloaded dependencies (like XNNPACK)

set(RELATIVE_PROBLEM_PATH "flatbuffers-flatc/bin/flatc")

# 1. Patch the TFLite Source
execute_process(
    COMMAND find "${TENSORFLOW_SOURCE_DIR}/tensorflow/lite" -name "*.cmake" -o -name "CMakeLists.txt" 
    -exec sed -i "s|${RELATIVE_PROBLEM_PATH}|${FLATC_EXECUTABLE}|g" {} +
)

# 2. Patch the Downloaded Dependencies (XNNPACK, etc.)
# Note: This only works if the dependencies have already been populated/downloaded
if(EXISTS "${TFLITE_BUILD_DIR}/_deps")
    execute_process(
        COMMAND find "${TFLITE_BUILD_DIR}/_deps" -name "*.cmake" -o -name "CMakeLists.txt" 
        -exec sed -i "s|${RELATIVE_PROBLEM_PATH}|${FLATC_EXECUTABLE}|g" {} +
    )
endif()

# ==============================================================================
# NOTE: All 'execute_process(sed ...)' calls have been removed.
# By being included at line 1 of the root CMakeLists.txt, the CACHE FORCE 
# variables above render the internal logic in kernels/ and root/ irrelevant.
# ==============================================================================