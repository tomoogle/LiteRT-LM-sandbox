# tflite_patcher.cmake
# This script is executed by PATCH_COMMAND to clean and prepare the TFLite tree.

message(STATUS "[LITERTLM PATCHER] Starting surgical orchestration...")

# --- 1. The Nuclear Reset ---
# We do this first to ensure the script is idempotent (can run multiple times safely)
execute_process(COMMAND git checkout -- . WORKING_DIRECTORY "${TENSORFLOW_SOURCE_DIR}")
execute_process(COMMAND git clean -df WORKING_DIRECTORY "${TENSORFLOW_SOURCE_DIR}")

# --- 2. Version Compatibility Patches ---
# Fixes the strict version checks that break modern Flatbuffers usage
set(V_FILES 
    "tensorflow/lite/acceleration/configuration/configuration_generated.h"
    "tensorflow/compiler/mlir/lite/schema/schema_generated.h"
)

foreach(V_FILE ${V_FILES})
    set(FULL_PATH "${TENSORFLOW_SOURCE_DIR}/${V_FILE}")
    if(EXISTS "${FULL_PATH}")
        file(READ "${FULL_PATH}" CONTENT)
        string(REGEX REPLACE "FLATBUFFERS_VERSION_MAJOR == [0-9]+" "FLATBUFFERS_VERSION_MAJOR >= 24" CONTENT "${CONTENT}")
        string(REGEX REPLACE "FLATBUFFERS_VERSION_MINOR == [0-9]+" "FLATBUFFERS_VERSION_MINOR >= 0" CONTENT "${CONTENT}")
        file(WRITE "${FULL_PATH}" "${CONTENT}")
    endif()
endforeach()

# --- 3. Kill the Internal Downloaders ---
# We force these modules to return immediately so they don't overwrite our injected deps
set(MODULES "abseil-cpp.cmake" "protobuf.cmake" "flatbuffers.cmake")
foreach(MOD ${MODULES})
    set(MOD_PATH "${TENSORFLOW_SOURCE_DIR}/tensorflow/lite/tools/cmake/modules/${MOD}")
    if(EXISTS "${MOD_PATH}")
        file(WRITE "${MOD_PATH}" "return()\n")
    endif()
endforeach()

# --- 4. The Global Redirection (The Hammer) ---
# Recursively replace dependency namespaces with our Shimmed namespaces
file(GLOB_RECURSE ALL_CMAKELISTS "${TENSORFLOW_SOURCE_DIR}/tensorflow/lite/CMakeLists.txt")

foreach(C_FILE ${ALL_CMAKELISTS})
    file(READ "${C_FILE}" CONTENT)
    
    # Replace Abseil
    string(REGEX REPLACE "[ \t]absl::[a-zA-Z0-9_]+" " LiteRTLM::absl::absl" CONTENT "${CONTENT}")
    # Replace Protobuf
    string(REGEX REPLACE "[ \t]protobuf::[a-zA-Z0-9_-]+" " LiteRTLM::protobuf::libprotobuf" CONTENT "${CONTENT}")
    # Replace Flatbuffers
    string(REGEX REPLACE "[ \t]flatbuffers::[a-zA-Z0-9_-]+" " LiteRTLM::flatbuffers::flatbuffers" CONTENT "${CONTENT}")
    
    file(WRITE "${C_FILE}" "${CONTENT}")
endforeach()

# --- 5. Final Root Injection ---
# Inject our shim at the very top of the TFLite root
set(ROOT_LIST "${TENSORFLOW_SOURCE_DIR}/tensorflow/lite/CMakeLists.txt")
file(READ "${ROOT_LIST}" CONTENT)
set(INJECTION "include(\"${LITERTLM_SHIMS_DIR}/tflite/tflite_shim.cmake\")\n")
file(WRITE "${ROOT_LIST}" "${INJECTION}${CONTENT}")

message(STATUS "[LITERTLM PATCHER] Orchestration complete.")