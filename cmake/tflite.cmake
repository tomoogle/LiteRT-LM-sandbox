include(ExternalProject)

ExternalProject_Add(
    litert_external 
    GIT_REPOSITORY      https://github.com/tensorflow/tensorflow.git
    GIT_TAG             v2.20.0
    PREFIX              ${CMAKE_CURRENT_BINARY_DIR}/tensorflow
    SOURCE_SUBDIR       tensorflow/lite
    PATCH_COMMAND       git apply --ignore-space-change --ignore-whitespace "${PATCH_FILE}" || ${CMAKE_COMMAND} -E echo "Git apply failed (or not needed)..."
    CMAKE_ARGS          
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> 
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
)




# --- TFLite Libs ---
set(TFLITE_PROFILING_SRC_DIR 
    "${CMAKE_BINARY_DIR}/litert/src/litert_external/tflite/profiling"
)

set(TFLITE_PROFILING_SOURCES
    "${TFLITE_PROFILING_SRC_DIR}/memory_usage_monitor.cc"
    "${TFLITE_PROFILING_SRC_DIR}/memory_info.cc"
)

add_library(tflite_profiling_monitor STATIC ${TFLITE_PROFILING_SOURCES})
target_include_directories(tflite_profiling_monitor 
    PRIVATE
        ${LITERT_INCLUDE_DIR}
        ${_LITERT_SRC_DIR}
        ${_LITERT_ABSL_SRC_DIR}
)
target_link_libraries(tflite_profiling_monitor PRIVATE
    absl_synchronization_libs
    absl_time_libs
    litert_logging 
    tensorflow-lite
    m pthread
)
add_dependencies(tflite_profiling_monitor litert_external)




add_library(tflite_extra_libs INTERFACE)
target_link_libraries(tflite_extra_libs INTERFACE
  tflite_profiling_monitor
)