# litert_shims.cmake

# 1. Define the Global Abseil Kitchen Sink
if(NOT TARGET LiteRTLM::absl::absl)
    add_library(LiteRTLM::absl::absl INTERFACE IMPORTED GLOBAL)
    set_target_properties(LiteRTLM::absl::absl PROPERTIES 
        INTERFACE_LINK_LIBRARIES "-Wl,--start-group;${ABSL_LIBS_FLAT};-Wl,--end-group"
        INTERFACE_INCLUDE_DIRECTORIES "${ABSL_INCLUDE_DIR}"
    )
endif()

# 2. Map standard modular names to our sink
# This catches anything the 'sed' hammer might miss or that is hardcoded in CMake logic
if(NOT TARGET absl::status)
    add_library(absl::status ALIAS LiteRTLM::absl::absl)
endif()
if(NOT TARGET absl::log)
    add_library(absl::log ALIAS LiteRTLM::absl::absl)
endif()
if(NOT TARGET absl::strings)
    add_library(absl::strings ALIAS LiteRTLM::absl::absl)
endif()

message(STATUS "LiteRTLM: LiteRT Shims Loaded (ABSL Redirected)")

    # # Dependency Injection: Abseil
    # set(_abseil-cpp_LICENSE_FILE "${ABSL_EXT_PREFIX}/src/absl_external/LICENSE")
    # set(FETCHCONTENT_SOURCE_DIR_ABSEIL-CPP "${ABSL_EXT_PREFIX}/src/absl_external")
    # set(absl_SOURCE_DIR "${ABSL_SRC_DIR}")
    # set(absl_BINARY_DIR "${ABSL_BUILD_DIR}")
    # set(absl_INCLUDE_DIR "${ABSL_INCLUDE_DIR}")
    # set(ABSL_LIBRARIES "${ABSL_LIB_DIR}")
    # set(absl_DIR "${ABSL_LIB_DIR}/cmake/absl")


set(CMAKE_CXX_STANDARD_LIBRARIES 
      "-Wl,--start-group"
      "-labsl_log_internal_proto"
      "-labsl_log_internal_message"
      "-labsl_log_internal_structured_proto"
      "-labsl_log_internal_check_op"
      "-labsl_log_severity"
      "-labsl_cord"
      "-labsl_cord_internal"
      "-labsl_cordz_handle"
      "-labsl_cordz_info"
      "-labsl_cordz_functions"
      "-labsl_cordz_sample_token"
      "-labsl_crc_cord_state"
      "-labsl_crc32c"
      "-labsl_crc_interna"
      "-labsl_crc_cpu_detect"
      "-labsl_exponential_biased"
      "-labsl_symbolize"
      "-labsl_stacktrace"
      "-labsl_tracing_internal"
      "-labsl_debugging_internal"
      "-labsl_examine_stack"
      "-labsl_demangle_internal"
      "-labsl_demangle_rust"
      "-labsl_decode_rust_punycode"
      "-labsl_log_internal_globals"
      "-labsl_log_globals"
      "-labsl_log_sink"
      "-labsl_log_internal_log_sink_set"
      "-labsl_log_internal_format"
      "-labsl_log_internal_conditions"
      "-labsl_log_internal_nullguard"
      "-labsl_log_internal_fnmatch"
      "-labsl_status"
      "-labsl_statusor"
      "-labsl_raw_logging_internal"
      "-labsl_base"
      "-labsl_spinlock_wait"
      "-labsl_malloc_internal"
      "-labsl_failure_signal_handler"
      "-labsl_throw_delegate"
      "-labsl_int128"
      "-labsl_strings"
      "-labsl_strings_internal"
      "-labsl_string_view"
      "-labsl_strerror"
      "-labsl_poison"
      "-labsl_synchronization"
      "-labsl_periodic_sampler"
      "-labsl_scoped_set_env"
      "-labsl_kernel_timeout_internal"
      "-labsl_time"
      "-labsl_time_zone"
      "-labsl_hash"
      "-labsl_city"
      "-labsl_hashtable_profiler"
      "-labsl_log_initialize"
      "-labsl_leak_check"
      "-labsl_raw_hash_set"
      "-labsl_utf8_for_code_point"
      "-labsl_hashtablez_sampler"
      "-labsl_flags_parse"
      "-labsl_flags_usage"
      "-labsl_flags_usage_internal"
      "-labsl_flags_marshalling"
      "-labsl_flags_internal"
      "-labsl_flags_reflection"
      "-labsl_flags_config"
      "-labsl_flags_commandlineflag"
      "-labsl_flags_commandlineflag_internal"
      "-labsl_flags_private_handle_accessor"
      "-labsl_flags_program_name"
      "-labsl_die_if_null"
      "-lprotobuf"
      "-lprotobuf"-lite
      "-ltensorflow"-lite
      "-lXNNPACK"
      "-lxnnpack"-microkernels-prod
      "-lxnnpack"-delegate
      "-lcpuinfo"
      "-lpthreadpool"
      "-leight_bit_int_gemm"
      "-lfft2d_fftsg"
      "-lfft2d_fftsg2d"
      "-lfarmhash"
      "-lflatbuffers"
      "-lruy_allocator"
      "-lruy_apply_multiplier"
      "-lruy_block_map"
      "-lruy_blocking_counter"
      "-lruy_context"
      "-lruy_context_get_ctx"
      "-lruy_cpuinfo"
      "-lruy_ctx"
      "-lruy_denormal"
      "-lruy_frontend"
      "-lruy_have_built_path_for_avx"
      "-lruy_have_built_path_for_avx2_fma"
      "-lruy_have_built_path_for_avx512"
      "-lruy_kernel_arm"
      "-lruy_kernel_avx"
      "-lruy_kernel_avx2_fma"
      "-lruy_kernel_avx512"
      "-lruy_pack_arm"
      "-lruy_pack_avx"
      "-lruy_pack_avx2_fma"
      "-lruy_pack_avx512"
      "-lruy_prepacked_cache"
      "-lruy_prepare_packed_matrices"
      "-lruy_profiler_instrumentation"
      "-lruy_profiler_profiler"
      "-lruy_system_aligned_alloc"
      "-lruy_thread_pool"
      "-lruy_trmul"
      "-lruy_tune"
      "-lruy_wait"
      "-Wl,--end-group"
)