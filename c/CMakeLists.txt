set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})


set(C_ENGINE_SRCS
  "${GEN_C_DIR}/engine.cc"
  "${GEN_C_DIR}/litert_lm_logging.cc"
)
add_litert_static_library(c_engine ${C_ENGINE_SRCS})
# add_library(c_engine STATIC
#   ${C_ENGINE_SRCS}
# )

target_include_directories(c_engine 
  PRIVATE
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}/json/include
    ${THIRD_PARTY_DIR}/minja/include
)

target_link_libraries(c_engine
  PRIVATE
    litert_libs
    LITERTLM_DEPS
    proto_lib
)


# _clean_path( c_engine_test_src
#   engine_test.cc
# )

# add_executable(c_engine_test
#   ${c_engine_test_src}
# )

# target_link_libraries(c_engine_test PRIVATE 
#   c_engine 
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )

# add_test(NAME c_engine_test COMMAND engine_test)


add_library(litert_lm_c_libs INTERFACE)
target_link_libraries(litert_lm_c_libs INTERFACE
  c_engine
)
