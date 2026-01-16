include(ExternalProject)

# =========================================================
#  1. Path & Environment Setup
# =========================================================
set(LITERT_EXT_PREFIX    ${EXTERNAL_PROJECT_BINARY_DIR}/litert)

set(LITERT_BUILD_DIR     ${LITERT_EXT_PREFIX}/src/litert_external-build)
set(LITERT_SOURCE_DIR    ${LITERT_EXT_PREFIX}/src/litert_external)
set(LITERT_INCLUDE_PATHS
  ${LITERT_SOURCE_DIR}
  ${LITERT_BUILD_DIR}/include
  ${LITERT_BUILD_DIR}/c/include
  ${LITERT_BUILD_DIR}/cc/include
  ${LITERT_BUILD_DIR}/compiler/include
  ${LITERT_BUILD_DIR}/core/include
  ${LITERT_BUILD_DIR}/runtime/include
)

# =========================================================
#  2. Construct Compiler Flags (The "dirty work")
# =========================================================
# Start with standard flags + permissive mode
set(LITERT_CXX_FLAGS_Construct "${CMAKE_CXX_FLAGS} -fpermissive")

# Inject OpenCL Headers if present
if(OPENCL_INCLUDE_DIR)
  string(APPEND LITERT_CXX_FLAGS_Construct " -isystem ${OPENCL_INCLUDE_DIR}")
endif()

# Inject the OpenCL "Type Mocks" to satisfy the compiler
# We define these types as void* or ulong to match the binary ABI without headers.
# string(APPEND LITERT_CXX_FLAGS_Construct " \
#   -Dcl_command_buffer_khr=void* \
#   -Dcl_command_buffer_properties_khr=cl_ulong \
#   -Dcl_ndrange_kernel_command_properties_khr=cl_ulong \
#   -Dcl_sync_point_khr=void* \
#   -Dcl_mutable_command_khr=void* \
#   -Dcl_command_buffer_info_khr=cl_uint")

# =========================================================
#  3. The External Project Definition
# =========================================================
ExternalProject_Add(
  litert_external
  DEPENDS
    opencl_headers_external
    absl_external
    protobuf_external
    flatbuffers_external
    tflite_external

  GIT_REPOSITORY
    https://github.com/google-ai-edge/LiteRT.git
  GIT_TAG
    v2.1.0
  GIT_SUBMODULES ""
  GIT_SUBMODULES_RECURSE FALSE
  PREFIX
    ${LITERT_EXT_PREFIX}
  SOURCE_SUBDIR
    litert

  # ---------------------------------------------------------
  #  PATCHES
  # ---------------------------------------------------------
  PATCH_COMMAND 
    git checkout -- . && git clean -df

    COMMAND ${CMAKE_COMMAND} 
    -DFLATC_EXECUTABLE=${FLATC_EXECUTABLE} 
    -DFLATBUFFERS_LIB_DIR=${FLATBUFFERS_LIB_DIR}
    -DTFLITE_SRC_DIR=${TFLITE_SRC_DIR} 
    -DTFLITE_BUILD_DIR=${TFLITE_BUILD_DIR}
    -DTENSORFLOW_SOURCE_DIR=${TENSORFLOW_SOURCE_DIR}
    -DLITERTLM_RECIPES_DIR=${LITERTLM_RECIPES_DIR}
    -DLITERTLM_MODULES_DIR=${LITERTLM_MODULES_DIR}
    -DLITERT_SOURCE_DIR=${LITERT_SOURCE_DIR}
    -DABSL_LIBS_FLAT=${ABSL_LIBS_FLAT}
    -DABSL_INCLUDE_DIR=${ABSL_INCLUDE_DIR}
    -DOPENCL_INCLUDE_DIR=${OPENCL_INCLUDE_DIR}
    -DJSON_INCLUDE_DIR=${JSON_SRC_DIR}

    -P "${PROJECT_ROOT}/cmake/recipes/litert/litert_patcher.cmake"





  # ---------------------------------------------------------
  #  CMAKE ARGUMENTS
  # ---------------------------------------------------------
  CMAKE_ARGS
    # Core Settings
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
    -DCMAKE_POLICY_DEFAULT_CMP0170=OLD
    
    # Toolchain & Standard
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
    -DCMAKE_CXX_STANDARD_REQUIRED=ON
    -DCMAKE_CXX_EXTENSIONS=OFF
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    

    "-DCMAKE_PREFIX_PATH=${ABSL_INSTALL_PREFIX};${TFLITE_INSTALL_PREFIX};${PROTOBUF_INSTALL_PREFIX};${FLATBUFFERS_INSTALL_PREFIX}"

    "-DCMAKE_CXX_FLAGS:STRING=${LITERT_CXX_FLAGS_Construct} -isystem ${TFLITE_INSTALL_PREFIX}/include -isystem ${ABSL_INSTALL_PREFIX}/include -isystem ${PROTOBUF_INSTALL_PREFIX}/include -w"
    "-DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS} -isystem ${TFLITE_INSTALL_PREFIX}/include"

    "-DXNNPACK_INCLUDE_DIR=${TFLITE_INSTALL_PREFIX}/include"


    # OpenCL Versioning
    -DCL_TARGET_OPENCL_VERSION=220
    -DCL_HPP_TARGET_OPENCL_VERSION=220
    -DCL_HPP_MIN_TARGET_OPENCL_VERSION=220

    # Dependency Injection: Abseil
    "-D_abseil-cpp_LICENSE_FILE:FILEPATH=${ABSL_EXT_PREFIX}/src/absl_external/LICENSE"
    "-DFETCHCONTENT_SOURCE_DIR_ABSEIL-CPP=${ABSL_EXT_PREFIX}/src/absl_external"
    -Dabsl_SOURCE_DIR=${ABSL_SRC_DIR}
    -Dabsl_BINARY_DIR=${ABSL_BUILD_DIR}
    -Dabsl_INCLUDE_DIR=${ABSL_INCLUDE_DIR}
    -DABSL_LIBRARIES=${ABSL_LIB_DIR}
    -Dabsl_DIR=${ABSL_LIB_DIR}/cmake/absl

    # FlatBuffers
    -DFLATBUFFERS_BUILD_FLATC=OFF
    -DFLATBUFFERS_INSTALL=OFF
    -DFLATBUFFERS_PROJECT_DIR=${FLATBUFFERS_SRC_DIR}/flatbuffers_external
    -DFlatBuffers_BINARY_DIR=${FLATBUFFERS_BIN_DIR}
    -DFlatBuffers_SOURCE_DIR=${FLATBUFFERS_SRC_DIR}/flatbuffers_external
    -D_flatbuffers_LICENSE_FILE:FILEPATH=${FLATBUFFERS_SRC_DIR}/flatbuffers_external/LICENSE
    -DFLATC_PATHS=${FLATBUFFERS_BIN_DIR}
    -DFLATBUFFERS_FLATC_EXECUTABLE=${FLATC_EXECUTABLE}
    -DFLATC_EXECUTABLE=${FLATC_EXECUTABLE}
    -Dflatbuffers_DIR=${FLATBUFFERS_INSTALL_PREFIX}/lib/cmake/flatbuffers
    -DFETCHCONTENT_SOURCE_DIR_FLATBUFFERS=${FLATBUFFERS_SRC_DIR}/flatbuffers_external
    "-DFLATBUFFERS_INSTALL_PREFIX=${FLATBUFFERS_INSTALL_PREFIX}"
    "-DFLATBUFFERS_LIB_DIR=${FLATBUFFERS_INSTALL_PREFIX}/lib"

    # Dependency Injection: TFLite
    -DTFLite_DIR=${TFLITE_INSTALL_PREFIX}/lib
    -Dtensorflow-lite_DIR=${TFLITE_INSTALL_PREFIX}/lib
    -DTFLITE_BUILD_DIR=${TFLITE_BUILD_DIR}
    -DTFLITE_SOURCE_DIR=${TFLITE_SRC_DIR}
    -DTENSORFLOW_SOURCE_DIR=${TENSORFLOW_SOURCE_DIR}

    # LiteRT Feature Switches
    -DLITERT_AUTO_BUILD_TFLITE=OFF
    -DTFLITE_ENABLE_INSTALL=OFF
    -DTFLITE_ENABLE_XNNPACK=ON
    -DTFLITE_ENABLE_RESOURCE_VARIABLE=OFF
    -DXNNPACK_SET_VERBOSITY=OFF
    -DTFLITE_ENABLE_GPU=OFF
    -DLITERT_ENABLE_GPU=OFF 
    -DLITERT_ENABLE_NPU=OFF
    -DLITERT_ENABLE_QUALCOMM=OFF    
    -DLITERT_DISABLE_KLEIDIAI=OFF
    -DLITERT_BUILD_C_API=ON
    -DLITERT_BUILD_TOOLS=OFF
    "-DCMAKE_SHARED_LINKER_FLAGS=${ABSL_LINK_FLAGS}"
    "-DCMAKE_EXE_LINKER_FLAGS=-L${ABSL_LIB_DIR} -L${PROTO_LIB_DIR} -L${FLATBUFFERS_LIB_DIR} -L${TFLITE_LIB_DIR}"
    "-DLITERTLM_RECIPES_DIR=${LITERTLM_RECIPES_DIR}"
    "-DJSON_INCLUDE_DIR=${JSON_SRC_DIR}"
  INSTALL_COMMAND ""
)

# ==============================================================================
# IMPORT STATIC LIBRARIES
# ==============================================================================


# --- C++ API (The Wrappers) ---
import_static_lib(imp_litert_cc_api          "${LITERT_BUILD_DIR}/cc/liblitert_cc_api.a")
# This ONE lib contains gpu_options, mediatek_options, etc.
import_static_lib(imp_litert_cc_options      "${LITERT_BUILD_DIR}/cc/options/liblitert_cc_options.a")


# --- C API (The Implementations) ---
import_static_lib(imp_litert_c_api           "${LITERT_BUILD_DIR}/c/liblitert_c_api.a")
import_static_lib(imp_litert_c_options       "${LITERT_BUILD_DIR}/c/options/liblitert_c_options.a")
import_static_lib(imp_litert_logging         "${LITERT_BUILD_DIR}/c/liblitert_logging.a")

# --- Core & Runtime ---
import_static_lib(imp_litert_compiler_plugins "${LITERT_BUILD_DIR}/compiler/liblitert_compiler_plugin.a")
import_static_lib(imp_litert_core            "${LITERT_BUILD_DIR}/core/liblitert_core.a")
import_static_lib(imp_litert_core_model      "${LITERT_BUILD_DIR}/core/model/liblitert_core_model.a")
import_static_lib(imp_litert_runtime         "${LITERT_BUILD_DIR}/runtime/liblitert_runtime.a")


import_static_lib(imp_qnn_context_binary_info "${LITERT_BUILD_DIR}/vendors/qualcomm/libqnn_context_binary_info.a")
import_static_lib(imp_qnn_manager "${LITERT_BUILD_DIR}/vendors/qualcomm/libqnn_manager.a")




# ==============================================================================
# MAIN TARGET
# ==============================================================================
add_library(litert_libs INTERFACE)
target_include_directories(litert_libs SYSTEM INTERFACE 
  ${LITERT_INCLUDE_PATHS}
)

target_link_libraries(litert_libs INTERFACE
  $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--start-group>
    imp_litert_cc_api
    imp_litert_cc_options

    imp_litert_c_api
    imp_litert_c_options

    imp_litert_compiler_plugins
    imp_litert_core
    imp_litert_core_model
    imp_litert_runtime
    imp_litert_logging

    tflite_libs
    farmhash
    proto_lib
    flatbuffers_libs
    absl_libs  
  $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--end-group>
  tflite_libs
  farmhash
  proto_lib
  flatbuffers_libs
  absl_libs  
)
