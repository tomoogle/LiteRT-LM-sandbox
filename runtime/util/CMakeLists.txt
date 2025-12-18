set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_litert_library(runtime_util_convert_tensor_buffer INTERFACE)
target_include_directories(runtime_util_convert_tensor_buffer 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_convert_tensor_buffer INTERFACE
  litert_libs
)

# add_litert_executable(runtime_util_convert_tensor_buffer_test
#   convert_tensor_buffer_test.cc
# )
# target_include_directories(runtime_util_convert_tensor_buffer_test INTERFACE ${PROJECT_ROOT}
#     ${LITERT_INCLUDE_DIR})
# target_link_libraries(runtime_util_convert_tensor_buffer_test PRIVATE 
#   runtime_util_convert_tensor_buffer
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_c_litert_common
#   # litert_litert_cc_litert_layout
#   # litert_litert_cc_litert_tensor_buffer
#   # litert_litert_cc_litert_tensor_buffer_types
#   # litert_litert_test_matchers
# )
# add_test(NAME runtime_util_convert_tensor_buffer_test COMMAND convert_tensor_buffer_test)

add_litert_library(runtime_util_executor_data_util STATIC
  executor_data_util.cc
)
target_include_directories(runtime_util_executor_data_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_executor_data_util
  PUBLIC
  runtime_util_convert_tensor_buffer  
  runtime_executor_llm_executor_io_types
  runtime_util_tensor_buffer_util 
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
  # litert_status_util 
  # litert_litert_c_litert_tensor_buffer_types 
  # litert_litert_cc_litert_layout 
  # litert_litert_cc_litert_macros 
  # litert_litert_cc_litert_ranked_tensor_type 
  # litert_litert_cc_litert_api_with_dynamic_runtime 
  # litert_litert_cc_litert_tensor_buffer
)

# add_litert_executable(runtime_util_executor_data_util_test
#   executor_data_util_test.cc
# )
# target_link_libraries(runtime_util_executor_data_util_test PRIVATE
#   runtime_util_convert_tensor_buffer 
#   runtime_util_executor_data_util 
#   runtime_executor_llm_executor_io_types
#   runtime_util_tensor_buffer_util 
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_c_litert_tensor_buffer_types
#   # litert_litert_cc_litert_element_type
#   # litert_litert_cc_litert_layout
#   # litert_litert_cc_litert_ranked_tensor_type
#   # litert_litert_cc_litert_tensor_buffer
#   # litert_litert_test_matchers
# )
# add_test(NAME runtime_util_executor_data_util_test COMMAND executor_data_util_test)

# Unsupported rule cc_proto_library for //runtime/util:external_file_cc_proto

# Unsupported rule proto_library for //runtime/util:external_file_proto

add_litert_library(runtime_util_file_format_util STATIC
  file_format_util.cc
)
target_include_directories(runtime_util_file_format_util 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_file_format_util
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_util_litert_status_util
    runtime_util_memory_mapped_file
    runtime_util_scoped_file
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# add_litert_executable(runtime_util_file_format_util_test
#   file_format_util_test.cc
# )
# target_link_libraries(runtime_util_file_format_util_test PRIVATE
#   runtime_util_file_format_util
#   runtime_executor__llm_executor_settings
#   runtime_util_memory_mapped_file
#   runtime_util_scoped_file
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_util_file_format_util_test COMMAND file_format_util_test)

add_litert_library(runtime_util_file_util STATIC
  file_util.cc
)
target_include_directories(runtime_util_file_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_file_util 
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# add_litert_executable(runtime_util_file_util_test
#   file_util_test.cc
# )
# target_link_libraries(runtime_util_file_util_test PRIVATE 
#   runtime_util_file_util
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_util_file_util_test COMMAND file_util_test)

add_litert_library(runtime_util_litert_lm_loader STATIC
  litert_lm_loader.cc
)
target_include_directories(runtime_util_litert_lm_loader
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_litert_lm_loader 
  PUBLIC
    runtime_util_litert_status_util
    runtime_util_memory_mapped_file
    # runtime_util_model_resources 
    runtime_util_scoped_file
    # runtime_util_litertlm_header_schema 
  PRIVATE
    LITERTLM_DEPS
    litert_libs
  # litert_litert_cc_litert_buffer_ref
)



add_litert_library(runtime_util_litert_status_util INTERFACE)
target_include_directories(runtime_util_litert_status_util 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_litert_status_util INTERFACE
  litert_libs
)


add_litert_library(runtime_util_logging INTERFACE)
target_include_directories(runtime_util_logging
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_logging INTERFACE
  litert_libs
)


add_litert_library(runtime_util_logging_tensor_buffer STATIC
  logging_tensor_buffer.cc
)
target_include_directories(runtime_util_logging_tensor_buffer 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_logging_tensor_buffer 
  PRIVATE
    litert_libs
    LITERTLM_DEPS
  #litert_litert_cc_litert_element_type
  #litert_litert_cc_litert_tensor_buffer_types
  #litert_litert_cc_litert_api_with_dynamic_runtime
  #litert_litert_cc_litert_tensor_buffer
)

# add_litert_executable(runtime_util_logging_test
#   logging_test.cc
# )
# target_link_libraries(runtime_util_logging_test PRIVATE
#   runtime_util_logging
#   runtime_util_logging_tensor_buffer
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   #litert_litert_cc_litert_element_type
#   #litert_litert_cc_litert_model
#   #litert_litert_cc_litert_tensor_buffer
# )
# add_test(NAME runtime_util_logging_test COMMAND logging_test)

add_litert_library(runtime_util_lora_data STATIC
  lora_data.cc
)
target_include_directories(runtime_util_lora_data
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
  )
target_link_libraries(runtime_util_lora_data
  PUBLIC
    runtime_util_litert_status_util
    runtime_util_lora_util
    runtime_util_scoped_file
  PRIVATE
    litert_libs
    LITERTLM_DEPS
    #litert_litert_cc_litert_buffer_ref
    #litert_tflite_framework
    #litert_tflite_schema_schema_fbs
)

# add_litert_executable(runtime_util_lora_data_test
#   lora_data_test.cc
# )
# target_link_libraries(runtime_util_lora_data_test PRIVATE
#   runtime_util_executor_settings_base
#   runtime_util_litert_status_util
#   runtime_util_lora_data
#   runtime_util_memory_mapped_file
#   runtime_util_scoped_file
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_cc_litert_buffer_ref
# )
# add_test(NAME runtime_util_lora_data_test COMMAND lora_data_test)

add_litert_library(runtime_util_lora_util
  STATIC
    lora_util.cc
)
target_include_directories(runtime_util_lora_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}/re2
)
target_link_libraries(runtime_util_lora_util
  PUBLIC
    runtime_util_litert_status_util
    runtime_util_memory_mapped_file
    runtime_util_scoped_file
  PRIVATE
    litert_libs
    LITERTLM_DEPS
  #litert_litert_cc_litert_buffer_ref
)

# add_litert_executable(runtime_util_lora_util_test
#   lora_util_test.cc
# )
# target_link_libraries(runtime_util_lora_util_test PRIVATE
#   runtime_util_lora_util
#   runtime_util_memory_mapped_file
#   runtime_util_scoped_file
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_util_lora_util_test COMMAND lora_util_test)

if(WIN32)
  set(runtime_util_memory_mapped_file_src memory_mapped_file_win.cc)
elseif(UNIX)
  set(runtime_util_memory_mapped_file_src memory_mapped_file_posix.cc)
endif()

add_litert_library(runtime_util_memory_mapped_file STATIC
  ${runtime_util_memory_mapped_file_src}
)
target_include_directories(runtime_util_memory_mapped_file
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_memory_mapped_file 
  PUBLIC
    runtime_util_litert_status_util
    runtime_util_scoped_file
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# add_litert_executable(runtime_util_memory_mapped_file_test
#   memory_mapped_file_test.cc
# )
# target_link_libraries(runtime_util_memory_mapped_file_test PRIVATE 
#   runtime_util_memory_mapped_file
#   runtime_util_scoped_file
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_util_memory_mapped_file_test COMMAND memory_mapped_file_test)

add_litert_library(runtime_util_metadata_util STATIC
  metadata_util.cc
)
target_include_directories(runtime_util_metadata_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_metadata_util
  PRIVATE
    proto_lib
    litert_libs
    LITERTLM_DEPS
)

# add_litert_executable(runtime_util_metadata_util_test
#   metadata_util_test.cc
# )
# target_link_libraries(runtime_util_metadata_util_test PRIVATE
#   runtime_util_metadata_util
#   runtime_proto_llm_metadata_cc_proto
#   runtime_proto_token_cc_proto
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_util_metadata_util_test COMMAND metadata_util_test)

add_litert_library(runtime_util_model_asset_bundle_resources
  STATIC
    model_asset_bundle_resources.cc
)
target_include_directories(runtime_util_model_asset_bundle_resources 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_model_asset_bundle_resources
  PUBLIC
    runtime_util_litert_status_util
    runtime_util_memory_mapped_file
    runtime_util_scoped_file
    runtime_util_zip_utils
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

add_litert_library(runtime_util_model_type_utils STATIC
  model_type_utils.cc
)
target_include_directories(runtime_util_model_type_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_model_type_utils 
  PUBLIC
    runtime_util_litert_status_util
  PRIVATE
    proto_lib
    # tokenizer
    # token_cc_proto
    litert_libs
    LITERTLM_DEPS
)

# add_litert_executable(runtime_util_model_type_utils_test
#   model_type_utils_test.cc
# )
# target_link_libraries(runtime_util_model_type_utils_test PRIVATE
#   runtime_util_model_type_utils
  
#   runtime_proto_llm_metadata_cc_proto
#   runtime_proto_llm_model_type_cc_proto
#   untime_components_prompt_template 
#   untime_components_tokenizer
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_util_model_type_utils_test COMMAND model_type_utils_test)



set(runtime_util_scoped_file_src
  scoped_file.cc
)
if(WIN32)
  list(APPEND runtime_util_scoped_file_src scoped_file_win.cc)
elseif(UNIX)
  list(APPEND runtime_util_scoped_file_src scoped_file_posix.cc)
endif()


add_litert_library(runtime_util_scoped_file STATIC
  ${runtime_util_scoped_file_src}
)
target_include_directories(runtime_util_scoped_file
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_scoped_file
  PUBLIC
    runtime_util_litert_status_util 
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# add_litert_executable(runtime_util_scoped_file_test
#   scoped_file_test.cc
# )
# target_link_libraries(runtime_util_scoped_file_test PRIVATE
#   runtime_util_scoped_file
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_util_scoped_file_test COMMAND scoped_file_test)

# add_litert_executable(runtime_util_status_macros_test
#   status_macros_test.cc
# )
# target_link_libraries(runtime_util_status_macros_test PRIVATE
#   runtime_util_litert_status_util
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_util_status_macros_test COMMAND status_macros_test)

add_litert_library(runtime_util_tensor_buffer_util STATIC
  tensor_buffer_util.cc
)
target_include_directories(runtime_util_tensor_buffer_util
  PRIVATE
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_tensor_buffer_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    #litert_litert_cc_litert_macros
    #litert_litert_cc_litert_api_with_dynamic_runtime
    #litert_litert_cc_litert_tensor_buffer
)

# add_litert_executable(runtime_util_tensor_buffer_util_test
#   tensor_buffer_util_test.cc
# )
# target_include_directories(runtime_util_tensor_buffer_util_test INTERFACE ${PROJECT_ROOT}
#     ${LITERTLM_INCLUDE_PATHS})
# target_link_libraries(runtime_util_tensor_buffer_util_test PRIVATE
#   runtime_util_convert_tensor_buffer
#   runtime_util_tensor_buffer_util
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   #litert_litert_test_matchers
# )
# add_test(NAME runtime_util_tensor_buffer_util_test COMMAND tensor_buffer_util_test)

add_litert_library(runtime_util_test_utils INTERFACE)
target_include_directories(runtime_util_test_utils 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_util_logging INTERFACE
  litert_libs
)

add_litert_library(runtime_util_zip_readonly_mem_file STATIC
  zip_readonly_mem_file.cc
)
target_include_directories(runtime_util_zip_readonly_mem_file
  PRIVATE
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}/minizip
)
target_link_libraries(runtime_util_zip_readonly_mem_file 
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

add_litert_library(runtime_util_zip_utils STATIC
  zip_utils.cc
)
target_include_directories(runtime_util_zip_utils
  PRIVATE
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}
)
target_link_libraries(runtime_util_zip_utils
  PUBLIC
    runtime_util_litert_status_util
    runtime_util_zip_readonly_mem_file
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib

)

# add_litert_executable(runtime_util_zip_utils_test
#   zip_utils_test.cc
# )
# target_link_libraries(runtime_util_zip_utils_test PRIVATE
#   runtime_util_memory_mapped_file
#   runtime_util_test_utils
#   runtime_util_zip_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME zip_utils_test COMMAND zip_utils_test)

add_library(runtime_util_libs INTERFACE)
target_link_libraries(runtime_util_libs INTERFACE
  runtime_util_executor_data_util
  runtime_util_file_format_util
  runtime_util_file_util
  runtime_util_litert_lm_loader
  runtime_util_logging_tensor_buffer
  runtime_util_lora_data
  runtime_util_lora_util
  runtime_util_memory_mapped_file
  runtime_util_metadata_util
  runtime_util_model_asset_bundle_resources
  runtime_util_model_type_utils
  runtime_util_scoped_file
  runtime_util_tensor_buffer_util
  runtime_util_zip_readonly_mem_file
  runtime_util_zip_utils
)