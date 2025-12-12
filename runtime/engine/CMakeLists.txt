set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_litert_library(runtime_engine_engine_interface INTERFACE)
target_include_directories(runtime_engine_engine_interface
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

add_litert_library(runtime_engine_engine_settings STATIC
  engine_settings.cc
)
target_include_directories(runtime_engine_engine_settings 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
  )
target_link_libraries(runtime_engine_engine_settings
  PUBLIC
    runtime_executor_audio_executor_settings
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_settings
    runtime_util_litert_status_util
    runtime_util_model_type_utils
    runtime_components_tokenizer
  PRIVATE
    litert_libs
    LITERTLM_DEPS
    proto_lib
)

# add_litert_executable(runtime_engine_engine_settings_test
#   engine_settings_test.cc
# )
# target_link_libraries(runtime_engine_engine_settings_test PRIVATE
#   runtime_engine_engine_settings
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_components_tokenizer
#   runtime_executor_executor_settings_base
#   runtime_proto_engine_cc_proto
#   runtime_proto_llm_metadata_cc_proto
#   runtime_proto_llm_model_type_cc_proto
#   runtime_proto_token_cc_proto
#   runtime_util_test_utils
# )
# add_test(NAME runtime_engine_engine_settings_test COMMAND runtime_engine_engine_settings_test)

add_litert_library(runtime_engine_io_types STATIC
  io_types.cc
)
target_include_directories(runtime_engine_io_types
  PRIVATE 
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}
)
target_link_libraries(runtime_engine_io_types
  PUBLIC
    runtime_components_constrained_decoding_constraint
    runtime_util_litert_status_util
  PUBLIC
    proto_lib
    litert_libs
    LITERTLM_DEPS
  # litert_litert_cc_litert_api_with_dynamic_runtime
  # litert_litert_cc_litert_macros
  # litert_litert_cc_litert_tensor_buffer
)

# add_litert_executable(runtime_engine_io_types_test
#   io_types_test.cc
# )
# target_link_libraries(runtime_engine_io_types_test PRIVATE
#   runtime_engine_io_types
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_cc_litert_environment
#   # litert_litert_cc_litert_layout
#   # litert_litert_cc_litert_model
#   # litert_litert_cc_litert_tensor_buffer
#   # litert_litert_cc_litert_tensor_buffer_types
#   # litert_litert_test_matchers
#   runtime_components_constrained_decoding_fake_constraint
#   runtime_util_convert_tensor_buffer
#   runtime_util_test_utils
# )
# add_test(NAME runtime_engine_io_types_test COMMAND runtime_engine_io_types_test)


add_litert_executable(runtime_engine_litert_lm_advanced_main
  litert_lm_advanced_main.cc
)
target_link_libraries(runtime_engine_litert_lm_advanced_main
  PUBLIC
    c_engine
    runtime_engine_libs
    runtime_components_libs
    runtime_conversation_libs
    runtime_executor_libs
    runtime_util_libs
    runtime_core_libs
    runtime_core_tasks
    runtime_engine_litert_lm_lib
    runtime_engine_shared_flags
    runtime_util_litert_status_util
  PRIVATE
    litert_libs
    # absl::status
    # absl::statusor
    # absl::strings
    # absl::log
        
    # # Link the specific LiteRT libraries that define the status/logging wrappers
    # # litert_logging
    LITERTLM_DEPS
)


add_litert_library(runtime_engine_litert_lm_lib STATIC
  litert_lm_lib.cc
)
target_include_directories(runtime_engine_litert_lm_lib
  PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_engine_litert_lm_lib
  PUBLIC
    runtime_engine_libs
    runtime_components_libs
    runtime_conversation_libs
    runtime_executor_libs
    runtime_util_libs
    runtime_core_libs
    # runtime_engine_libs
    # runtime_engine_engine_interface
    # runtime_engine_engine_settings
    # runtime_engine_io_types
    # runtime_conversation_conversation
    # runtime_conversation_io_types
    # runtime_executor_executor_settings_base
    # runtime_executor_llm_executor_settings
    # runtime_util_litert_status_util
    
    # stb_stb_image
    # litert_tflite_profiling_memory_info
    # litert_tflite_profiling_memory_usage_monitor
    # runtime_core_engine_impl
  PRIVATE
    litert_libs
    # absl::status
    # absl::statusor
    # absl::strings
    # absl::log
    # # litert_logging
    LITERTLM_DEPS

)


add_litert_executable(runtime_engine_litert_lm_main
  litert_lm_main.cc
)
target_link_libraries(runtime_engine_litert_lm_main
  PUBLIC
    runtime_engine_libs
    runtime_components_libs
    runtime_conversation_libs
    runtime_executor_libs
    runtime_util_libs
    runtime_core_libs
    runtime_core_tasks
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_conversation_conversation
    runtime_conversation_io_types
    runtime_core_engine_impl
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_settings
    runtime_util_litert_status_util
    c_engine
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)


add_litert_library(runtime_engine_shared_flags STATIC
  shared_flags.cc
)
target_include_directories(runtime_engine_shared_flags
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_engine_shared_flags
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)



add_library(runtime_engine_libs INTERFACE)
target_link_libraries(runtime_engine_libs INTERFACE
  runtime_engine_engine_interface
  runtime_engine_engine_settings
  runtime_engine_io_types
  runtime_engine_litert_lm_lib
  runtime_engine_shared_flags
)