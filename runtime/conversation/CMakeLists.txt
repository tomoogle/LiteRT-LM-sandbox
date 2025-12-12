set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_litert_library(runtime_conversation_conversation STATIC
  conversation.cc
)
target_include_directories(runtime_conversation_conversation
  PUBLIC
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_conversation_conversation
  PUBLIC
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_conversation_io_types
    runtime_conversation_internal_callback_util
    runtime_components_prompt_template
    runtime_components_constrained_decoding_constraint
    runtime_conversation_model_data_processor
    runtime_conversation_model_data_processor_config_registry
    runtime_conversation_model_data_processor_factory
    runtime_engine_engine_interface
    runtime_util_litert_status_util
  PRIVATE
    proto_lib
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_conversation_conversation_test
#   conversation_test.cc
# )
# target_link_libraries(runtime_conversation_conversation_test PRIVATE
#   runtime_conversation_conversation
#   runtime_conversation_io_types
#   runtime_components_prompt_template
#   runtime_components_tokenizer
#   runtime_core_session_factory
#   runtime_engine_engine_interface
#   runtime_engine_engine_settings
#   runtime_engine_litert_lm_lib
#   runtime_executor_executor_settings_base
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_conversation_conversation_test COMMAND conversation_test)

add_litert_library(runtime_conversation_internal_callback_util STATIC
  internal_callback_util.cc
)
target_include_directories(runtime_conversation_internal_callback_util
  PUBLIC
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_conversation_internal_callback_util
  PUBLIC
    runtime_conversation_io_types
    runtime_engine_io_types 
    runtime_conversation_model_data_processor
    runtime_conversation_model_data_processor_config_registry
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_conversation_internal_callback_util_test
#   internal_callback_util_test.cc
# )
# target_link_libraries(runtime_conversation_internal_callback_util_test PRIVATE
#   runtime_conversation_internal_callback_util
#   runtime_conversation_io_types
#   runtime_conversation_model_data_processor_config_registry
#   runtime_conversation_model_data_processor_gemma3_data_processor
#   runtime_conversation_model_data_processor_gemma3_data_processor_config
#   runtime_util_test_utils
#   runtime_engine_io_types
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_conversation_internal_callback_util_test COMMAND internal_callback_util_test)

add_litert_library(runtime_conversation_io_types STATIC
  io_types.cc
)
target_include_directories(runtime_conversation_io_types
  PUBLIC
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_conversation_io_types
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

add_library(runtime_conversation_libs INTERFACE)
target_link_libraries(runtime_conversation_libs INTERFACE
  runtime_conversation_conversation
  runtime_conversation_internal_callback_util
  runtime_conversation_io_types
  runtime_conversation_model_data_processor_libs
)