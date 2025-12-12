set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_library(runtime_components_tool_use_json_parser_utils STATIC
  json_parser_utils.cc
)
target_include_directories(runtime_components_tool_use_json_parser_utils 
  PRIVATE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}/antlr_generated
  )
target_link_libraries(runtime_components_tool_use_json_parser_utils
  PUBLIC
    runtime_components_tool_use_parser_common
    antlr_json_tool_call_parser
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_executable(runtime_components_tool_use_json_parser_utils_test
#   json_parser_utils_test.cc
# )
# target_link_libraries(runtime_components_tool_use_json_parser_utils_test PRIVATE
#   runtime_components_tool_use_json_parser_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_util_test_utils)
# add_test(NAME runtime_components_tool_use_json_parser_utils_test COMMAND runtime_components_tool_use_json_parser_utils_test)

add_library(runtime_components_tool_use_parser_common STATIC
  parser_common.cc
)
target_include_directories(runtime_components_tool_use_parser_common
  PRIVATE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}/antlr_generated
  )
target_link_libraries(runtime_components_tool_use_parser_common
  PUBLIC
    antlr_json_tool_call_parser
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_executable(runtime_components_tool_use_parser_common_test
#   parser_common_test.cc
# )
# target_link_libraries(runtime_components_tool_use_parser_common_test PRIVATE runtime_components_tool_use_parser_common com_google_googletest_gtest_main)
# add_test(NAME runtime_components_tool_use_parser_common_test COMMAND runtime_components_tool_use_parser_common_test)

add_library(runtime_components_tool_use_parser_utils STATIC
  parser_utils.cc
)
target_include_directories(runtime_components_tool_use_parser_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${CMAKE_BINARY_DIR}/antlr_generated
)
target_link_libraries(runtime_components_tool_use_parser_utils
  PUBLIC
    antlr_json_tool_call_parser
    antlr_python_tool_call_parser
    runtime_components_tool_use_json_parser_utils
    runtime_components_tool_use_python_parser_utils
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
  )

# add_executable(runtime_components_tool_use_parser_utils_test
#   parser_utils_test.cc
# )
# target_link_libraries(runtime_components_tool_use_parser_utils_test PRIVATE
#   runtime_components_tool_use_parser_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_util_test_utils)
# add_test(NAME runtime_components_tool_use_parser_utils_test COMMAND runtime_components_tool_use_parser_utils_test)

add_library(runtime_components_tool_use_python_parser_utils STATIC
  python_parser_utils.cc
)
target_include_directories(runtime_components_tool_use_python_parser_utils 
  PRIVATE 
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${CMAKE_BINARY_DIR}/antlr_generated
)
target_link_libraries(runtime_components_tool_use_python_parser_utils
  PUBLIC
    runtime_components_tool_use_parser_common
    antlr_python_tool_call_parser
  PRIVATE
    LITERTLM_DEPS
    litert_libs

)

# add_executable(runtime_components_tool_use_python_parser_utils_test
#   python_parser_utils_test.cc
# )
# target_link_libraries(runtime_components_tool_use_python_parser_utils_test PRIVATE runtime_components_tool_use_python_parser_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_util_test_utils)
# add_test(NAME runtime_components_tool_use_python_parser_utils_test COMMAND runtime_components_tool_use_python_parser_utils_test)

add_library(runtime_components_tool_use_python_tool_format_utils STATIC
  python_tool_format_utils.cc
)
target_include_directories(runtime_components_tool_use_python_tool_format_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${PKG_ROOT}/antlr/antlr_generated
)

target_link_libraries(runtime_components_tool_use_python_tool_format_utils
  PUBLIC
    runtime_util_litert_status_util
    antlr_json_tool_call_parser
  PRIVATE
    LITERTLM_DEPS
    litert_libs

)

# add_executable(runtime_components_tool_use_python_tool_format_utils_test
#   python_tool_format_utils_test.cc
# )
# target_link_libraries(runtime_components_tool_use_python_tool_format_utils_test PRIVATE
#   runtime_components_tool_use_python_tool_format_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_util_test_utils)
# add_test(NAME runtime_components_tool_use_python_tool_format_utils_test COMMAND runtime_components_tool_use_python_tool_format_utils_test)


add_library(runtime_components_tool_use_libs INTERFACE)
target_link_libraries(runtime_components_tool_use_libs INTERFACE
  runtime_components_tool_use_json_parser_utils
  runtime_components_tool_use_parser_common
  runtime_components_tool_use_parser_utils
  runtime_components_tool_use_python_parser_utils
  runtime_components_tool_use_python_tool_format_utils
)