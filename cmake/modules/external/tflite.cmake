include(ExternalProject)

set(TFLITE_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/tensorflow)
set(TFLITE_INSTALL_PREFIX ${TFLITE_EXT_PREFIX}/install)
set(TFLITE_CONFIG_CMAKE_FILE "${TFLITE_INSTALL_PREFIX}/lib/libtensorflow-lite.a")

# --- Parameters for consumption by higher layers (LiteRT-LM) ---
set(TFLITE_INCLUDE_DIR ${TFLITE_INSTALL_PREFIX}/include)
set(TFLITE_LIB_DIR     ${TFLITE_INSTALL_PREFIX}/lib)
set(TFLITE_SRC_DIR     ${TFLITE_EXT_PREFIX}/src/tflite_external/tensorflow/lite)
set(TFLITE_BUILD_DIR   ${TFLITE_SRC_DIR}/tflite_external-build CACHE INTERNAL "")

if(NOT EXISTS "${TFLITE_CONFIG_CMAKE_FILE}")
  message(STATUS "TFLite not found. Configuring external build...")

ExternalProject_Add(
  tflite_external
  DEPENDS 
    absl_external
    flatbuffers_external
    googletest_external
    opencl_headers_external
    # protobuf and tokenizers are not required for TFLite Core
  GIT_REPOSITORY
    https://github.com/tensorflow/tensorflow.git
  GIT_TAG
    v2.20.0
  PREFIX
    ${TFLITE_EXT_PREFIX}
  SOURCE_SUBDIR
    tensorflow/lite
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${TFLITE_INSTALL_PREFIX}
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
    -DCMAKE_POLICY_DEFAULT_CMP0170=OLD
    -DCMAKE_CXX_STANDARD=17
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    
    # Consolidated CXX Flags
    # Removed OpenCL flags because GPU is disabled for TFLite
    "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DTF_MAJOR_VERSION=2 -DTF_MINOR_VERSION=20 -DTF_PATCH_VERSION=0 -DTF_VERSION_SUFFIX=\"\""
    
    # Consolidated C Flags
    "-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS} -DTF_MAJOR_VERSION=2 -DTF_MINOR_VERSION=20 -DTF_PATCH_VERSION=0 -DTF_VERSION_SUFFIX=\"\""

    # --- Dependency Injection ---
    # TFLite uses find_package(absl), so we just point it to the config dir
    -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
    -D_abseil-cpp_LICENSE_FILE:FILEPATH=${ABSL_SRC_DIR}/absl_external/LICENSE
    # TFLite uses find_package(Flatbuffers), so we point it to the config dir

    -DFLATBUFFERS_BUILD_FLATC=OFF
    -DFlatBuffers_BINARY_DIR=${DFLATBUFFERS_BIN_DIR}
    -DFLATBUFFERS_INSTALL=OFF
    -DFLATBUFFERS_PROJECT_DIR=${FLATBUFFERS_SRC_DIR}/flatbuffers_external
    -DFlatBuffers_BINARY_DIR=${DFLATBUFFERS_BIN_DIR}
    -DFlatBuffers_SOURCE_DIR=${FLATBUFFERS_SRC_DIR}/flatbuffers_external
    -D_flatbuffers_LICENSE_FILE:FILEPATH=${FLATBUFFERS_SRC_DIR}/flatbuffers_external/LICENSE



    # --- TFLite Specific Configuration ---
    -DTFLITE_ENABLE_INSTALL=OFF
    -DTFLITE_ENABLE_XNNPACK=ON
    -DTFLITE_ENABLE_RESOURCE_VARIABLE=OFF
    -DXNNPACK_SET_VERBOSITY=OFF
    -DTFLITE_ENABLE_GPU=OFF
)
  
  # Assuming you have a verify_install macro similar to your protobuf setup
  # verify_install(tflite_external ${TFLITE_CONFIG_MARKER})

else()
    message(STATUS "TFLite already installed at: ${TFLITE_INSTALL_PREFIX}")
    if(NOT TARGET tflite_external)
        add_custom_target(tflite_external)
    endif()
endif()



# --- TFLITE AUTO-GENERATED IMPORTS ---
import_static_lib(imp_XNNPACK                    "${TFLITE_LIB_DIR}/libXNNPACK.a")
import_static_lib(imp_cpuinfo                    "${TFLITE_LIB_DIR}/libcpuinfo.a")
import_static_lib(imp_eight_bit_int_gemm         "${TFLITE_LIB_DIR}/libeight_bit_int_gemm.a")
import_static_lib(imp_fft2d_fftsg                "${TFLITE_LIB_DIR}/libfft2d_fftsg.a")
import_static_lib(imp_fft2d_fftsg2d              "${TFLITE_LIB_DIR}/libfft2d_fftsg2d.a")
import_static_lib(imp_flatbuffers                "${TFLITE_LIB_DIR}/libflatbuffers.a")
import_static_lib(imp_pthreadpool                "${TFLITE_LIB_DIR}/libpthreadpool.a")
import_static_lib(imp_ruy_allocator              "${TFLITE_LIB_DIR}/libruy_allocator.a")
import_static_lib(imp_ruy_apply_multiplier       "${TFLITE_LIB_DIR}/libruy_apply_multiplier.a")
import_static_lib(imp_ruy_block_map              "${TFLITE_LIB_DIR}/libruy_block_map.a")
import_static_lib(imp_ruy_blocking_counter       "${TFLITE_LIB_DIR}/libruy_blocking_counter.a")
import_static_lib(imp_ruy_context                "${TFLITE_LIB_DIR}/libruy_context.a")
import_static_lib(imp_ruy_context_get_ctx        "${TFLITE_LIB_DIR}/libruy_context_get_ctx.a")
import_static_lib(imp_ruy_cpuinfo                "${TFLITE_LIB_DIR}/libruy_cpuinfo.a")
import_static_lib(imp_ruy_ctx                    "${TFLITE_LIB_DIR}/libruy_ctx.a")
import_static_lib(imp_ruy_denormal               "${TFLITE_LIB_DIR}/libruy_denormal.a")
import_static_lib(imp_ruy_frontend               "${TFLITE_LIB_DIR}/libruy_frontend.a")
import_static_lib(imp_ruy_have_built_path_for_avx "${TFLITE_LIB_DIR}/libruy_have_built_path_for_avx.a")
import_static_lib(imp_ruy_have_built_path_for_avx2_fma "${TFLITE_LIB_DIR}/libruy_have_built_path_for_avx2_fma.a")
import_static_lib(imp_ruy_have_built_path_for_avx512 "${TFLITE_LIB_DIR}/libruy_have_built_path_for_avx512.a")
import_static_lib(imp_ruy_kernel_arm             "${TFLITE_LIB_DIR}/libruy_kernel_arm.a")
import_static_lib(imp_ruy_kernel_avx             "${TFLITE_LIB_DIR}/libruy_kernel_avx.a")
import_static_lib(imp_ruy_kernel_avx2_fma        "${TFLITE_LIB_DIR}/libruy_kernel_avx2_fma.a")
import_static_lib(imp_ruy_kernel_avx512          "${TFLITE_LIB_DIR}/libruy_kernel_avx512.a")
import_static_lib(imp_ruy_pack_arm               "${TFLITE_LIB_DIR}/libruy_pack_arm.a")
import_static_lib(imp_ruy_pack_avx               "${TFLITE_LIB_DIR}/libruy_pack_avx.a")
import_static_lib(imp_ruy_pack_avx2_fma          "${TFLITE_LIB_DIR}/libruy_pack_avx2_fma.a")
import_static_lib(imp_ruy_pack_avx512            "${TFLITE_LIB_DIR}/libruy_pack_avx512.a")
import_static_lib(imp_ruy_prepacked_cache        "${TFLITE_LIB_DIR}/libruy_prepacked_cache.a")
import_static_lib(imp_ruy_prepare_packed_matrices "${TFLITE_LIB_DIR}/libruy_prepare_packed_matrices.a")
import_static_lib(imp_ruy_profiler_instrumentation "${TFLITE_LIB_DIR}/libruy_profiler_instrumentation.a")
import_static_lib(imp_ruy_profiler_profiler      "${TFLITE_LIB_DIR}/libruy_profiler_profiler.a")
import_static_lib(imp_ruy_system_aligned_alloc   "${TFLITE_LIB_DIR}/libruy_system_aligned_alloc.a")
import_static_lib(imp_ruy_thread_pool            "${TFLITE_LIB_DIR}/libruy_thread_pool.a")
import_static_lib(imp_ruy_trmul                  "${TFLITE_LIB_DIR}/libruy_trmul.a")
import_static_lib(imp_ruy_tune                   "${TFLITE_LIB_DIR}/libruy_tune.a")
import_static_lib(imp_ruy_wait                   "${TFLITE_LIB_DIR}/libruy_wait.a")
import_static_lib(imp_xnnpack-microkernels-prod  "${TFLITE_LIB_DIR}/libxnnpack-microkernels-prod.a")



add_library(tflite_libs INTERFACE)
target_link_libraries(tflite_libs INTERFACE
    imp_XNNPACK
    imp_cpuinfo
    imp_eight_bit_int_gemm
    imp_fft2d_fftsg
    imp_fft2d_fftsg2d
    imp_flatbuffers
    imp_pthreadpool
    imp_ruy_allocator
    imp_ruy_apply_multiplier
    imp_ruy_block_map
    imp_ruy_blocking_counter
    imp_ruy_context
    imp_ruy_context_get_ctx
    imp_ruy_cpuinfo
    imp_ruy_ctx
    imp_ruy_denormal
    imp_ruy_frontend
    imp_ruy_have_built_path_for_avx
    imp_ruy_have_built_path_for_avx2_fma
    imp_ruy_have_built_path_for_avx512
    imp_ruy_kernel_arm
    imp_ruy_kernel_avx
    imp_ruy_kernel_avx2_fma
    imp_ruy_kernel_avx512
    imp_ruy_pack_arm
    imp_ruy_pack_avx
    imp_ruy_pack_avx2_fma
    imp_ruy_pack_avx512
    imp_ruy_prepacked_cache
    imp_ruy_prepare_packed_matrices
    imp_ruy_profiler_instrumentation
    imp_ruy_profiler_profiler
    imp_ruy_system_aligned_alloc
    imp_ruy_thread_pool
    imp_ruy_trmul
    imp_ruy_tune
    imp_ruy_wait
    imp_xnnpack-microkernels-prod
)