include(ExternalProject)



set(ABSL_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/abseil-cpp)
set(ABSL_INSTALL_PREFIX ${ABSL_EXT_PREFIX}/install)
set(ABSL_INCLUDE_DIR ${ABSL_INSTALL_PREFIX}/include)
set(ABSL_LIB_DIR ${ABSL_INSTALL_PREFIX}/lib)
set(ABSL_CONFIG_CMAKE_FILE "${ABSL_INSTALL_PREFIX}/lib/cmake/absl/abslConfig.cmake")

if(NOT EXISTS "${ABSL_CONFIG_CMAKE_FILE}")
  message(STATUS "Abseil not found. Configuring external build...")

  ExternalProject_Add(
    absl_external
    GIT_REPOSITORY
      https://github.com/abseil/abseil-cpp
    GIT_TAG
      d9e4955c65cd4367dd6bf46f4ccb8cd3d100540b
    PREFIX
      ${ABSL_EXT_PREFIX}
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${ABSL_INSTALL_PREFIX}
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
      -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
      -DCMAKE_CXX_STANDARD=17
      -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
      -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON
      -DABSL_BUILD_TESTING=OFF
      -DABSL_USE_GOOGLETEST_HEAD=OFF
      -DABSL_ENABLE_INSTALL=ON
      -DABSL_PROPAGATE_CXX_STD=ON
    STEP_TARGETS
      step_verify_install
  )
  verify_install(absl_external ${ABSL_CONFIG_CMAKE_FILE})

else()
    message(STATUS "Abseil already installed at: ${ABSL_INSTALL_PREFIX}")
    if(NOT TARGET absl_external)
        add_custom_target(absl_external)
    endif()
endif()


# # ==============================================================================
# # ABSEIL IMPORT LIST
# # ==============================================================================

# # --- Base ---
# import_static_lib(imp_absl_base             "${ABSL_LIB_DIR}/libabsl_base.a")
# import_static_lib(imp_absl_malloc_int       "${ABSL_LIB_DIR}/libabsl_malloc_internal.a")
# import_static_lib(imp_absl_raw_log_int      "${ABSL_LIB_DIR}/libabsl_raw_logging_internal.a")
# import_static_lib(imp_absl_strerror         "${ABSL_LIB_DIR}/libabsl_strerror.a")
# import_static_lib(imp_absl_throw_del        "${ABSL_LIB_DIR}/libabsl_throw_delegate.a")
# import_static_lib(imp_absl_log_severity     "${ABSL_LIB_DIR}/libabsl_log_severity.a")
# import_static_lib(imp_absl_spinlock_wait    "${ABSL_LIB_DIR}/libabsl_spinlock_wait.a")

# # --- Container ---
# import_static_lib(imp_absl_raw_hash_set     "${ABSL_LIB_DIR}/libabsl_raw_hash_set.a")
# import_static_lib(imp_absl_hsh_sampler      "${ABSL_LIB_DIR}/libabsl_hashtablez_sampler.a")

# # --- CRC ---
# import_static_lib(imp_absl_crc32c           "${ABSL_LIB_DIR}/libabsl_crc32c.a")
# import_static_lib(imp_absl_crc_cord_st      "${ABSL_LIB_DIR}/libabsl_crc_cord_state.a")
# import_static_lib(imp_absl_crc_cpu_det      "${ABSL_LIB_DIR}/libabsl_crc_cpu_detect.a")
# import_static_lib(imp_absl_crc_internal     "${ABSL_LIB_DIR}/libabsl_crc_internal.a")

# # --- Debugging ---
# import_static_lib(imp_absl_dbg_internal     "${ABSL_LIB_DIR}/libabsl_debugging_internal.a")
# import_static_lib(imp_absl_examine_stack    "${ABSL_LIB_DIR}/libabsl_examine_stack.a")
# import_static_lib(imp_absl_fail_sig_hnd     "${ABSL_LIB_DIR}/libabsl_failure_signal_handler.a")
# import_static_lib(imp_absl_leak_check       "${ABSL_LIB_DIR}/libabsl_leak_check.a")
# import_static_lib(imp_absl_stacktrace       "${ABSL_LIB_DIR}/libabsl_stacktrace.a")
# import_static_lib(imp_absl_symbolize        "${ABSL_LIB_DIR}/libabsl_symbolize.a")
# import_static_lib(imp_absl_demangle_int     "${ABSL_LIB_DIR}/libabsl_demangle_internal.a")
# import_static_lib(imp_absl_demangle_rust    "${ABSL_LIB_DIR}/libabsl_demangle_rust.a")
# import_static_lib(imp_absl_decode_rust      "${ABSL_LIB_DIR}/libabsl_decode_rust_punycode.a")
# import_static_lib(imp_absl_utf8_cp          "${ABSL_LIB_DIR}/libabsl_utf8_for_code_point.a")

# # --- Flags ---
# import_static_lib(imp_absl_flags_cmdline    "${ABSL_LIB_DIR}/libabsl_flags_commandlineflag.a")
# import_static_lib(imp_absl_flags_config     "${ABSL_LIB_DIR}/libabsl_flags_config.a")
# import_static_lib(imp_absl_flags_internal   "${ABSL_LIB_DIR}/libabsl_flags_internal.a")
# import_static_lib(imp_absl_flags_marshall   "${ABSL_LIB_DIR}/libabsl_flags_marshalling.a")
# import_static_lib(imp_absl_flags_parse      "${ABSL_LIB_DIR}/libabsl_flags_parse.a")
# import_static_lib(imp_absl_flags_private    "${ABSL_LIB_DIR}/libabsl_flags_private_handle_accessor.a")
# import_static_lib(imp_absl_flags_progname   "${ABSL_LIB_DIR}/libabsl_flags_program_name.a")
# import_static_lib(imp_absl_flags_reflect    "${ABSL_LIB_DIR}/libabsl_flags_reflection.a")
# import_static_lib(imp_absl_flags_usage      "${ABSL_LIB_DIR}/libabsl_flags_usage.a")
# import_static_lib(imp_absl_flags_cmd_int    "${ABSL_LIB_DIR}/libabsl_flags_commandlineflag_internal.a")
# import_static_lib(imp_absl_flags_usg_int    "${ABSL_LIB_DIR}/libabsl_flags_usage_internal.a")

# # --- Log ---
# import_static_lib(imp_absl_die_if_null      "${ABSL_LIB_DIR}/libabsl_die_if_null.a")
# import_static_lib(imp_absl_log_entry        "${ABSL_LIB_DIR}/libabsl_log_entry.a")
# import_static_lib(imp_absl_log_flags        "${ABSL_LIB_DIR}/libabsl_log_flags.a")
# import_static_lib(imp_absl_log_globals      "${ABSL_LIB_DIR}/libabsl_log_globals.a")
# import_static_lib(imp_absl_log_init         "${ABSL_LIB_DIR}/libabsl_log_initialize.a")
# import_static_lib(imp_absl_log_int_chk      "${ABSL_LIB_DIR}/libabsl_log_internal_check_op.a")
# import_static_lib(imp_absl_log_int_msg      "${ABSL_LIB_DIR}/libabsl_log_internal_message.a")
# import_static_lib(imp_absl_log_sink         "${ABSL_LIB_DIR}/libabsl_log_sink.a")
# import_static_lib(imp_absl_log_int_snk_set  "${ABSL_LIB_DIR}/libabsl_log_internal_log_sink_set.a")
# import_static_lib(imp_absl_log_int_fmt      "${ABSL_LIB_DIR}/libabsl_log_internal_format.a")
# import_static_lib(imp_absl_log_int_proto    "${ABSL_LIB_DIR}/libabsl_log_internal_proto.a")
# import_static_lib(imp_absl_log_int_nullgrd  "${ABSL_LIB_DIR}/libabsl_log_internal_nullguard.a")
# import_static_lib(imp_absl_log_int_fnm      "${ABSL_LIB_DIR}/libabsl_log_internal_fnmatch.a")
# import_static_lib(imp_absl_log_int_cond     "${ABSL_LIB_DIR}/libabsl_log_internal_conditions.a")

# # --- Numeric ---
# import_static_lib(imp_absl_int128           "${ABSL_LIB_DIR}/libabsl_int128.a")

# # --- Profiling ---
# import_static_lib(imp_absl_exp_biased       "${ABSL_LIB_DIR}/libabsl_exponential_biased.a")
# import_static_lib(imp_absl_hash_profiler    "${ABSL_LIB_DIR}/libabsl_hashtable_profiler.a")
# import_static_lib(imp_absl_periodic_smplr   "${ABSL_LIB_DIR}/libabsl_periodic_sampler.a")
# import_static_lib(imp_absl_profile_bldr     "${ABSL_LIB_DIR}/libabsl_profile_builder.a")

# # --- Hash ---
# import_static_lib(imp_absl_hash             "${ABSL_LIB_DIR}/libabsl_hash.a")
# import_static_lib(imp_absl_city             "${ABSL_LIB_DIR}/libabsl_city.a")

# # --- Random ---
# import_static_lib(imp_absl_rand_dist        "${ABSL_LIB_DIR}/libabsl_random_distributions.a")
# import_static_lib(imp_absl_rand_int_test    "${ABSL_LIB_DIR}/libabsl_random_internal_distribution_test_util.a")
# import_static_lib(imp_absl_rand_entropy     "${ABSL_LIB_DIR}/libabsl_random_internal_entropy_pool.a")
# import_static_lib(imp_absl_rand_platform    "${ABSL_LIB_DIR}/libabsl_random_internal_platform.a")
# import_static_lib(imp_absl_rand_randen      "${ABSL_LIB_DIR}/libabsl_random_internal_randen.a")
# import_static_lib(imp_absl_rand_randen_hw   "${ABSL_LIB_DIR}/libabsl_random_internal_randen_hwaes.a")
# import_static_lib(imp_absl_rand_hw_impl     "${ABSL_LIB_DIR}/libabsl_random_internal_randen_hwaes_impl.a")
# import_static_lib(imp_absl_rand_slow        "${ABSL_LIB_DIR}/libabsl_random_internal_randen_slow.a")
# import_static_lib(imp_absl_rand_seed_mat    "${ABSL_LIB_DIR}/libabsl_random_internal_seed_material.a")
# import_static_lib(imp_absl_rand_seed_gen    "${ABSL_LIB_DIR}/libabsl_random_seed_gen_exception.a")
# import_static_lib(imp_absl_rand_seed_seq    "${ABSL_LIB_DIR}/libabsl_random_seed_sequences.a")

# # --- Status ---
# import_static_lib(imp_absl_status           "${ABSL_LIB_DIR}/libabsl_status.a")
# import_static_lib(imp_absl_statusor         "${ABSL_LIB_DIR}/libabsl_statusor.a")

# # --- Strings ---
# import_static_lib(imp_absl_strings          "${ABSL_LIB_DIR}/libabsl_strings.a")
# import_static_lib(imp_absl_strings_int      "${ABSL_LIB_DIR}/libabsl_strings_internal.a")
# import_static_lib(imp_absl_string_view      "${ABSL_LIB_DIR}/libabsl_string_view.a")
# import_static_lib(imp_absl_cord             "${ABSL_LIB_DIR}/libabsl_cord.a")
# import_static_lib(imp_absl_cord_int         "${ABSL_LIB_DIR}/libabsl_cord_internal.a")
# import_static_lib(imp_absl_cordz_funcs      "${ABSL_LIB_DIR}/libabsl_cordz_functions.a")
# import_static_lib(imp_absl_cordz_handle     "${ABSL_LIB_DIR}/libabsl_cordz_handle.a")
# import_static_lib(imp_absl_cordz_info       "${ABSL_LIB_DIR}/libabsl_cordz_info.a")
# import_static_lib(imp_absl_cordz_sample     "${ABSL_LIB_DIR}/libabsl_cordz_sample_token.a")
# import_static_lib(imp_absl_str_fmt_int      "${ABSL_LIB_DIR}/libabsl_str_format_internal.a")

# # --- Synchronization ---
# import_static_lib(imp_absl_sync             "${ABSL_LIB_DIR}/libabsl_synchronization.a")
# import_static_lib(imp_absl_graphcycles      "${ABSL_LIB_DIR}/libabsl_graphcycles_internal.a")
# import_static_lib(imp_absl_kernel_timeout   "${ABSL_LIB_DIR}/libabsl_kernel_timeout_internal.a")

# # --- Time ---
# import_static_lib(imp_absl_time             "${ABSL_LIB_DIR}/libabsl_time.a")
# import_static_lib(imp_absl_civil_time       "${ABSL_LIB_DIR}/libabsl_civil_time.a")
# import_static_lib(imp_absl_time_zone        "${ABSL_LIB_DIR}/libabsl_time_zone.a")

# import_static_lib -> cmake/modules/macros.cmake
import_static_lib(imp_absl_bad_any_cast_impl     "${ABSL_LIB_DIR}/libabsl_bad_any_cast_impl.a")
import_static_lib(imp_absl_bad_optional_access   "${ABSL_LIB_DIR}/libabsl_bad_optional_access.a")
import_static_lib(imp_absl_bad_variant_access    "${ABSL_LIB_DIR}/libabsl_bad_variant_access.a")
import_static_lib(imp_absl_base                  "${ABSL_LIB_DIR}/libabsl_base.a")
import_static_lib(imp_absl_city                  "${ABSL_LIB_DIR}/libabsl_city.a")
import_static_lib(imp_absl_civil_time            "${ABSL_LIB_DIR}/libabsl_civil_time.a")
import_static_lib(imp_absl_cord                  "${ABSL_LIB_DIR}/libabsl_cord.a")
import_static_lib(imp_absl_cord_internal         "${ABSL_LIB_DIR}/libabsl_cord_internal.a")
import_static_lib(imp_absl_cordz_functions       "${ABSL_LIB_DIR}/libabsl_cordz_functions.a")
import_static_lib(imp_absl_cordz_handle          "${ABSL_LIB_DIR}/libabsl_cordz_handle.a")
import_static_lib(imp_absl_cordz_info            "${ABSL_LIB_DIR}/libabsl_cordz_info.a")
import_static_lib(imp_absl_cordz_sample_token    "${ABSL_LIB_DIR}/libabsl_cordz_sample_token.a")
import_static_lib(imp_absl_crc32c                "${ABSL_LIB_DIR}/libabsl_crc32c.a")
import_static_lib(imp_absl_crc_cord_state        "${ABSL_LIB_DIR}/libabsl_crc_cord_state.a")
import_static_lib(imp_absl_crc_cpu_detect        "${ABSL_LIB_DIR}/libabsl_crc_cpu_detect.a")
import_static_lib(imp_absl_crc_internal          "${ABSL_LIB_DIR}/libabsl_crc_internal.a")
import_static_lib(imp_absl_debugging_internal    "${ABSL_LIB_DIR}/libabsl_debugging_internal.a")
import_static_lib(imp_absl_decode_rust_punycode  "${ABSL_LIB_DIR}/libabsl_decode_rust_punycode.a")
import_static_lib(imp_absl_demangle_internal     "${ABSL_LIB_DIR}/libabsl_demangle_internal.a")
import_static_lib(imp_absl_demangle_rust         "${ABSL_LIB_DIR}/libabsl_demangle_rust.a")
import_static_lib(imp_absl_die_if_null           "${ABSL_LIB_DIR}/libabsl_die_if_null.a")
import_static_lib(imp_absl_examine_stack         "${ABSL_LIB_DIR}/libabsl_examine_stack.a")
import_static_lib(imp_absl_exponential_biased    "${ABSL_LIB_DIR}/libabsl_exponential_biased.a")
import_static_lib(imp_absl_failure_signal_handler "${ABSL_LIB_DIR}/libabsl_failure_signal_handler.a")
import_static_lib(imp_absl_flags_commandlineflag "${ABSL_LIB_DIR}/libabsl_flags_commandlineflag.a")
import_static_lib(imp_absl_flags_commandlineflag_internal "${ABSL_LIB_DIR}/libabsl_flags_commandlineflag_internal.a")
import_static_lib(imp_absl_flags_config          "${ABSL_LIB_DIR}/libabsl_flags_config.a")
import_static_lib(imp_absl_flags_internal        "${ABSL_LIB_DIR}/libabsl_flags_internal.a")
import_static_lib(imp_absl_flags_marshalling     "${ABSL_LIB_DIR}/libabsl_flags_marshalling.a")
import_static_lib(imp_absl_flags_parse           "${ABSL_LIB_DIR}/libabsl_flags_parse.a")
import_static_lib(imp_absl_flags_private_handle_accessor "${ABSL_LIB_DIR}/libabsl_flags_private_handle_accessor.a")
import_static_lib(imp_absl_flags_program_name    "${ABSL_LIB_DIR}/libabsl_flags_program_name.a")
import_static_lib(imp_absl_flags_reflection      "${ABSL_LIB_DIR}/libabsl_flags_reflection.a")
import_static_lib(imp_absl_flags_usage           "${ABSL_LIB_DIR}/libabsl_flags_usage.a")
import_static_lib(imp_absl_flags_usage_internal  "${ABSL_LIB_DIR}/libabsl_flags_usage_internal.a")
import_static_lib(imp_absl_graphcycles_internal  "${ABSL_LIB_DIR}/libabsl_graphcycles_internal.a")
import_static_lib(imp_absl_hash                  "${ABSL_LIB_DIR}/libabsl_hash.a")
import_static_lib(imp_absl_hashtablez_sampler    "${ABSL_LIB_DIR}/libabsl_hashtablez_sampler.a")
import_static_lib(imp_absl_int128                "${ABSL_LIB_DIR}/libabsl_int128.a")
import_static_lib(imp_absl_kernel_timeout_internal "${ABSL_LIB_DIR}/libabsl_kernel_timeout_internal.a")
import_static_lib(imp_absl_leak_check            "${ABSL_LIB_DIR}/libabsl_leak_check.a")
import_static_lib(imp_absl_log_entry             "${ABSL_LIB_DIR}/libabsl_log_entry.a")
import_static_lib(imp_absl_log_flags             "${ABSL_LIB_DIR}/libabsl_log_flags.a")
import_static_lib(imp_absl_log_globals           "${ABSL_LIB_DIR}/libabsl_log_globals.a")
import_static_lib(imp_absl_log_initialize        "${ABSL_LIB_DIR}/libabsl_log_initialize.a")
import_static_lib(imp_absl_log_internal_check_op "${ABSL_LIB_DIR}/libabsl_log_internal_check_op.a")
import_static_lib(imp_absl_log_internal_conditions "${ABSL_LIB_DIR}/libabsl_log_internal_conditions.a")
import_static_lib(imp_absl_log_internal_fnmatch  "${ABSL_LIB_DIR}/libabsl_log_internal_fnmatch.a")
import_static_lib(imp_absl_log_internal_format   "${ABSL_LIB_DIR}/libabsl_log_internal_format.a")
import_static_lib(imp_absl_log_internal_globals  "${ABSL_LIB_DIR}/libabsl_log_internal_globals.a")
import_static_lib(imp_absl_log_internal_log_sink_set "${ABSL_LIB_DIR}/libabsl_log_internal_log_sink_set.a")
import_static_lib(imp_absl_log_internal_message  "${ABSL_LIB_DIR}/libabsl_log_internal_message.a")
import_static_lib(imp_absl_log_internal_nullguard "${ABSL_LIB_DIR}/libabsl_log_internal_nullguard.a")
import_static_lib(imp_absl_log_internal_proto    "${ABSL_LIB_DIR}/libabsl_log_internal_proto.a")
import_static_lib(imp_absl_log_internal_structured_proto "${ABSL_LIB_DIR}/libabsl_log_internal_structured_proto.a")
import_static_lib(imp_absl_log_severity          "${ABSL_LIB_DIR}/libabsl_log_severity.a")
import_static_lib(imp_absl_log_sink              "${ABSL_LIB_DIR}/libabsl_log_sink.a")
import_static_lib(imp_absl_low_level_hash        "${ABSL_LIB_DIR}/libabsl_low_level_hash.a")
import_static_lib(imp_absl_malloc_internal       "${ABSL_LIB_DIR}/libabsl_malloc_internal.a")
import_static_lib(imp_absl_periodic_sampler      "${ABSL_LIB_DIR}/libabsl_periodic_sampler.a")
import_static_lib(imp_absl_poison                "${ABSL_LIB_DIR}/libabsl_poison.a")
import_static_lib(imp_absl_random_distributions  "${ABSL_LIB_DIR}/libabsl_random_distributions.a")
import_static_lib(imp_absl_random_internal_distribution_test_util "${ABSL_LIB_DIR}/libabsl_random_internal_distribution_test_util.a")
import_static_lib(imp_absl_random_internal_platform "${ABSL_LIB_DIR}/libabsl_random_internal_platform.a")
import_static_lib(imp_absl_random_internal_pool_urbg "${ABSL_LIB_DIR}/libabsl_random_internal_pool_urbg.a")
import_static_lib(imp_absl_random_internal_randen "${ABSL_LIB_DIR}/libabsl_random_internal_randen.a")
import_static_lib(imp_absl_random_internal_randen_hwaes "${ABSL_LIB_DIR}/libabsl_random_internal_randen_hwaes.a")
import_static_lib(imp_absl_random_internal_randen_hwaes_impl "${ABSL_LIB_DIR}/libabsl_random_internal_randen_hwaes_impl.a")
import_static_lib(imp_absl_random_internal_randen_slow "${ABSL_LIB_DIR}/libabsl_random_internal_randen_slow.a")
import_static_lib(imp_absl_random_internal_seed_material "${ABSL_LIB_DIR}/libabsl_random_internal_seed_material.a")
import_static_lib(imp_absl_random_seed_gen_exception "${ABSL_LIB_DIR}/libabsl_random_seed_gen_exception.a")
import_static_lib(imp_absl_random_seed_sequences "${ABSL_LIB_DIR}/libabsl_random_seed_sequences.a")
import_static_lib(imp_absl_raw_hash_set          "${ABSL_LIB_DIR}/libabsl_raw_hash_set.a")
import_static_lib(imp_absl_raw_logging_internal  "${ABSL_LIB_DIR}/libabsl_raw_logging_internal.a")
import_static_lib(imp_absl_scoped_set_env        "${ABSL_LIB_DIR}/libabsl_scoped_set_env.a")
import_static_lib(imp_absl_spinlock_wait         "${ABSL_LIB_DIR}/libabsl_spinlock_wait.a")
import_static_lib(imp_absl_stacktrace            "${ABSL_LIB_DIR}/libabsl_stacktrace.a")
import_static_lib(imp_absl_status                "${ABSL_LIB_DIR}/libabsl_status.a")
import_static_lib(imp_absl_statusor              "${ABSL_LIB_DIR}/libabsl_statusor.a")
import_static_lib(imp_absl_str_format_internal   "${ABSL_LIB_DIR}/libabsl_str_format_internal.a")
import_static_lib(imp_absl_strerror              "${ABSL_LIB_DIR}/libabsl_strerror.a")
import_static_lib(imp_absl_string_view           "${ABSL_LIB_DIR}/libabsl_string_view.a")
import_static_lib(imp_absl_strings               "${ABSL_LIB_DIR}/libabsl_strings.a")
import_static_lib(imp_absl_strings_internal      "${ABSL_LIB_DIR}/libabsl_strings_internal.a")
import_static_lib(imp_absl_symbolize             "${ABSL_LIB_DIR}/libabsl_symbolize.a")
import_static_lib(imp_absl_synchronization       "${ABSL_LIB_DIR}/libabsl_synchronization.a")
import_static_lib(imp_absl_throw_delegate        "${ABSL_LIB_DIR}/libabsl_throw_delegate.a")
import_static_lib(imp_absl_time                  "${ABSL_LIB_DIR}/libabsl_time.a")
import_static_lib(imp_absl_time_zone             "${ABSL_LIB_DIR}/libabsl_time_zone.a")
import_static_lib(imp_absl_tracing_internal      "${ABSL_LIB_DIR}/libabsl_tracing_internal.a")
import_static_lib(imp_absl_utf8_for_code_point   "${ABSL_LIB_DIR}/libabsl_utf8_for_code_point.a")
import_static_lib(imp_absl_vlog_config_internal  "${ABSL_LIB_DIR}/libabsl_vlog_config_internal.a")
add_library(absl_libs INTERFACE)
target_link_libraries(absl_libs INTERFACE
    imp_absl_bad_any_cast_impl
    imp_absl_bad_optional_access
    imp_absl_bad_variant_access
    imp_absl_base
    imp_absl_city
    imp_absl_civil_time
    imp_absl_cord
    imp_absl_cord_internal
    imp_absl_cordz_functions
    imp_absl_cordz_handle
    imp_absl_cordz_info
    imp_absl_cordz_sample_token
    imp_absl_crc32c
    imp_absl_crc_cord_state
    imp_absl_crc_cpu_detect
    imp_absl_crc_internal
    imp_absl_debugging_internal
    imp_absl_decode_rust_punycode
    imp_absl_demangle_internal
    imp_absl_demangle_rust
    imp_absl_die_if_null
    imp_absl_examine_stack
    imp_absl_exponential_biased
    imp_absl_failure_signal_handler
    imp_absl_flags_commandlineflag
    imp_absl_flags_commandlineflag_internal
    imp_absl_flags_config
    imp_absl_flags_internal
    imp_absl_flags_marshalling
    imp_absl_flags_parse
    imp_absl_flags_private_handle_accessor
    imp_absl_flags_program_name
    imp_absl_flags_reflection
    imp_absl_flags_usage
    imp_absl_flags_usage_internal
    imp_absl_graphcycles_internal
    imp_absl_hash
    imp_absl_hashtablez_sampler
    imp_absl_int128
    imp_absl_kernel_timeout_internal
    imp_absl_leak_check
    imp_absl_log_entry
    imp_absl_log_flags
    imp_absl_log_globals
    imp_absl_log_initialize
    imp_absl_log_internal_check_op
    imp_absl_log_internal_conditions
    imp_absl_log_internal_fnmatch
    imp_absl_log_internal_format
    imp_absl_log_internal_globals
    imp_absl_log_internal_log_sink_set
    imp_absl_log_internal_message
    imp_absl_log_internal_nullguard
    imp_absl_log_internal_proto
    imp_absl_log_internal_structured_proto
    imp_absl_log_severity
    imp_absl_log_sink
    imp_absl_low_level_hash
    imp_absl_malloc_internal
    imp_absl_periodic_sampler
    imp_absl_poison
    imp_absl_random_distributions
    imp_absl_random_internal_distribution_test_util
    imp_absl_random_internal_platform
    imp_absl_random_internal_pool_urbg
    imp_absl_random_internal_randen
    imp_absl_random_internal_randen_hwaes
    imp_absl_random_internal_randen_hwaes_impl
    imp_absl_random_internal_randen_slow
    imp_absl_random_internal_seed_material
    imp_absl_random_seed_gen_exception
    imp_absl_random_seed_sequences
    imp_absl_raw_hash_set
    imp_absl_raw_logging_internal
    imp_absl_scoped_set_env
    imp_absl_spinlock_wait
    imp_absl_stacktrace
    imp_absl_status
    imp_absl_statusor
    imp_absl_str_format_internal
    imp_absl_strerror
    imp_absl_string_view
    imp_absl_strings
    imp_absl_strings_internal
    imp_absl_symbolize
    imp_absl_synchronization
    imp_absl_throw_delegate
    imp_absl_time
    imp_absl_time_zone
    imp_absl_tracing_internal
    imp_absl_utf8_for_code_point
    imp_absl_vlog_config_internal
)
