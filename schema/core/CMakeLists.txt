set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})


add_litert_library(schema_core_litertlm_export STATIC
  litertlm_export.cc
)
# add_dependencies(schema_core_litertlm_export generated_flatbuffer_headers)
target_include_directories(schema_core_litertlm_export
  PRIVATE 
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)


target_link_libraries(schema_core_litertlm_export 
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    # flatbuffers
)

# litertlm_header litertlm_header_schema litertlm_section litertlm_utils com_google_absl_absl_log_absl_log com_google_absl_absl_status_status com_google_absl_absl_status_statusor com_google_absl_absl_strings_strings com_google_absl_absl_strings_str_format flatbuffers_flatbuffers runtime_util_litert_status_util)


add_litert_library(schema_core_litertlm_header INTERFACE)
# add_dependencies(schema_core_litertlm_header generated_flatbuffer_headers)
target_include_directories(schema_core_litertlm_header
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)


add_litert_library(schema_core_litertlm_header_schema INTERFACE)
# add_dependencies(schema_core_litertlm_header_schema generated_flatbuffer_headers)
target_include_directories(schema_core_litertlm_header_schema 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# add_litert_executable(schema_core_litertlm_header_test
#   litertlm_header_test.cc
# )
# target_link_libraries(schema_core_litertlm_header_test PRIVATE 
#   ${LITERTLM_DEPS}
#   schema_core_litertlm_header
#   schema_core_litertlm_header_schema
#   # gtest
#   # flatbuffers
# )
# add_test(NAME schema_core_litertlm_header_test COMMAND litertlm_header_test)


add_litert_library(schema_core_litertlm_print STATIC
  litertlm_print.cc
)
target_include_directories(schema_core_litertlm_print
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_core_litertlm_print
  PUBLIC
    schema_core_litertlm_header_schema 
    schema_core_litertlm_read 
    schema_core_litertlm_utils 
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)


# add_litert_executable(schema_core_litertlm_print_test
#   litertlm_print_test.cc
# )
# target_link_libraries(schema_core_litertlm_print_test PRIVATE 
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   schema_core_litertlm_print
#   runtime_proto_llm_metadata_cc_proto
#   # gtest 
#   # flatbuffers
# )
# add_test(NAME schema_core_litertlm_print_test COMMAND litertlm_print_test)


add_litert_library(schema_core_litertlm_read STATIC
  litertlm_read.cc
)
# add_dependencies(schema_core_litertlm_read generated_flatbuffer_headers)
target_include_directories(schema_core_litertlm_read
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(schema_core_litertlm_read
  PUBLIC
    runtime_util_litert_status_util
    runtime_util_memory_mapped_file
    runtime_util_scoped_file
    schema_core_litertlm_header
    schema_core_litertlm_header_schema
    schema_core_litertlm_utils
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
    proto_lib

)


# add_litert_executable(schema_core_litertlm_read_test
#   litertlm_read_test.cc
# )
# target_link_libraries(schema_core_litertlm_read_test PRIVATE
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   schema_core_litertlm_header_schema
#   schema_core_litertlm_read
#   runtime_proto_llm_metadata_cc_proto
#   runtime_util_memory_mapped_file
#   runtime_util_test_utils
#   # litert
#   # ${absl_libs}
#   # gtest
#   # sentencepiece
#   # litert_tflite_framework
#   # litert_tflite_framework_stable
#   # litert_tflite_c_common
#   # litert_tflite_kernels_builtin_ops
# )
# add_test(NAME schema_core_litertlm_read_test COMMAND litertlm_read_test)


add_litert_library(schema_core_litertlm_section INTERFACE)
# add_dependencies(schema_core_litertlm_section generated_flatbuffer_headers)
target_include_directories(schema_core_litertlm_section 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS})


# add_litert_executable(schema_core_litertlm_section_test
#   litertlm_section_test.cc
# )
# target_link_libraries(schema_core_litertlm_section_test PRIVATE
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   schema_core_litertlm_section
#   runtime_proto_llm_metadata_cc_proto
#   runtime_proto_token_cc_proto
#   # gtest
# )
# add_test(NAME schema_core_litertlm_section_test COMMAND litertlm_section_test)


add_litert_library(schema_core_litertlm_utils STATIC
  litertlm_utils.cc
)
# add_dependencies(schema_core_litertlm_utils generated_flatbuffer_headers)
target_include_directories(schema_core_litertlm_utils 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_core_litertlm_utils 
  PUBLIC
    schema_core_litertlm_header
    schema_core_litertlm_header_schema
  PRIVATE
    LITERTLM_DEPS
    litert_libs
  #  flatbuffers
)


add_library(schema_core_libs INTERFACE)
target_link_libraries(schema_core_libs INTERFACE
  schema_core_litertlm_export
  schema_core_litertlm_header
  schema_core_litertlm_header_schema
  schema_core_litertlm_print
  schema_core_litertlm_read
  schema_core_litertlm_section
  schema_core_litertlm_utils
)