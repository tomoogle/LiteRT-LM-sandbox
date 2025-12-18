include(ExternalProject)


set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})


set(TOKENIZER_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/tokenizers-cpp)
set(TOKENIZER_INSTALL_PREFIX ${TOKENIZER_EXT_PREFIX}/install)
set(TOKENIZER_CONFIG_CMAKE_FILE "${TOKENIZER_INSTALL_PREFIX}/lib/cmake/msgpack-cxx/msgpack-cxx-config.cmake")

if(NOT EXISTS "${TOKENIZER_CONFIG_CMAKE_FILE}") 
  message(STATUS "tokenizers-cpp not found. Configuring external build...")
  ExternalProject_Add(
    tokenizers-cpp_external
    DEPENDS 
      absl_external
      protobuf_external
      googletest_external
    GIT_REPOSITORY
        https://github.com/mlc-ai/tokenizers-cpp
    GIT_TAG
        main
    PREFIX
        ${EXTERNAL_PROJECT_BINARY_DIR}/tokenizers-cpp
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E env 
      "LDFLAGS=-L${ABSL_INSTALL_PREFIX}/lib -L${PROTO_INSTALL_PREFIX}/lib"
      "CXXFLAGS=-I${ABSL_INSTALL_PREFIX}/include -I${PROTO_INSTALL_PREFIX}/include"
      ${CMAKE_COMMAND} -S <SOURCE_DIR> -B <BINARY_DIR>
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
        -DCMAKE_INSTALL_PREFIX=${TOKENIZER_INSTALL_PREFIX}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
        -DCMAKE_CXX_STANDARD=17
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        # "-DCMAKE_CXX_STANDARD_LIBRARIES=-lprotobuf -lutf8_range -Wl,--start-group -labsl_status -labsl_statusor -labsl_raw_logging_internal -labsl_base -labsl_throw_delegate -labsl_int128 -labsl_log_internal_check_op -labsl_log_internal_message -labsl_log_internal_nullguard -labsl_strings -labsl_string_view -labsl_synchronization -labsl_debugging_internal -labsl_time -labsl_time_zone -labsl_utf8_for_code_point -Wl,--end-group -lpthread"
  )

else()
    message(STATUS "tokenizers-cpp already installed at: ${TOKENIZER_INSTALL_PREFIX}")
    if(NOT TARGET tokenizers-cpp_external)
        add_custom_target(tokenizers-cpp_external)
    endif()
endif()

    # ExternalProject_Add(
    #     tokenizers_external
    #     GIT_REPOSITORY
    #         https://github.com/mlc-ai/tokenizers-cpp
    #     GIT_TAG
    #         main
    #     PREFIX
    #         ${EXTERNAL_PROJECT_BINARY_DIR}/tokenizers-cpp
    #     # PATCH_COMMAND ${CMAKE_COMMAND} -E echo "Performing surgery on tokenizers-cpp..."
    #     #     COMMAND sed -i "s/add_subdirectory(sentencepiece/# add_subdirectory(sentencepiece/" <SOURCE_DIR>/CMakeLists.txt
    #     #     COMMAND sed -i "s/target_link_libraries(tokenizers_cpp PRIVATE tokenizers_c sentencepiece-static/target_link_libraries(tokenizers_cpp PRIVATE tokenizers_c/" <SOURCE_DIR>/CMakeLists.txt
    #     # CMAKE_ARGS
    #     #     -DCMAKE_INSTALL_PREFIX=${SENTENCE_INSTALL_PREFIX}
    #     #     -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    #     #     -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
    #     #     -DCMAKE_CXX_STANDARD=17
    #     #     -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
    #     #     -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    #     #     -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    #     #     -DSPM_ENABLE_TCMALLOC=OFF
    #     #     -DSPM_PROTOBUF_PROVIDER=package
    #     #     -DSPM_ABSL_PROVIDER=package
    #     #     -DCMAKE_EXE_LINKER_FLAGS=${THE_LINKER_HAMMER_STRING}
    #     #     -DCMAKE_CXX_STANDARD_LIBRARIES=${THE_LINKER_HAMMER_STRING}
