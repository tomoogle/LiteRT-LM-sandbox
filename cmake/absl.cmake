# --- Abseil Targets Imported from LiteRT's Internal Build ---
# Note: The 'lib_subdir' path points to LiteRT's internal tflite_build/_deps/abseil-cpp-build/
set(ABSL_BUILD_DIR "tflite_build/_deps/abseil-cpp-build")

# 1. Base & Utilities
define_litert_target(absl_base             "libabsl_base.a"                   "${ABSL_BUILD_DIR}/absl/base")
define_litert_target(absl_base_internal    "libabsl_malloc_internal.a"        "${ABSL_BUILD_DIR}/absl/base")
define_litert_target(absl_raw_logging      "libabsl_raw_logging_internal.a"   "${ABSL_BUILD_DIR}/absl/base")
define_litert_target(absl_strerror         "libabsl_strerror.a"               "${ABSL_BUILD_DIR}/absl/base")
define_litert_target(absl_throw_delegate   "libabsl_throw_delegate.a"         "${ABSL_BUILD_DIR}/absl/base")

# 2. Status & Error
define_litert_target(absl_status           "libabsl_status.a"                 "${ABSL_BUILD_DIR}/absl/status")
define_litert_target(absl_statusor         "libabsl_statusor.a"               "${ABSL_BUILD_DIR}/absl/status")

# 3. Logging (Resolves the absl::lts_20250814::log_internal... symbols)
define_litert_target(absl_check            "libabsl_check.a"                  "${ABSL_BUILD_DIR}/absl/base")
define_litert_target(absl_log              "libabsl_log_internal_message.a"   "${ABSL_BUILD_DIR}/absl/log")
define_litert_target(absl_log_internal_message "libabsl_log_internal_message.a" "${ABSL_BUILD_DIR}/absl/log")
define_litert_target(absl_log_initialize   "libabsl_log_initialize.a"         "${ABSL_BUILD_DIR}/absl/log")
define_litert_target(absl_log_internal_check_op "libabsl_log_internal_check_op.a" "${ABSL_BUILD_DIR}/absl/log")
define_litert_target(absl_log_internal_format "libabsl_log_internal_format.a"   "${ABSL_BUILD_DIR}/absl/log")
define_litert_target(absl_log_internal_globals "libabsl_log_internal_globals.a" "${ABSL_BUILD_DIR}/absl/log")
define_litert_target(absl_log_sink         "libabsl_log_sink.a"               "${ABSL_BUILD_DIR}/absl/log")

# 4. Strings & Formatting
define_litert_target(absl_strings_lib      "libabsl_strings.a"                "${ABSL_BUILD_DIR}/absl/strings")
define_litert_target(absl_str_format       "libabsl_str_format_internal.a"    "${ABSL_BUILD_DIR}/absl/strings")
define_litert_target(absl_span             "libabsl_span.a"                   "${ABSL_BUILD_DIR}/absl/types")

# 5. Containers, Hashing & Sync
define_litert_target(absl_flat_hash_map    "libabsl_raw_hash_set.a"           "${ABSL_BUILD_DIR}/absl/container")
define_litert_target(absl_hash             "libabsl_hash.a"                   "${ABSL_BUILD_DIR}/absl/hash")
define_litert_target(absl_synchronization  "libabsl_synchronization.a"        "${ABSL_BUILD_DIR}/absl/synchronization")

# 6. Flags & Random (If needed by other components)
define_litert_target(absl_flags            "libabsl_flags_internal.a"         "${ABSL_BUILD_DIR}/absl/flags")
define_litert_target(absl_flags_commandlineflag "libabsl_flags_commandlineflag.a" "${ABSL_BUILD_DIR}/absl/flags")
define_litert_target(absl_flags_internal   "libabsl_flags_internal.a"         "${ABSL_BUILD_DIR}/absl/flags")
define_litert_target(absl_random_random    "libabsl_random_internal_randen.a" "${ABSL_BUILD_DIR}/absl/random")


define_litert_target(absl_flags_program_name "libabsl_flags_program_name.a"     "${ABSL_BUILD_DIR}/absl/flags")
define_litert_target(absl_flags_registry    "libabsl_flags_registry.a"         "${ABSL_BUILD_DIR}/absl/flags")
define_litert_target(absl_flags_marshalling "libabsl_flags_marshalling.a"      "${ABSL_BUILD_DIR}/absl/flags")
# NOTE: Check if your internal LiteRT build generated a 'core' or 'builders' archive for status:
define_litert_target(absl_status_builders   "libabsl_status_builders.a"        "${ABSL_BUILD_DIR}/absl/status")
define_litert_target(absl_status_core       "libabsl_status_core.a"            "${ABSL_BUILD_DIR}/absl/status")

# Synchronization (Resolves Mutex::unlock)
define_litert_target(absl_synchronization_core "libabsl_synchronization_core.a" "${ABSL_BUILD_DIR}/absl/synchronization")