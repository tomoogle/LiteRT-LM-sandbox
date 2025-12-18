include(ExternalProject)



set(ABSL_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/abseil-cpp)
set(ABSL_INSTALL_PREFIX ${ABSL_EXT_PREFIX}/install)
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





# add_custom_command(
#     OUTPUT ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete
#     COMMAND ${CMAKE_COMMAND} -E chdir ${LITERT_EXTRACTED_DIR} ar x ${ARCHIVE_PATH}
#     COMMAND ${CMAKE_COMMAND} -E touch ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete
#     DEPENDS ${target_name}
#     VERBATIM
# )

# ExternalProject_Get_Property(absl_external INSTALL_DIR BINARY_DIR)
# set(ABSL_INSTALL_DIR ${INSTALL_DIR})
# set(ABSL_BUILD_DIR ${BINARY_DIR})

# set(ABSL_INCLUDE_DIR
#     "$<BUILD_INTERFACE:${BINARY_DIR}/include>"
#     # "$<BUILD_INTERFACE:${EXTERNAL_PROJECT_BINARY_DIR_absl_external>"
# )



# # --- ABSEIL BASE MODULES ---

# define_imported_target(
#   _absl_base_core
#   "libabsl_base.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/base"
# )
# define_imported_target(
#   _absl_base_malc_int
#   "libabsl_malloc_internal.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/base"
# )
# define_imported_target(
#   _absl_base_raw_log_int
#   "libabsl_raw_logging_internal.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/base"
# )
# define_imported_target(
#   _absl_base_strerr
#   "libabsl_strerror.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/base"
# )
# define_imported_target(
#   _absl_base_thr_delg
#   "libabsl_throw_delegate.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/base"
# )
# define_imported_target(
#   _absl_t_base_log_svry
#   "libabsl_log_severity.a"
#   "${ABSL_TFLITE_BUILD_DIR}/absl/base"
# )
# define_imported_target(
#   _absl_t_base_splck_wt
#   "libabsl_spinlock_wait.a"
#   "${ABSL_TFLITE_BUILD_DIR}/absl/base"
# )

# set(absl_base_targets
#   _absl_base_core
#   _absl_base_malc_int
#   _absl_base_raw_log_int
#   _absl_base_strerr
#   _absl_base_thr_delg
#   _absl_t_base_log_svry
#   _absl_t_base_splck_wt

# )
# add_library(absl_base_libs INTERFACE)
# target_link_libraries(absl_base_libs INTERFACE
#     ${absl_base_targets}
# )


# # --- CONTAINER MODULES ---

# define_imported_target(
#     _absl_cont_raw_hsh_st
#     "libabsl_raw_hash_set.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/container"
# )
# define_imported_target(
#     _absl_cont_hsh_smplr
#     "libabsl_hashtablez_sampler.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/container"
# )

# set(absl_container_targets
# 	_absl_cont_raw_hsh_st
#   _absl_cont_hsh_smplr
# )
# add_library(absl_container_libs INTERFACE)
# target_link_libraries(absl_container_libs INTERFACE
# 	${absl_container_targets}
# )


# # --- ABSEIL CRC MODULES ---

# define_imported_target(
#     _absl_crc_crc32c
#     "libabsl_crc32c.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/crc"
# )
# define_imported_target(
#     _absl_crc_crc_crd_st
#     "libabsl_crc_cord_state.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/crc"
# )
# define_imported_target(
#     _absl_crc_crc_cpu_d
#     "libabsl_crc_cpu_detect.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/crc"
# )
# define_imported_target(
#     _absl_crc_crc_int
#     "libabsl_crc_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/crc"
# )

# set(absl_crc_targets
#   _absl_crc_crc32c
#   _absl_crc_crc_crd_st
#   _absl_crc_crc_cpu_d
#   _absl_crc_crc_int
# )
# add_library(absl_crc_libs INTERFACE)
# target_link_libraries(absl_crc_libs INTERFACE
#   ${absl_crc_libs}
# )



# # --- ABSEIL DEBUGGING MODULES ---

# define_imported_target(
#     _absl_dbg_dbg_int
#     "libabsl_debugging_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/debugging"
# )
# define_imported_target(
#     _absl_dbg_exm_stk
#     "libabsl_examine_stack.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/debugging"
# )
# define_imported_target(
#     _absl_dbg_fail_s_h
#     "libabsl_failure_signal_handler.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/debugging"
# )
# define_imported_target(
#     _absl_dbg_lk_chk
#     "libabsl_leak_check.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/debugging"
# )
# define_imported_target(
#     _absl_dbg_stk_trc
#     "libabsl_stacktrace.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/debugging"
# )
# define_imported_target(
#     _absl_dbg_smb
#     "libabsl_symbolize.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/debugging"
# )
# define_imported_target(
#     _absl_dbg_dem_int
#     "libabsl_demangle_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/debugging"
# )
# define_imported_target(
#     _absl_dbg_dcd_rst_p
#     "libabsl_decode_rust_punycode.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/debugging"
# )
# define_imported_target(
#     _absl_dbg_dem_rst
#     "libabsl_demangle_rust.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/debugging"
# )
# define_imported_target(
#     _absl_dbg_utf8_c_p
#     "libabsl_utf8_for_code_point.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/debugging"
# )

# set(absl_debugging_targets
#   _absl_dbg_dbg_int
#   _absl_dbg_exm_stk
#   _absl_dbg_fail_s_h
#   _absl_dbg_lk_chk
#   _absl_dbg_stk_trc
#   _absl_dbg_smb
#   _absl_dbg_dem_int
#   _absl_dbg_dcd_rst_p
#   _absl_dbg_dem_rst
#   _absl_dbg_utf8_c_p
# )
# add_library(absl_debugging_libs INTERFACE)
# target_link_libraries(absl_debugging_libs INTERFACE
#   ${absl_debugging_libs}
# )


# # --- ABSEIL FLAGS MODULES ---

# define_imported_target(
#     _absl_flg_cmd_flg
#     "libabsl_flags_commandlineflag.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )
# define_imported_target(
#     _absl_flg_cfg
#     "libabsl_flags_config.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )
# define_imported_target(
#     _absl_flg_int
#     "libabsl_flags_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )
# define_imported_target(
#     _absl_flg_mshl
#     "libabsl_flags_marshalling.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )
# define_imported_target(
#     _absl_flg_prs
#     "libabsl_flags_parse.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )
# define_imported_target(
#     _absl_flg_prvt_hndl
#     "libabsl_flags_private_handle_accessor.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )
# define_imported_target(
#     _absl_flg_prgm_nm
#     "libabsl_flags_program_name.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )
# define_imported_target(
#     _absl_flg_rflc
#     "libabsl_flags_reflection.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )
# define_imported_target(
#     _absl_flg_usg
#     "libabsl_flags_usage.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )
# define_imported_target(
#     _absl_flg_cmd_flg_int
#     "libabsl_flags_commandlineflag_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )
# define_imported_target(
#     _absl_flg_usg_int
#     "libabsl_flags_usage_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/flags"
# )


# set(absl_flags_targets
#   _absl_flg_cmd_flg
#   _absl_flg_cfg
#   _absl_flg_int
#   _absl_flg_mshl
#   _absl_flg_prs
#   _absl_flg_prvt_hndl
#   _absl_flg_prgm_nm
#   _absl_flg_rflc
#   _absl_flg_usg
#   _absl_flg_cmd_flg_int
#   _absl_flg_usg_int
# )
# add_library(absl_flags_libs INTERFACE)
# target_link_libraries(absl_flags_libs INTERFACE
#   ${absl_flags_targets}
# )



# # --- ABSEIL LOG MODULES ---

# define_imported_target(
#   _absl_log_die_if_nll
#   "libabsl_die_if_null.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_entry
#   "libabsl_log_entry.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_flg
#   "libabsl_log_flags.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_glb
#   "libabsl_log_globals.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_init
#   "libabsl_log_initialize.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_int_chk_op
#   "libabsl_log_internal_check_op.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_int_msg
#   "libabsl_log_internal_message.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_snk
#   "libabsl_log_sink.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_int_log_snk_set
#   "libabsl_log_internal_log_sink_set.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_int_fmt
#   "libabsl_log_internal_format.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_int_stct_proto
#   "libabsl_log_internal_structured_proto.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_int_proto
#   "libabsl_log_internal_proto.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )
# define_imported_target(
#   _absl_log_int_fnm
#   "libabsl_log_internal_fnmatch.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )

# define_imported_target(
#   _absl_log_int_cnd
#   "libabsl_log_internal_conditions.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )

# define_imported_target(
#   _absl_log_int_glb
#   "libabsl_log_internal_globals.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )

# define_imported_target(
#   _absl_log_int_nullgrd
#   "libabsl_log_internal_nullguard.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/log"
# )



# set(absl_log_targets
#   _absl_log_die_if_nll
#   _absl_log_entry
#   _absl_log_flg
#   _absl_log_glb
#   _absl_log_init
#   _absl_log_int_chk_op
#   _absl_log_int_msg
#   _absl_log_snk
#   _absl_log_int_log_snk_set
#   _absl_log_int_fmt
#   _absl_log_int_stct_proto
#   _absl_log_int_proto
#   _absl_log_int_fnm
#   _absl_log_int_cnd
#   _absl_log_int_glb
#   _absl_log_int_nullgrd
# )
# add_library(absl_log_libs INTERFACE)
# target_link_libraries(absl_log_libs INTERFACE
# ${absl_log_targets}
# )



# # --- ABSEIL NUMERIC MODULES ---

# define_imported_target(
#     _absl_nmr_int128
#     "libabsl_int128.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/numeric"
# )

# set(absl_numeric_targets
#   _absl_nmr_int128
# )
# add_library(absl_numeric_libs INTERFACE)
# target_link_libraries(absl_numeric_libs INTERFACE
#   ${absl_numeric_targets}
# )


# # --- ABSEIL PROFILING MODULES ---

# define_imported_target(
#     _absl_prf_exp_b
#     "libabsl_exponential_biased.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/profiling"
# )
# define_imported_target(
#     _absl_prf_hsh_prfl
#     "libabsl_hashtable_profiler.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/profiling"
# )
# define_imported_target(
#     _absl_prf_prdc_smplr
#     "libabsl_periodic_sampler.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/profiling"
# )
# define_imported_target(
#     _absl_prf_prfl_bldr
#     "libabsl_profile_builder.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/profiling"
# )

# set(absl_profiling_targets
#   _absl_prf_exp_b
#   _absl_prf_hsh_prfl
#   _absl_prf_prdc_smplr
#   _absl_prf_prfl_bldr
# )
# add_library(absl_profiling_libs INTERFACE)
# target_link_libraries(absl_profiling_libs INTERFACE
#   ${absl_profiling_targets}
# )


# # --- ABSEIL HASH MODULES ---
# define_imported_target(
#     _absl_hash
#     "libabsl_hash.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/hash"
# )

# define_imported_target(
#     _absl_hash_city
#     "libabsl_city.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/hash"
# )

# set(absl_hash_targets
#   _absl_hash
#   _absl_hash_city
# )
# add_library(absl_hash_libs INTERFACE)
# target_link_libraries(absl_hash_libs INTERFACE
#   absl_hash_targets
# )


# # --- ABSEIL RANDOM MODULES ---

# define_imported_target(
# 	_absl_random_dis
# 	"libabsl_random_distributions.a"
# 	"${ABSL_LITERT_BUILD_DIR}/absl/random"
# )
# define_imported_target(
#   _absl_random_int_dis_test_util
#   "libabsl_random_internal_distribution_test_util.a"
#   "${ABSL_LITERT_BUILD_DIR}/absl/random"
# )
# define_imported_target(
# 	_absl_random_entr
# 	"libabsl_random_internal_entropy_pool.a"
# 	"${ABSL_LITERT_BUILD_DIR}/absl/random"
# )
# define_imported_target(
# 	_absl_random_plt
# 	"libabsl_random_internal_platform.a"
# 	"${ABSL_LITERT_BUILD_DIR}/absl/random"
# )
# define_imported_target(
# 	_absl_random_rndn
# 	"libabsl_random_internal_randen.a"
# 	"${ABSL_LITERT_BUILD_DIR}/absl/random"
# )
# define_imported_target(
# 	_absl_random_rndn_hwaes
# 	"libabsl_random_internal_randen_hwaes.a"
# 	"${ABSL_LITERT_BUILD_DIR}/absl/random"
# )
# define_imported_target(
# 	_absl_random_hwaes_impl
# 	"libabsl_random_internal_randen_hwaes_impl.a"
# 	"${ABSL_LITERT_BUILD_DIR}/absl/random"
# )
# define_imported_target(
# 	_absl_random_rndn_slow
# 	"libabsl_random_internal_randen_slow.a"
# 	"${ABSL_LITERT_BUILD_DIR}/absl/random"
# )
# define_imported_target(
# 	_absl_random_sd_mtrl
# 	"libabsl_random_internal_seed_material.a"
# 	"${ABSL_LITERT_BUILD_DIR}/absl/random"
# )
# define_imported_target(
# 	_absl_random_sd_gn_excp
# 	"libabsl_random_seed_gen_exception.a"
# 	"${ABSL_LITERT_BUILD_DIR}/absl/random"
# )
# define_imported_target(
# 	_absl_random_sd_seq
# 	"libabsl_random_seed_sequences.a"
# 	"${ABSL_LITERT_BUILD_DIR}/absl/random"
# )

# set(absl_random_targets
#   _absl_random_dis
#   _absl_random_int_dis_test_util
#   _absl_random_entr
#   _absl_random_plt
#   _absl_random_rndn
#   _absl_random_rndn_hwaes
#   _absl_random_hwaes_impl
#   _absl_random_rndn_slow
#   _absl_random_sd_mtrl
#   _absl_random_sd_gn_excp
#   _absl_random_sd_seq
# )
# add_library(absl_random_libs INTERFACE)
# target_link_libraries(absl_random_libs INTERFACE
#   ${absl_random_targets}
# )



# # --- ABSEIL STATUS MODULES ---

# define_imported_target(
#     _absl_sts_core
#     "libabsl_status.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/status"
# )
# define_imported_target(
#     _absl_sts_or
#     "libabsl_statusor.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/status"
# )

# set(absl_status_targets
#   _absl_sts_core
#   _absl_sts_or
# )
# add_library(absl_status_libs INTERFACE)
# target_link_libraries(absl_status_libs INTERFACE
#   ${absl_status_targets}
# )



# # --- ABSEIL STRINGS MODULES ---

# define_imported_target(
#     _absl_str_cord
#     "libabsl_cord.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/strings"
# )
# define_imported_target(
#     _absl_str_cord_int
#     "libabsl_cord_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/strings"
# )
# define_imported_target(
#     _absl_str_cdz_fncs
#     "libabsl_cordz_functions.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/strings"
# )
# define_imported_target(
#     _absl_str_cdz_hndl
#     "libabsl_cordz_handle.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/strings"
# )
# define_imported_target(
#     _absl_str_cdz_inf
#     "libabsl_cordz_info.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/strings"
# )
# define_imported_target(
#     _absl_str_cdz_smpl_tkn
#     "libabsl_cordz_sample_token.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/strings"
# )
# define_imported_target(
#     _absl_str_fmt_int
#     "libabsl_str_format_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/strings"
# )
# define_imported_target(
#     _absl_str_core
#     "libabsl_strings.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/strings"
# )
# define_imported_target(
#     _absl_str_int
#     "libabsl_strings_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/strings"
# )
# define_imported_target(
#     _absl_str_vw
#     "libabsl_string_view.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/strings"
# )

# set(absl_strings_targets
#   _absl_str_cord
#   _absl_str_cord_int
#   _absl_str_cdz_fncs
#   _absl_str_cdz_hndl
#   _absl_str_cdz_inf
#   _absl_str_cdz_smpl_tkn
#   _absl_str_fmt_int
#   _absl_str_core
#   _absl_str_int
#   _absl_str_vw
# )
# add_library(absl_strings_libs INTERFACE)
# target_link_libraries(absl_strings_libs INTERFACE
#   ${absl_stings_targets}
# )



# # --- ABSEIL SYNCHRONIZATION MODULES ---

# define_imported_target(
#     _absl_sync_core
#     "libabsl_synchronization.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/synchronization"
# )
# define_imported_target(
#     _absl_sync_grph_cycl_int
#     "libabsl_graphcycles_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/synchronization"
# )
# define_imported_target(
#     _absl_sync_krnl_tmo_int
#     "libabsl_kernel_timeout_internal.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/synchronization"
# )

# set(absl_synchronization_targets
#   _absl_sync_core
#   _absl_sync_grph_cycl_int
#   _absl_sync_krnl_tmo_int
# )
# add_library(absl_synchronization_libs INTERFACE)
# target_link_libraries(absl_synchronization_libs INTERFACE
#   ${absl_synchronization_targets}
# )


# # --- ABSEIL TIME MODULES ---

# define_imported_target(
#     _absl_time_core
#     "libabsl_time.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/time"
# )
# define_imported_target(
#     _absl_time_cvl
#     "libabsl_civil_time.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/time"
# )
# define_imported_target(
#     _absl_time_zone
#     "libabsl_time_zone.a"
#     "${ABSL_LITERT_BUILD_DIR}/absl/time"
# )

# set(absl_time_targets
#   _absl_time_core
#   _absl_time_cvl
#   _absl_time_zone
# )
# add_library(absl_time_libs INTERFACE)
# target_link_libraries(absl_time_libs INTERFACE
#   ${absl_time_targets}
# )
