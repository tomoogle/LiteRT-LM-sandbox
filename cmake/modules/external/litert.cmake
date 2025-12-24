include(ExternalProject)

# =========================================================
#  1. Path & Environment Setup
# =========================================================
set(LITERT_EXT_PREFIX    ${EXTERNAL_PROJECT_BINARY_DIR}/litert)

set(LITERT_BUILD_DIR     ${LITERT_EXT_PREFIX}/src/litert_external-build)
set(LITERT_SOURCE_DIR    ${LITERT_EXT_PREFIX}/src/litert_external)
set(LITERT_INCLUDE_PATHS
  ${LITERT_SOURCE_DIR}
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
string(APPEND LITERT_CXX_FLAGS_Construct " \
  -Dcl_command_buffer_khr=void* \
  -Dcl_command_buffer_properties_khr=cl_ulong \
  -Dcl_ndrange_kernel_command_properties_khr=cl_ulong \
  -Dcl_sync_point_khr=void* \
  -Dcl_mutable_command_khr=void* \
  -Dcl_command_buffer_info_khr=cl_uint")

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
  PREFIX
    ${LITERT_EXT_PREFIX}
  SOURCE_SUBDIR
    litert

  # ---------------------------------------------------------
  #  PATCHES
  # ---------------------------------------------------------
  PATCH_COMMAND 
    # [A] Fix Compilation Errors (Return types & Missing dirs)
    sed -i "s/ return litert_cpu_buffer_requirements/return litert::Expected<const LiteRtTensorBufferRequirementsT*>(litert_cpu_buffer_requirements)/" <SOURCE_DIR>/litert/runtime/compiled_model.cc
    COMMAND sed -i "s|add_subdirectory(compiler_plugin)|add_subdirectory(compiler)|g" <SOURCE_DIR>/litert/CMakeLists.txt

    # [B] Fix Google's CMake Structure (Comment out overrides)
    COMMAND sed -i "s|set(TFLITE_BUILD_DIR|#set(TFLITE_BUILD_DIR|" <SOURCE_DIR>/litert/CMakeLists.txt
    COMMAND sed -i "s|set(TFLITE_SOURCE_DIR|#set(TFLITE_SOURCE_DIR|" <SOURCE_DIR>/litert/CMakeLists.txt

    # [C] Fix Missing/Moved Source Files
    COMMAND sed -i "s|    litert_accelerator.cc|    internal/litert_accelerator.cc|g" <SOURCE_DIR>/litert/c/CMakeLists.txt
    COMMAND sed -i "s|    litert_accelerator_registration.cc|    internal/litert_accelerator_registration.cc|g" <SOURCE_DIR>/litert/c/CMakeLists.txt
    
    # [D] Comment out broken files we don't need
    COMMAND sed -i "s|    model_graph.cc|#    model_graph.cc|g" <SOURCE_DIR>/litert/core/model/CMakeLists.txt
    COMMAND sed -i "s|    tensor_buffer_conversion.cc|#    tensor_buffer_conversion.cc|g" <SOURCE_DIR>/litert/runtime/CMakeLists.txt
    COMMAND sed -i "s|    webgpu_buffer.cc|#    webgpu_buffer.cc|g" <SOURCE_DIR>/litert/runtime/CMakeLists.txt

    # COMMAND sed -i "s|    message(FATAL_ERROR \"FlatBuffers|#    message(FATAL_ERROR \"FlatBuffers|" <SOURCE_DIR>/litert/core/model/CMakeLists.txt
    # COMMAND sed -i "s|    message(FATAL_ERROR \"FlatBuffers|#    message(FATAL_ERROR \"FlatBuffers|" <SOURCE_DIR>/litert/vender/CMakeLists.txt

    # [E] THE NUCLEAR OPTION (Versioning)
    # Recursively find ALL generated headers and force them to accept our FlatBuffers version.
    COMMAND find <SOURCE_DIR> -name "*generated.h" -exec sed -i "s/FLATBUFFERS_VERSION_MAJOR == 25/FLATBUFFERS_VERSION_MAJOR >= 24/g" {} +
    COMMAND find <SOURCE_DIR> -name "*generated.h" -exec sed -i "s/FLATBUFFERS_VERSION_MINOR == [0-9]*/FLATBUFFERS_VERSION_MINOR >= 0/g" {} +
    COMMAND find <SOURCE_DIR> -name "*generated.h" -exec sed -i "s/FLATBUFFERS_VERSION_REVISION == [0-9]*/FLATBUFFERS_VERSION_REVISION >= 0/g" {} +

    # Stop MediaTek from clearing our FLATC_EXECUTABLE variable
    COMMAND sed -i "s/set(FLATC_EXECUTABLE \"\")/#set(FLATC_EXECUTABLE \"\")/g" <SOURCE_DIR>/litert/vendors/CMakeLists.txt

    # [F] THE "EMPTY()" POLYFILL (Critical for v24 compatibility)
    # The compiler is finding older headers first, so we replace .empty() with .size() != 0
    COMMAND sed -i "s/!buffers->empty()/buffers->size() != 0/g" <SOURCE_DIR>/tflite/converter/core/model_builder_base.h

    # [Fix Root Overlay Path]
    COMMAND sed -i "s|set(_overlay_root.*)|set(_overlay_root \"${TFLITE_SRC_DIR}/converter\")|g" <SOURCE_DIR>/litert/CMakeLists.txt

    # [Fix Model Schema Output Path]
    COMMAND sed -i "s|generated/include/tflite/schema/mutable|generated/include/converter/schema/mutable|g" <SOURCE_DIR>/litert/core/model/CMakeLists.txt

    # COMMAND sed -i "s|set(_overlay_root \"${CMAKE_CURRENT_SOURCE_DIR}/../tflite/converter\")|  set(_overlay_root \"${TFLITE_SOURCE_DIR}/tflite/converter\")|" <SOURCE_DIR>/CMakeLists.txt

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
    
    # Inject our constructed flags (Includes OpenCL mocks)
    "-DCMAKE_CXX_FLAGS=${LITERT_CXX_FLAGS_Construct}"
    "-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}" 

    # OpenCL Versioning
    -DCL_TARGET_OPENCL_VERSION=220
    -DCL_HPP_TARGET_OPENCL_VERSION=220
    -DCL_HPP_MIN_TARGET_OPENCL_VERSION=220

    # Dependency Injection: Abseil
    "-D_abseil-cpp_LICENSE_FILE:FILEPATH=${ABSL_EXT_PREFIX}/src/absl_external/LICENSE"
    "-DFETCHCONTENT_SOURCE_DIR_ABSEIL_CPP=${ABSL_EXT_PREFIX}/src/absl_external"
    -Dabsl_SOURCE_DIR=${ABSL_SRC_DIR}
    -Dabsl_BINARY_DIR=${ABSL_BUILD_DIR}
    -Dabsl_INCLUDE_DIR=${ABSL_INCLUDE_DIR}
    -DABSL_LIBRARIES=${ABSL_LIB_DIR}
    -Dabsl_DIR=${ABSL_LIB_DIR}/cmake/absl

    # FlatBuffers
    -DFLATBUFFERS_BUILD_FLATC=OFF
    -DFLATBUFFERS_INSTALL=OFF
    -DFlatBuffers_BINARY_DIR=${FLATBUFFERS_BIN_DIR}
    -DFLATBUFFERS_PROJECT_DIR=${FLATBUFFERS_SRC_DIR}/flatbuffers_external
    -DFlatBuffers_BINARY_DIR=${FLATBUFFERS_BIN_DIR}
    -DFlatBuffers_SOURCE_DIR=${FLATBUFFERS_SRC_DIR}/flatbuffers_external
    -D_flatbuffers_LICENSE_FILE:FILEPATH=${FLATBUFFERS_SRC_DIR}/flatbuffers_external/LICENSE
    -DFLATC_PATHS=${FLATBUFFERS_BIN_DIR}
    -DFLATBUFFERS_FLATC_EXECUTABLE=${FLATC_EXECUTABLE}
    -DFLATC_EXECUTABLE=${FLATC_EXECUTABLE}

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

  INSTALL_COMMAND ""
)

# =========================================================
#  4. Import the Libraries
# =========================================================
import_static_lib(imp_litert_c_api    "${LITERT_BUILD_DIR}/c/liblitert_c_api.a")
import_static_lib(imp_litert_c_options    "${LITERT_BUILD_DIR}/c/options/liblitert_c_options.a")

import_static_lib(imp_litert_cc_api    "${LITERT_BUILD_DIR}/cc/liblitert_cc_api.a")
import_static_lib(imp_litert_cc_options    "${LITERT_BUILD_DIR}/cc/options/liblitert_cc_options.a")

import_static_lib(imp_litert_compiler_plugins    "${LITERT_BUILD_DIR}/compiler/liblitert_compiler_plugin.a")

import_static_lib(imp_litert_core     "${LITERT_BUILD_DIR}/core/liblitert_core.a")
import_static_lib(imp_litert_core_model    "${LITERT_BUILD_DIR}/core/model/liblitert_core_model.a")

import_static_lib(imp_litert_runtime  "${LITERT_BUILD_DIR}/runtime/liblitert_runtime.a")