include(ExternalProject)


set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})


set(SENTENCE_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/sentencepiece)
set(SENTENCE_INSTALL_PREFIX ${SENTENCE_EXT_PREFIX}/install)
set(SENTENCE_CONFIG_CMAKE_FILE "${SENTENCE_INSTALL_PREFIX}/lib/cmake/sentence/sentence-config.cmake")


if(NOT EXISTS "${SENTENCE_CONFIG_CMAKE_FILE}")
  message(STATUS "Sentencepiece not found. Configuring external build...")
  ExternalProject_Add(
    sentencepiece_external
    DEPENDS
      protobuf_external
    GIT_REPOSITORY
      https://github.com/google/sentencepiece/
    GIT_TAG
      v0.2.1
    PREFIX
      ${SENTENCE_EXT_PREFIX}
    
    CONFIGURE_COMMAND
      ${CMAKE_COMMAND} -E env 
      "LDFLAGS=-L${ABSL_INSTALL_PREFIX}/lib -L${PROTO_INSTALL_PREFIX}/lib"
      "CXXFLAGS=-I${ABSL_INSTALL_PREFIX}/include -I${PROTO_INSTALL_PREFIX}/include"
      ${CMAKE_COMMAND} -S <SOURCE_DIR> -B <BINARY_DIR>
        -DCMAKE_INSTALL_PREFIX=${SENTENCE_INSTALL_PREFIX}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_CXX_STANDARD=17
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DSPM_PROTOBUF_PROVIDER=package
        -DSPM_ABSL_PROVIDER=package
        
        # Config Mode
        -DProtobuf_DIR=${PROTO_INSTALL_PREFIX}/lib/cmake/protobuf
        -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
        # Fallback
        -DProtobuf_INCLUDE_DIR=${PROTO_INSTALL_PREFIX}/include
        -DProtobuf_LITE_LIBRARY=${PROTO_INSTALL_PREFIX}/lib/libprotobuf.a
        -DProtobuf_LIBRARY=${PROTO_INSTALL_PREFIX}/lib/libprotobuf.a
        -DProtobuf_PROTOC_EXECUTABLE=${PROTO_INSTALL_PREFIX}/bin/protoc
        
        "-DCMAKE_CXX_STANDARD_LIBRARIES=-lprotobuf -lutf8_range -Wl,--start-group -labsl_status -labsl_statusor -labsl_raw_logging_internal -labsl_base -labsl_throw_delegate -labsl_int128 -labsl_log_internal_check_op -labsl_log_internal_message -labsl_log_internal_nullguard -labsl_strings -labsl_string_view -labsl_synchronization -labsl_debugging_internal -labsl_time -labsl_time_zone -labsl_utf8_for_code_point -Wl,--end-group -lpthread"
  )
# verify_install(sentencepiece_external ${SENTENCE_CONFIG_CMAKE_FILE})

else()
  message(STATUS "Sentencepiece already installed at: ${SENTENCE_INSTALL_PREFIX}")
  if(NOT TARGET sentencepiece_external)
    add_custom_target(sentencepiece_external)
  endif()
endif()
