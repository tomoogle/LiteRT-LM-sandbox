include(ExternalProject)
set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

set(LITERT_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/litert)
set(LITERT_INSTALL_PREFIX ${LITERT_EXT_PREFIX}/install)
set(LITERT_INCLUDE_DIR ${LITERT_INSTALL_PREFIX}/include)

set(LITERT_CONFIG_CMAKE_FILE "${LITERT_INSTALL_PREFIX}/lib/cmake/litert/litert-config.cmake")

set(TENSORFLOW_SOURCE_DIR
  ${TFLITE_SRC_DIR}
  ${TFLITE_SRC_DIR}/tflite_external
  ${TFLITE_SRC_DIR}/tflite_external/tensorflow
)

ExternalProject_Add(
  litert_external
  DEPENDS
    opencl_headers_external
    absl_external
    protobuf_external
    sentencepiece_external
    tokenizers-cpp_external
    flatbuffers_external
    tflite_external
  GIT_REPOSITORY
    https://github.com/google-ai-edge/LiteRT.git
  GIT_TAG
    main
  PREFIX
    ${LITERT_EXT_PREFIX}
  SOURCE_SUBDIR
    litert
  

  PATCH_COMMAND 
    sed -i "s/ return litert_cpu_buffer_requirements/return litert::Expected<const LiteRtTensorBufferRequirementsT*>(litert_cpu_buffer_requirements)/" <SOURCE_DIR>/litert/runtime/compiled_model.cc
    
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${LITERT_INSTALL_PREFIX}
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
    -DCMAKE_POLICY_DEFAULT_CMP0170=OLD
    
    # Force C++17 across the board
    -DCMAKE_CXX_STANDARD=17
    -DCMAKE_CXX_STANDARD_REQUIRED=ON
    -DCMAKE_CXX_EXTENSIONS=OFF
    "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -fpermissive -DCL_TARGET_OPENCL_VERSION=220 -Dcl_command_buffer_khr=void* -DPFN_clFinalizeCommandBufferKHR=void* -DPFN_clCommandNDRangeKernelKHR=void* -DPFN_clGetCommandBufferInfoKHR=void*
      -isystem ${OPENCL_INCLUDE_DIR}"
    "-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}" 
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    -DCL_TARGET_OPENCL_VERSION=220
    -DCL_HPP_TARGET_OPENCL_VERSION=220
    -DCL_HPP_MIN_TARGET_OPENCL_VERSION=220

# //Value Computed by CMake
# FlatBuffers_BINARY_DIR:STATIC=/usr/local/code/github/LiteRT-LM/cmake/build/external/litert/src/litert_external-build/_deps/flatbuffers-build

# //Value Computed by CMake
# FlatBuffers_IS_TOP_LEVEL:STATIC=OFF

# //Value Computed by CMake
# FlatBuffers_SOURCE_DIR:STATIC=/usr/local/code/github/LiteRT-LM/cmake/build/external/litert/src/litert_external-build/_deps/flatbuffers-src



    # --- Dependency Injection ---
    # Injecting the LICENSE variable to bypass the internal check
    "-D_abseil-cpp_LICENSE_FILE:FILEPATH=${ABSL_EXT_PREFIX}/src/absl_external/LICENSE"
    
    # --- Abseil Configuration ---
    # Pointing to the SOURCE directory for the internal fetcher override
    "-DFETCHCONTENT_SOURCE_DIR_ABSEIL_CPP=${ABSL_EXT_PREFIX}/src/absl_external"
    -Dabsl_SOURCE_DIR=${ABSL_EXT_PREFIX}/src/absl_external
    -Dabsl_BINARY_DIR=${ABSL_EXT_PREFIX}/absl_external-build
    -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
    # -DABSL_LIBRARIES:STRING=${ABSL_INSTALL_PREFIX}/lib


    # --- Flatbuffers Configuration ---
    # -DFLATBUFFERS_INSTALL=OFF
    # -DFLATBUFFERS_BUILD_TESTS=OFF


    -Dflatbuffers_DIR=${FLATBUFFERS_INSTALL_PREFIX}/lib/cmake/flatbuffers
    
    # --- TFLite Configuration ---
    -DTFLite_DIR=${TFLITE_INSTALL_PREFIX}/lib/cmake/tensorflow-lite
    -Dtensorflow-lite_DIR=${TFLITE_INSTALL_PREFIX}/lib/cmake/tensorflow-lite
    -DTFLITE_BUILD_DIR=${TFLITE_BUILD_DIR}
    -DTFLITE_SOURCE_DIR=${TFLITE_SRC_DIR}

    -DLITERT_AUTO_BUILD_TFLITE=OFF
    -DTFLITE_ENABLE_INSTALL=OFF
    -DTFLITE_ENABLE_XNNPACK=ON
    -DTFLITE_ENABLE_RESOURCE_VARIABLE=OFF
    -DXNNPACK_SET_VERBOSITY=OFF
    -DTFLITE_ENABLE_GPU=OFF  # <--- Add this
    -DLITERT_ENABLE_GPU=OFF   # <--- And this to be safe
    -DLITERT_ENABLE_NPU=OFF
    -DLITERT_ENABLE_QUALCOMM=OFF    
# THE FIX: Add the new mocks for PFN_ types to the flag string

    # --- LiteRT Configuration ---
    -DLITERT_DISABLE_KLEIDIAI=OFF
    -DLITERT_BUILD_C_API=ON
  


)


import_static_lib(imp_tflite          "${LITERT_BUILD_ROOT}/libtensorflow-lite.a")
import_static_lib(imp_litert_runtime  "${LITERT_BUILD_ROOT}/liblitert_runtime.a")
import_static_lib(imp_litert_c_api    "${LITERT_BUILD_ROOT}/liblitert_c_api.a")
import_static_lib(imp_litert_core     "${LITERT_BUILD_ROOT}/liblitert_core.a")
import_static_lib(imp_litert_logging  "${LITERT_BUILD_ROOT}/liblitert_logging.a")
import_static_lib(imp_xnnpack         "${LITERT_BUILD_ROOT}/_deps/xnnpack-build/libXNNPACK.a") 
