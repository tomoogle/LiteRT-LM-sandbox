# tflite_patcher.cmake

message(STATUS "[LITERTLM PATCHER] Starting surgical orchestration...")

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
file(GLOB_RECURSE ALL_CMAKELISTS "${TFLITE_SRC_DIR}/CMakeLists.txt")

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


# --- AUTOMATED XNNPACK LOBOTOMY ---
set(XNNPACK_MOD_FILE "${TFLITE_SRC_DIR}/tools/cmake/modules/xnnpack/CMakeLists.txt")

if(EXISTS "${XNNPACK_MOD_FILE}")
    message(STATUS "[LITERTLM] Automating XNNPACK path neutralization...")
    
    # We append the surgical strike to the end of the module file.
    # This ensures it runs every time TFLite configures XNNPACK.
    file(APPEND "${XNNPACK_MOD_FILE}" "
# --- LiteRT-LM Automated Fix ---
execute_process(
    COMMAND find \"\${xnnpack_SOURCE_DIR}\" -type f -exec sed -i \"s|flatbuffers-flatc/bin/flatc|\${FLATBUFFERS_FLATC_EXECUTABLE}|g\" {} +
)
")
endif()


# --- THE ULTIMATE XNNPACK DELEGATE FIX ---
set(XNN_DELEGATE_CMAKELISTS "${TFLITE_SRC_DIR}/CMakeLists.txt")

if(EXISTS "${XNN_DELEGATE_CMAKELISTS}")
    message(STATUS "[LITERTLM] Hard-patching XNNPACK delegate custom command...")
    
    # We replace the variable usage with the actual absolute path to bypass 
    # any logic that might be resetting the variable to a relative path.
    execute_process(
        COMMAND sed -i "s|\"\${FLATBUFFERS_FLATC_EXECUTABLE}\"|\"${FLATC_EXECUTABLE}\"|g" "${XNN_DELEGATE_CMAKELISTS}"
        COMMAND sed -i "s|\"\${FLATC_TARGET}\"|\"${FLATC_EXECUTABLE}\"|g" "${XNN_DELEGATE_CMAKELISTS}"
    )
endif()


# --- 5. Final Root Injection ---
# Inject our shim at the very top of the TFLite root
set(ROOT_LIST "${TFLITE_SRC_DIR}/CMakeLists.txt")
file(READ "${ROOT_LIST}" CONTENT)
set(INJECTION "include(${LITERTLM_RECIPES_DIR}/tflite/tflite_shims.cmake)\n")
file(WRITE "${ROOT_LIST}" "${INJECTION}${CONTENT}")

message(STATUS "[LITERTLM PATCHER] Orchestration complete.")



# --- 1. Define Surgery Paths ---
# set(XNN_DIR "${TENSORFLOW_SOURCE_DIR}/tensorflow/lite/")
set(XNN_CMAKELISTS "${TFLITE_SRC_DIR}/CMakeLists.txt")

message(STATUS "[LITERTLM] Performing manual XNNPACK schema generation...")

# --- 2. Generate the file OURSELVES ---
# We run this during the patch phase so the file is ready before configuration
execute_process(
    COMMAND "${FLATC_EXECUTABLE}" -c 
            -o "${TFLITE_SRC_DIR}/" 
            --gen-mutable --gen-object-api 
            "${TFLITE_SRC_DIR}/delegates/xnnpack/weight_cache_schema.fbs"
    RESULT_VARIABLE manual_gen_res
)

if(NOT manual_gen_res EQUAL 0)
    message(FATAL_ERROR "LITERTLM: Manual flatc generation failed! Path: ${FLATC_EXECUTABLE}")
endif()

# --- 3. Lobotomize the TFLite/XNNPACK logic ---
# We delete the specific add_custom_command block so CMake stops trying to be 'helpful'
execute_process(
    COMMAND sed -i "/add_custom_command(/,/)/d" "${XNN_CMAKELISTS}"
)

# --- 4. Handle the Build-Tree 'Stutter' ---
# TFLite expects the file to also exist in the build directory. We'll put it there.
file(MAKE_DIRECTORY "${TFLITE_SRC_DIR}/delegates/xnnpack")
file(COPY "${TFLITE_SRC_DIR}/weight_cache_schema_generated.h" 
     DESTINATION "${TFLITE_BUILD_DIR}/tensorflow/lite/delegates/xnnpack")


set(PROTO_RECORDS 
    "tensorflow/lite/profiling/proto/CMakeLists.txt:profiling_info.proto"
    "tensorflow/lite/tools/benchmark/proto/CMakeLists.txt:benchmark_result.proto"
)

foreach(RECORD ${PROTO_RECORDS})
    string(REPLACE ":" ";" FIELDS ${RECORD})
    list(GET FIELDS 0 PLIST)
    list(GET FIELDS 1 PFILE)
    
    set(TARGET_LIST "${TENSORFLOW_SOURCE_DIR}/${PLIST}")
    
    if(EXISTS "${TARGET_LIST}")
        message(STATUS "[LITERTLM] Applying surgical fix to ${PLIST}...")

        # Get the directory part of the PLIST (e.g., tensorflow/lite/profiling/proto)
        get_filename_component(PDIR "${PLIST}" DIRECTORY)

        # 1. Force the --proto_path to the repo root
        execute_process(COMMAND sed -i "s|--proto_path=[^ ]*|--proto_path=${TENSORFLOW_SOURCE_DIR}|g" "${TARGET_LIST}")

        # 2. Fix the input file path ONLY in COMMAND/DEPENDS arguments
        # We use the absolute path we constructed: ${TENSORFLOW_SOURCE_DIR}/${PDIR}/${PFILE}
        execute_process(COMMAND sed -i "s| [^ ]*${PFILE}| ${TENSORFLOW_SOURCE_DIR}/${PDIR}/${PFILE}|g" "${TARGET_LIST}")
        
        # 3. Final cleanup for any stray 'tflite/' prefixes
        execute_process(COMMAND sed -i "s|tflite/|tensorflow/lite/|g" "${TARGET_LIST}")
    endif()
endforeach()