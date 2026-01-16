include(utlis)



# --- Base / Essentials ---
import_static_lib(imp_absl_base                    "${ABSL_LIB_DIR}/libabsl_base.a")
import_static_lib(imp_absl_spinlock_wait           "${ABSL_LIB_DIR}/libabsl_spinlock_wait.a")
import_static_lib(imp_absl_throw_delegate          "${ABSL_LIB_DIR}/libabsl_throw_delegate.a")
import_static_lib(imp_absl_raw_logging_internal    "${ABSL_LIB_DIR}/libabsl_raw_logging_internal.a")
import_static_lib(imp_absl_scoped_set_env          "${ABSL_LIB_DIR}/libabsl_scoped_set_env.a")
import_static_lib(imp_absl_log_severity            "${ABSL_LIB_DIR}/libabsl_log_severity.a")
import_static_lib(imp_absl_malloc_internal         "${ABSL_LIB_DIR}/libabsl_malloc_internal.a")
import_static_lib(imp_absl_poison                  "${ABSL_LIB_DIR}/libabsl_poison.a")
import_static_lib(imp_absl_tracing_internal        "${ABSL_LIB_DIR}/libabsl_tracing_internal.a")
import_static_lib(imp_absl_exponential_biased      "${ABSL_LIB_DIR}/libabsl_exponential_biased.a")
import_static_lib(imp_absl_periodic_sampler        "${ABSL_LIB_DIR}/libabsl_periodic_sampler.a")

# --- Debugging ---
import_static_lib(imp_absl_stacktrace              "${ABSL_LIB_DIR}/libabsl_stacktrace.a")
import_static_lib(imp_absl_symbolize               "${ABSL_LIB_DIR}/libabsl_symbolize.a")
import_static_lib(imp_absl_examine_stack           "${ABSL_LIB_DIR}/libabsl_examine_stack.a")
import_static_lib(imp_absl_debugging_internal      "${ABSL_LIB_DIR}/libabsl_debugging_internal.a")
import_static_lib(imp_absl_demangle_internal       "${ABSL_LIB_DIR}/libabsl_demangle_internal.a")
import_static_lib(imp_absl_demangle_rust           "${ABSL_LIB_DIR}/libabsl_demangle_rust.a")
import_static_lib(imp_absl_leak_check              "${ABSL_LIB_DIR}/libabsl_leak_check.a")
import_static_lib(imp_absl_failure_signal_handler  "${ABSL_LIB_DIR}/libabsl_failure_signal_handler.a")

# --- Types & Metaprogramming ---
import_static_lib(imp_absl_int128                  "${ABSL_LIB_DIR}/libabsl_int128.a")
import_static_lib(imp_absl_bad_any_cast_impl       "${ABSL_LIB_DIR}/libabsl_bad_any_cast_impl.a")
import_static_lib(imp_absl_bad_optional_access     "${ABSL_LIB_DIR}/libabsl_bad_optional_access.a")
import_static_lib(imp_absl_bad_variant_access      "${ABSL_LIB_DIR}/libabsl_bad_variant_access.a")

# --- Strings & Formatting ---
import_static_lib(imp_absl_strings                 "${ABSL_LIB_DIR}/libabsl_strings.a")
import_static_lib(imp_absl_strings_internal        "${ABSL_LIB_DIR}/libabsl_strings_internal.a")
import_static_lib(imp_absl_string_view             "${ABSL_LIB_DIR}/libabsl_string_view.a")
import_static_lib(imp_absl_str_format_internal     "${ABSL_LIB_DIR}/libabsl_str_format_internal.a")
import_static_lib(imp_absl_cord                    "${ABSL_LIB_DIR}/libabsl_cord.a")
import_static_lib(imp_absl_cord_internal           "${ABSL_LIB_DIR}/libabsl_cord_internal.a")
import_static_lib(imp_absl_cordz_functions         "${ABSL_LIB_DIR}/libabsl_cordz_functions.a")
import_static_lib(imp_absl_cordz_handle            "${ABSL_LIB_DIR}/libabsl_cordz_handle.a")
import_static_lib(imp_absl_cordz_info              "${ABSL_LIB_DIR}/libabsl_cordz_info.a")
import_static_lib(imp_absl_cordz_sample_token      "${ABSL_LIB_DIR}/libabsl_cordz_sample_token.a")
import_static_lib(imp_absl_utf8_for_code_point     "${ABSL_LIB_DIR}/libabsl_utf8_for_code_point.a")
import_static_lib(imp_absl_decode_rust_punycode    "${ABSL_LIB_DIR}/libabsl_decode_rust_punycode.a")

# --- Status ---
import_static_lib(imp_absl_status                  "${ABSL_LIB_DIR}/libabsl_status.a")
import_static_lib(imp_absl_statusor                "${ABSL_LIB_DIR}/libabsl_statusor.a")
import_static_lib(imp_absl_strerror                "${ABSL_LIB_DIR}/libabsl_strerror.a")

# --- Time & Synchronization ---
import_static_lib(imp_absl_time                    "${ABSL_LIB_DIR}/libabsl_time.a")
import_static_lib(imp_absl_civil_time              "${ABSL_LIB_DIR}/libabsl_civil_time.a")
import_static_lib(imp_absl_time_zone               "${ABSL_LIB_DIR}/libabsl_time_zone.a")
import_static_lib(imp_absl_synchronization         "${ABSL_LIB_DIR}/libabsl_synchronization.a")
import_static_lib(imp_absl_graphcycles_internal    "${ABSL_LIB_DIR}/libabsl_graphcycles_internal.a")
import_static_lib(imp_absl_kernel_timeout_internal "${ABSL_LIB_DIR}/libabsl_kernel_timeout_internal.a")

# --- Hashing & Containers ---
import_static_lib(imp_absl_hash                    "${ABSL_LIB_DIR}/libabsl_hash.a")
import_static_lib(imp_absl_city                    "${ABSL_LIB_DIR}/libabsl_city.a")
import_static_lib(imp_absl_low_level_hash          "${ABSL_LIB_DIR}/libabsl_low_level_hash.a")
import_static_lib(imp_absl_raw_hash_set            "${ABSL_LIB_DIR}/libabsl_raw_hash_set.a")
import_static_lib(imp_absl_hashtablez_sampler      "${ABSL_LIB_DIR}/libabsl_hashtablez_sampler.a")
import_static_lib(imp_absl_hashtable_profiler      "${ABSL_LIB_DIR}/libabsl_hashtable_profiler.a")

# --- CRC (Explicitly listing these now based on your file list) ---
import_static_lib(imp_absl_crc32c                  "${ABSL_LIB_DIR}/libabsl_crc32c.a")
import_static_lib(imp_absl_crc_cord_state          "${ABSL_LIB_DIR}/libabsl_crc_cord_state.a")
import_static_lib(imp_absl_crc_cpu_detect          "${ABSL_LIB_DIR}/libabsl_crc_cpu_detect.a")
import_static_lib(imp_absl_crc_internal            "${ABSL_LIB_DIR}/libabsl_crc_internal.a")

# --- Random ---
import_static_lib(imp_absl_random_distributions    "${ABSL_LIB_DIR}/libabsl_random_distributions.a")
import_static_lib(imp_absl_random_internal_distribution_test_util "${ABSL_LIB_DIR}/libabsl_random_internal_distribution_test_util.a")
import_static_lib(imp_absl_random_internal_platform "${ABSL_LIB_DIR}/libabsl_random_internal_platform.a")
import_static_lib(imp_absl_random_internal_pool_urbg "${ABSL_LIB_DIR}/libabsl_random_internal_pool_urbg.a")
import_static_lib(imp_absl_random_internal_randen  "${ABSL_LIB_DIR}/libabsl_random_internal_randen.a")
import_static_lib(imp_absl_random_internal_randen_hwaes "${ABSL_LIB_DIR}/libabsl_random_internal_randen_hwaes.a")
import_static_lib(imp_absl_random_internal_randen_hwaes_impl "${ABSL_LIB_DIR}/libabsl_random_internal_randen_hwaes_impl.a")
import_static_lib(imp_absl_random_internal_randen_slow "${ABSL_LIB_DIR}/libabsl_random_internal_randen_slow.a")
import_static_lib(imp_absl_random_internal_seed_material "${ABSL_LIB_DIR}/libabsl_random_internal_seed_material.a")
import_static_lib(imp_absl_random_seed_gen_exception "${ABSL_LIB_DIR}/libabsl_random_seed_gen_exception.a")
import_static_lib(imp_absl_random_seed_sequences   "${ABSL_LIB_DIR}/libabsl_random_seed_sequences.a")

# --- Flags ---
import_static_lib(imp_absl_flags_commandlineflag   "${ABSL_LIB_DIR}/libabsl_flags_commandlineflag.a")
import_static_lib(imp_absl_flags_commandlineflag_internal "${ABSL_LIB_DIR}/libabsl_flags_commandlineflag_internal.a")
import_static_lib(imp_absl_flags_config            "${ABSL_LIB_DIR}/libabsl_flags_config.a")
import_static_lib(imp_absl_flags_internal          "${ABSL_LIB_DIR}/libabsl_flags_internal.a")
import_static_lib(imp_absl_flags_marshalling       "${ABSL_LIB_DIR}/libabsl_flags_marshalling.a")
import_static_lib(imp_absl_flags_parse             "${ABSL_LIB_DIR}/libabsl_flags_parse.a")
import_static_lib(imp_absl_flags_private_handle_accessor "${ABSL_LIB_DIR}/libabsl_flags_private_handle_accessor.a")
import_static_lib(imp_absl_flags_program_name      "${ABSL_LIB_DIR}/libabsl_flags_program_name.a")
import_static_lib(imp_absl_flags_reflection        "${ABSL_LIB_DIR}/libabsl_flags_reflection.a")
import_static_lib(imp_absl_flags_usage             "${ABSL_LIB_DIR}/libabsl_flags_usage.a")
import_static_lib(imp_absl_flags_usage_internal    "${ABSL_LIB_DIR}/libabsl_flags_usage_internal.a")

# --- Logging ---
import_static_lib(imp_absl_log_entry               "${ABSL_LIB_DIR}/libabsl_log_entry.a")
import_static_lib(imp_absl_log_flags               "${ABSL_LIB_DIR}/libabsl_log_flags.a")
import_static_lib(imp_absl_log_globals             "${ABSL_LIB_DIR}/libabsl_log_globals.a")
import_static_lib(imp_absl_log_initialize          "${ABSL_LIB_DIR}/libabsl_log_initialize.a")
import_static_lib(imp_absl_log_internal_check_op   "${ABSL_LIB_DIR}/libabsl_log_internal_check_op.a")
import_static_lib(imp_absl_log_internal_conditions "${ABSL_LIB_DIR}/libabsl_log_internal_conditions.a")
import_static_lib(imp_absl_log_internal_fnmatch    "${ABSL_LIB_DIR}/libabsl_log_internal_fnmatch.a")
import_static_lib(imp_absl_log_internal_format     "${ABSL_LIB_DIR}/libabsl_log_internal_format.a")
import_static_lib(imp_absl_log_internal_globals    "${ABSL_LIB_DIR}/libabsl_log_internal_globals.a")
import_static_lib(imp_absl_log_internal_log_sink_set "${ABSL_LIB_DIR}/libabsl_log_internal_log_sink_set.a")
import_static_lib(imp_absl_log_internal_message    "${ABSL_LIB_DIR}/libabsl_log_internal_message.a")
import_static_lib(imp_absl_log_internal_nullguard  "${ABSL_LIB_DIR}/libabsl_log_internal_nullguard.a")
import_static_lib(imp_absl_log_internal_proto      "${ABSL_LIB_DIR}/libabsl_log_internal_proto.a")
import_static_lib(imp_absl_log_internal_structured_proto "${ABSL_LIB_DIR}/libabsl_log_internal_structured_proto.a")
import_static_lib(imp_absl_log_sink                "${ABSL_LIB_DIR}/libabsl_log_sink.a")
import_static_lib(imp_absl_vlog_config_internal    "${ABSL_LIB_DIR}/libabsl_vlog_config_internal.a")
import_static_lib(imp_absl_die_if_null             "${ABSL_LIB_DIR}/libabsl_die_if_null.a")
