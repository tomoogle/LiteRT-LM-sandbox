set(STD_CMAKE_ARGS
  "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
  "-DCMAKE_POLICY_DEFAULT_CMP0169=OLD"
  "-DCMAKE_CXX_STANDARD=17"
  "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
)


set(THE_LINKER_HAMMER_FLAGS
  "-L${ABSL_INSTALL_PREFIX}/lib -L${PROTO_INSTALL_PREFIX}/lib -L${SENTENCE_INSTALL_PREFIX}/lib"
  "-Wl,--start-group"
  "-lprotobuf -lutf8_range -lsentencepiece -lsentencepiece_train"
  "-labsl_status -labsl_statusor -labsl_strings -labsl_str_format_internal" 
  "-labsl_synchronization -labsl_time -labsl_base -labsl_throw_delegate"
  "-labsl_raw_logging_internal -labsl_log_internal_check_op"
  "-labsl_time_zone -labsl_utf8_for_code_point"
  "-Wl,--end-group"
  "-lpthread"
)
string(REPLACE ";" " " THE_LINKER_HAMMER_STRING "${THE_LINKER_HAMMER_FLAGS}")
