set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_litert_executable(schema_cc_litertlm_export_main
  litertlm_export_main.cc
)
target_link_directories(schema_cc_litertlm_export_main 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}
)
target_link_libraries(schema_cc_litertlm_export_main
  PUBLIC
    schema_core_litertlm_export
    schema_core_litertlm_header
    schema_core_litertlm_header_schema
    schema_core_litertlm_section
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
  # flatbuffers
)

add_litert_executable(schema_cc_litertlm_peek
  litertlm_peek.cc
)
target_link_directories(schema_cc_litertlm_peek 
  PRIVATE
    ${THIRD_PARTY_DIR}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(schema_cc_litertlm_peek
  PUBLIC
    schema_core_litertlm_header
    schema_core_litertlm_header_schema
    schema_core_litertlm_print
    schema_core_litertlm_read
    schema_core_litertlm_section
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

add_litert_executable(schema_cc_litertlm_writer
  litertlm_writer.cc
)
target_link_directories(schema_cc_litertlm_writer 
  PRIVATE
    ${THIRD_PARTY_DIR}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(schema_cc_litertlm_writer
  PUBLIC
    schema_cc_litertlm_writer_utils 
    schema_core_litertlm_export
    schema_core_litertlm_header
    schema_core_litertlm_header_schema
    schema_core_litertlm_section
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
  
  
  
  )

# add_litert_executable(schema_cc_litertlm_writer_test
#   litertlm_writer_test.cc
# )
# target_link_libraries(schema_cc_litertlm_writer_test PRIVATE
#   ${LITERTLM_DEPS}
#   schema_cc_litertlm_writer_utils
#   schema_core_litertlm_print
#   runtime_proto_llm_metadata_cc_proto
#   runtime_proto_token_cc_proto
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_tflite_framework
#   # litert_tflite_framework_stable
#   # litert_tflite_c_common
#   # litert_tflite_kernels_builtin_ops
#   # litert_tflite_schema_schema_fbs
# )
# add_test(NAME schema_cc_litertlm_writer_test COMMAND litertlm_writer_test)

add_litert_library(schema_cc_litertlm_writer_utils STATIC
  litertlm_writer_utils.cc
)
target_include_directories(schema_cc_litertlm_writer_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(schema_cc_litertlm_writer_utils
  PUBLIC
    schema_core_litertlm_export 
    schema_core_litertlm_header 
    schema_core_litertlm_header_schema
    schema_core_litertlm_print
    schema_core_litertlm_section
    schema_core_litertlm_utils
  PRIVATE
    LITERTLM_DEPS
    proto_lib
    litert_libs
    # flatbuffers
  
)

add_library(schema_cc_libs INTERFACE)
target_link_libraries(schema_cc_libs INTERFACE
 schema_cc_litertlm_writer_utils
)