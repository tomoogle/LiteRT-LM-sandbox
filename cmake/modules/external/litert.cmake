include(ExternalProject)
set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

set(LITERT_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/litert)
set(LITERT_INSTALL_PREFIX ${LITERT_EXT_PREFIX}/install)
set(LITERT_INCLUDE_DIR ${LITERT_INSTALL_PREFIX}/include)

set(LITERT_CONFIG_CMAKE_FILE "${LITERT_INSTALL_PREFIX}/lib/cmake/litert/litert-config.cmake")

ExternalProject_Add(
  litert_external
  DEPENDS
    absl_external
  GIT_REPOSITORY
    https://github.com/google-ai-edge/LiteRT.git
  GIT_TAG
    08735bb886df5e3e1294604c61175efbc72c59dd
  PREFIX
    ${LITERT_EXT_PREFIX}
  SOURCE_SUBDIR
    litert
  

  PATCH_COMMAND 
    sed -i "s/ return litert_cpu_buffer_requirements/return litert::Expected<const LiteRtTensorBufferRequirementsT*>(litert_cpu_buffer_requirements)/" <SOURCE_DIR>/litert/runtime/compiled_model.cc
    
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${TFLITE_INSTALL_PREFIX}
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
    -DCMAKE_POLICY_DEFAULT_CMP0170=OLD
    
    # Force C++17 across the board
    -DCMAKE_CXX_STANDARD=17
    -DCMAKE_CXX_STANDARD_REQUIRED=ON
    -DCMAKE_CXX_EXTENSIONS=OFF
    
    # Pass your global flags (including -fpermissive just in case)
    "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -fpermissive"
    "-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}" 
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON



    # --- Dependency Injection ---
    # Injecting the LICENSE variable to bypass the internal check
    "-D_abseil-cpp_LICENSE_FILE:FILEPATH=${ABSL_EXT_PREFIX}/src/absl_external/LICENSE"
    
    # --- Abseil Configuration ---
    # Pointing to the SOURCE directory for the internal fetcher override
    "-DFETCHCONTENT_SOURCE_DIR_ABSEIL_CPP=${ABSL_EXT_PREFIX}/src/absl_external"
    "-Dabseil-cpp_SOURCE_DIR=${ABSL_EXT_PREFIX}/src/absl_external"
    
    -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
    -Dabseil-cpp_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl


    # --- Flatbuffers Configuration ---
    # -DFLATBUFFERS_INSTALL=OFF
    # -DFLATBUFFERS_BUILD_TESTS=OFF


    -Dflatbuffers_DIR=${FLATBUFFERS_INSTALL_PREFIX}/lib/cmake/flatbuffers
    
    # --- TFLite Configuration ---
    -DLITERT_AUTO_BUILD_TFLITE=OFF
    -DTFLITE_ENABLE_INSTALL=OFF
    -DTFLITE_ENABLE_XNNPACK=ON
    -DTFLITE_ENABLE_RESOURCE_VARIABLE=OFF
    -DXNNPACK_SET_VERBOSITY=OFF
    
    # Manual Version Injection
    "-DEXTRA_CXX_FLAGS=-DTF_MAJOR_VERSION=2 -DTF_MINOR_VERSION=20 -DTF_PATCH_VERSION=0 -DTF_VERSION_SUFFIX=\"\""

    # --- LiteRT Configuration ---
    -DLITERT_DISABLE_KLEIDIAI=OFF
    -DLITERT_BUILD_C_API=ON
    -DLITERT_ENABLE_GPU=OFF
    -DLITERT_ENABLE_NPU=OFF
  


)


import_static_lib(imp_tflite          "${LITERT_BUILD_ROOT}/libtensorflow-lite.a")
import_static_lib(imp_litert_runtime  "${LITERT_BUILD_ROOT}/liblitert_runtime.a")
import_static_lib(imp_litert_c_api    "${LITERT_BUILD_ROOT}/liblitert_c_api.a")
import_static_lib(imp_litert_core     "${LITERT_BUILD_ROOT}/liblitert_core.a")
import_static_lib(imp_litert_logging  "${LITERT_BUILD_ROOT}/liblitert_logging.a")
import_static_lib(imp_xnnpack         "${LITERT_BUILD_ROOT}/_deps/xnnpack-build/libXNNPACK.a") 
