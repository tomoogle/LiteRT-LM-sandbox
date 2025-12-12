set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_litert_interface_library(runtime_executor_audio_executor)
target_include_directories(runtime_executor_audio_executor INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)


add_litert_interface_library(runtime_executor_audio_executor_base)
target_include_directories(runtime_executor_audio_executor_base INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)


add_litert_static_library(runtime_executor_audio_executor_settings
  audio_executor_settings.cc
)
target_include_directories(runtime_executor_audio_executor_settings
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_executor_audio_executor_settings
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_executor_audio_executor_settings_test
#   audio_executor_settings_test.cc
# )
# target_link_libraries(runtime_executor_audio_executor_settings_test PRIVATE
#   runtime_executor_audio_executor_settings
#   runtime_executor_executor_settings_base
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_executor_audio_executor_settings_test COMMAND audio_executor_settings_test)

add_litert_library(runtime_executor_audio_litert_compiled_model_executor STATIC
  audio_litert_compiled_model_executor.cc
)
target_include_directories(runtime_executor_audio_litert_compiled_model_executor
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_executor_audio_litert_compiled_model_executor
  PUBLIC
    runtime_executor_audio_executor_settings
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_io_types
    runtime_components_model_resources
    runtime_executor_audio_executor
    runtime_util_litert_status_util
    runtime_executor_litert_compiled_model_executor_utils    
  PRIVATE
    LITERTLM_DEPS
    litert_libs

  # litert
  # litert_litert_cc_litert_tensor_buffer_types
  # litert_litert_cc_litert_api_with_dynamic_runtime
  # litert_litert_c_litert_tensor_buffer_types
  # litert_litert_cc_litert_common
  # litert_litert_cc_litert_compiled_model
  # litert_litert_cc_litert_element_type
  # litert_litert_cc_litert_environment
  # litert_litert_cc_litert_layout
  # litert_litert_cc_litert_macros
  # litert_litert_cc_litert_model
  # litert_litert_cc_litert_options
  # litert_litert_cc_litert_ranked_tensor_type
  # litert_litert_cc_litert_tensor_buffer
  # litert_litert_cc_options_litert_cpu_options
  # litert_litert_cc_options_litert_gpu_options
  # litert_litert_cc_options_litert_runtime_options
)

# add_litert_executable(runtime_executor_audio_litert_compiled_model_executor_test
#   audio_litert_compiled_model_executor_test.cc
# )
# target_link_libraries(runtime_executor_audio_litert_compiled_model_executor_test PRIVATE 
#   runtime_executor_audio_executor_settings
#   runtime_executor_audio_litert_compiled_model_executor
#   runtime_executor_executor_settings_base
#   runtime_util_litert_status_util
#   runtime_util_scoped_file
#   runtime_util_test_utils

#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_cc_litert_element_type
#   # litert_litert_cc_litert_layout
#   # litert_litert_cc_litert_macros
#   # litert_litert_cc_litert_model
#   # litert_litert_cc_litert_tensor_buffer
#   # litert_litert_cc_litert_tensor_buffer_types
#   # litert_litert_test_matchers
#   # litert_litert_cc_litert_api_with_dynamic_runtime
#   # litert_litert_cc_litert_environment
# )
# add_test(NAME runtime_executor_audio_litert_compiled_model_executor_test COMMAND audio_litert_compiled_model_executor_test)

# Skipping library default_static_gpu_accelerator: no sources or headers

add_litert_library(runtime_executor_executor_settings_base STATIC
  executor_settings_base.cc
)
target_include_directories(runtime_executor_executor_settings_base
    PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_executor_executor_settings_base
  PUBLIC
    runtime_util_scoped_file
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_executor_executor_settings_base_test
#   executor_settings_base_test.cc
# )
# target_link_libraries(runtime_executor_executor_settings_base_test PRIVATE
#   runtime_executor_executor_settings_base
#   runtime_util_test_utils
#   gtest_lib
# )
# add_test(NAME runtime_executor_executor_settings_base_test COMMAND executor_settings_base_test)

add_litert_library(runtime_executor_fake_llm_executor STATIC
  fake_llm_executor.cc
)
target_include_directories(runtime_executor_fake_llm_executor
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
  )
target_link_libraries(runtime_executor_fake_llm_executor
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_io_types
    runtime_executor_llm_executor_settings
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
    runtime_executor_llm_executor
  PRIVATE
    LITERTLM_DEPS
    litert_libs
  # litert
  # litert_litert_cc_litert_api_with_dynamic_runtime
  # litert_litert_cc_litert_macros
  # litert_litert_cc_litert_tensor_buffer)
)
# add_litert_executable(runtime_executor_fake_llm_executor_test
#   fake_llm_executor_test.cc
# )
# target_link_libraries(runtime_executor_fake_llm_executor_test PRIVATE
#   runtime_executor_fake_llm_executor
#   runtime_executor_llm_executor_io_types
#   runtime_util_convert_tensor_buffer
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   absl_lib
#   # litert_litert_test_matchers
# )
# add_test(NAME runtime_executor_fake_llm_executor_test COMMAND fake_llm_executor_test)

add_litert_library(runtime_executor_litert_compiled_model_executor_utils STATIC
  litert_compiled_model_executor_utils.cc
)
target_include_directories(runtime_executor_litert_compiled_model_executor_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_executor_litert_compiled_model_executor_utils
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_components_model_resources
    runtime_components_model_resources_litert_lm
    runtime_components_model_resources_task
    runtime_components_sentencepiece_tokenizer
    
    runtime_util_file_format_util
    runtime_util_litert_lm_loader
    runtime_util_litert_status_util
    runtime_util_memory_mapped_file
    runtime_util_model_asset_bundle_resources
    runtime_util_scoped_file
  PRIVATE
    proto_lib
    LITERTLM_DEPS
    litert_libs
  # litert
  #litert_litert_cc_litert_api_with_dynamic_runtime
  #litert_litert_cc_litert_element_type
  #litert_litert_cc_litert_expected
  #litert_litert_cc_litert_macros
  #litert_litert_cc_litert_model
  #litert_litert_cc_litert_tensor_buffer
  )

# add_litert_executable(runtime_executor_litert_compiled_model_executor_utils_test
#   litert_compiled_model_executor_utils_test.cc
# )
# target_link_libraries(runtime_executor_litert_compiled_model_executor_utils_test PRIVATE
#   runtime_executor_executor_settings_base
#   runtime_executor_litert_compiled_model_executor_utils
#   runtime_components_model_resources
#   runtime_util_scoped_file
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   absl_lib
#   # litert_litert_c_litert_tensor_buffer_types
#   # litert_litert_cc_litert_element_type
#   # litert_litert_cc_litert_environment
#   # litert_litert_cc_litert_layout
#   # litert_litert_cc_litert_ranked_tensor_type
#   # litert_litert_cc_litert_tensor_buffer
#   # litert_litert_cc_litert_tensor_buffer_types
#   # litert_litert_test_matchers
# )
# add_test(NAME runtime_executor_litert_compiled_model_executor_utils_test COMMAND litert_compiled_model_executor_utils_test)

add_litert_library(runtime_executor_llm_executor INTERFACE)
target_include_directories(runtime_executor_llm_executor INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)


add_litert_library(runtime_executor_llm_executor_base INTERFACE)
target_include_directories(runtime_executor_llm_executor_base INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)


add_litert_library(runtime_executor_llm_executor_io_types STATIC
  llm_executor_io_types.cc
)
target_include_directories(runtime_executor_llm_executor_io_types
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_executor_llm_executor_io_types
  PUBLIC
    runtime_components_constrained_decoding_constrained_decoder
    runtime_util_logging_tensor_buffer
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)
# add_litert_executable(runtime_executor_llm_executor_io_types_test
#   llm_executor_io_types_test.cc
# )
# target_link_libraries(runtime_executor_llm_executor_io_types_test PRIVATE
#   runtime_executor_llm_executor_io_types
#   runtime_components_constrained_decoding_constrained_decoder
#   runtime_components_constrained_decoding_fake_constraint
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_cc_litert_element_type
#   # litert_litert_cc_litert_environment
#   # litert_litert_cc_litert_layout
#   # litert_litert_cc_litert_model
#   # litert_litert_cc_litert_tensor_buffer
# )
# add_test(NAME runtime_executor_llm_executor_io_types_test COMMAND llm_executor_io_types_test)


add_litert_library(runtime_executor_llm_executor_processed_tokens STATIC
  llm_executor_processed_tokens.cc
)
target_include_directories(runtime_executor_llm_executor_processed_tokens
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_executor_llm_executor_processed_tokens
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_executor_llm_executor_processed_tokens_test
#   llm_executor_processed_tokens_test.cc
# )
# target_link_libraries(runtime_executor_llm_executor_processed_tokens_test PRIVATE
#   runtime_executor_llm_executor_processed_tokens
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_executor_llm_executor_processed_tokens_test COMMAND llm_executor_processed_tokens_test)


add_litert_library(runtime_executor_llm_executor_settings STATIC
  llm_executor_settings.cc
)
target_include_directories(runtime_executor_llm_executor_settings
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_executor_llm_executor_settings
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_util_litert_status_util
    runtime_util_logging
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)


# add_litert_library(runtime_executor_llm_executor_settings_utils STATIC
#   llm_executor_settings_utils.cc
# )
# target_include_directories(runtime_executor_llm_executor_settings_utils
#   PUBLIC
#     ${GENERATED_SRC_DIR}
#     ${LITERT_INCLUDE_DIR}
#     ${LITERTLM_INCLUDE_PATHS}
# )
# target_link_libraries(runtime_executor_llm_executor_settings_utils
#   PUBLIC
#     runtime_executor_executor_settings_base
#     runtime_util_litert_status_util
#     runtime_util_logging
#   PRIVATE
#     LITERTLM_DEPS
#     litert_libs
#     proto_lib
# )


# add_litert_executable(runtime_executor_llm_executor_settings_test
#   llm_executor_settings_test.cc
# )
# target_link_libraries(runtime_executor_llm_executor_settings_test PRIVATE
#   runtime_executor_executor_settings_base
#   runtime_executor_llm_executor_settings
#   runtime_util_scoped_file
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_executor_llm_executor_settings_test COMMAND llm_executor_settings_test)


add_litert_library(runtime_executor_llm_litert_compiled_model_cache_utils STATIC
  llm_litert_compiled_model_cache_utils.cc
)
target_include_directories(runtime_executor_llm_litert_compiled_model_cache_utils
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
  )
target_link_libraries(runtime_executor_llm_litert_compiled_model_cache_utils
  PUBLIC
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_executor_llm_litert_compiled_model_cache_utils_test
#   llm_litert_compiled_model_cache_utils_test.cc
# )
# target_link_libraries(runtime_executor_llm_litert_compiled_model_cache_utils_test PRIVATE
#   runtime_executor_llm_litert_compiled_model_cache_utils
#   runtime_components_convert_tensor_buffer
#   runtime_components_litert_status_util
#   runtime_components_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_cc_litert_model
#   # litert_litert_cc_litert_tensor_buffer
#   # litert_litert_test_matchers
  
# )
# add_test(NAME runtime_executor_llm_litert_compiled_model_cache_utils_test COMMAND llm_litert_compiled_model_cache_utils_test)

add_litert_library(runtime_executor_llm_litert_compiled_model_executor_factory STATIC
  llm_litert_compiled_model_executor_factory.cc

)
target_include_directories(runtime_executor_llm_litert_compiled_model_executor_factory
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_executor_llm_litert_compiled_model_executor_factory
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_io_types
    runtime_executor_llm_executor_settings
    runtime_executor_llm_litert_compiled_model_executor
    runtime_executor_llm_litert_npu_compiled_model_executor
    runtime_executor_litert_compiled_model_executor_utils
    runtime_executor_llm_executor
    runtime_executor_llm_executor_processed_tokens
    runtime_executor_llm_litert_compiled_model_cache_utils
    runtime_executor_magic_number_configs_helper
    runtime_components_model_resources
    runtime_components_model_resources_litert_lm
    runtime_components_model_resources_task
    runtime_components_sampler
    runtime_components_sampler_factory
    runtime_components_embedding_lookup_embedding_lookup_manager
    runtime_util_convert_tensor_buffer
    runtime_util_file_util
    runtime_util_litert_status_util
    runtime_util_lora_util
    runtime_util_scoped_file
  PRIVATE
    proto_lib
    LITERTLM_DEPS
    litert_libs
  # litert_litert_cc_litert_tensor_buffer_types
  # litert_tflite_delegates_xnnpack_xnnpack_delegate
  # litert_litert_cc_litert_api_with_dynamic_runtime
  # litert_litert_c_internal_litert_external_litert_buffer_context litert_litert_cc_litert_common
  # litert_litert_cc_litert_compiled_model
  # litert_litert_cc_litert_element_type
  # litert_litert_cc_litert_environment
  # litert_litert_cc_litert_expected
  # litert_litert_cc_litert_macros
  # litert_litert_cc_litert_model
  # litert_litert_cc_litert_options
  # litert_litert_cc_litert_ranked_tensor_type
  # litert_litert_cc_litert_tensor_buffer
  # litert_litert_cc_options_litert_cpu_options
  # litert_litert_cc_options_litert_gpu_options
  # litert_litert_cc_options_litert_runtime_options
)




add_litert_library(runtime_executor_llm_litert_compiled_model_executor STATIC
  llm_litert_compiled_model_executor.cc

)
target_include_directories(runtime_executor_llm_litert_compiled_model_executor
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_executor_llm_litert_compiled_model_executor
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_io_types
    runtime_executor_llm_executor_settings
    runtime_executor_litert_compiled_model_executor_utils
    runtime_executor_llm_executor
    runtime_executor_llm_executor_processed_tokens
    runtime_executor_llm_litert_compiled_model_cache_utils
    runtime_executor_magic_number_configs_helper
    runtime_components_model_resources
    runtime_components_model_resources_litert_lm
    runtime_components_model_resources_task
    runtime_components_sampler
    runtime_components_sampler_factory
    runtime_components_embedding_lookup_embedding_lookup_manager
    runtime_util_convert_tensor_buffer
    runtime_util_file_util
    runtime_util_litert_status_util
    runtime_util_lora_util
    runtime_util_scoped_file
  PRIVATE
    LITERTLM_DEPS
    litert_libs
  # litert_litert_cc_litert_tensor_buffer_types
  # litert_tflite_delegates_xnnpack_xnnpack_delegate
  # litert_litert_cc_litert_api_with_dynamic_runtime
  # litert_litert_c_internal_litert_external_litert_buffer_context litert_litert_cc_litert_common
  # litert_litert_cc_litert_compiled_model
  # litert_litert_cc_litert_element_type
  # litert_litert_cc_litert_environment
  # litert_litert_cc_litert_expected
  # litert_litert_cc_litert_macros
  # litert_litert_cc_litert_model
  # litert_litert_cc_litert_options
  # litert_litert_cc_litert_ranked_tensor_type
  # litert_litert_cc_litert_tensor_buffer
  # litert_litert_cc_options_litert_cpu_options
  # litert_litert_cc_options_litert_gpu_options
  # litert_litert_cc_options_litert_runtime_options
)

# add_litert_executable(runtime_executor_llm_litert_compiled_model_executor_test
#   llm_litert_compiled_model_executor_test.cc
# )
# target_link_libraries(runtime_executor_llm_litert_compiled_model_executor_test PRIVATE
#   # default_static_gpu_accelerator
#   runtime_executor_executor_settings_base
#   runtime_executor_llm_executor_io_types
#   runtime_executor_llm_executor_settings
#   runtime_executor_llm_litert_compiled_model_executor
#   runtime_components_model_resources
#   runtime_components_model_resources_task
#   runtime_components_tokenizer
#   runtime_components_constrained_decoding_constrained_decoder
#   runtime_components_constrained_decoding_fake_constraint
#   runtime_util_convert_tensor_buffer
#   model_asset_bundle_resources
#   runtime_util_scoped_file
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_test_matchers
#   # litert_litert_cc_litert_api_with_dynamic_runtime
#   # litert_litert_cc_litert_element_type
#   # litert_litert_cc_litert_environment
#   # litert_litert_cc_litert_layout
#   # litert_litert_cc_litert_macros
#   # litert_litert_cc_litert_model
# )
# add_test(NAME runtime_executor_llm_litert_compiled_model_executor_test COMMAND llm_litert_compiled_model_executor_test)

add_litert_library(runtime_executor_llm_litert_npu_compiled_model_executor STATIC
  llm_litert_npu_compiled_model_executor.cc
)
target_include_directories(runtime_executor_llm_litert_npu_compiled_model_executor
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_executor_llm_litert_npu_compiled_model_executor
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_io_types
    runtime_executor_llm_executor_settings
    runtime_executor_litert_compiled_model_executor_utils 
    runtime_executor_llm_executor
    runtime_components_model_resources
    runtime_components_model_resources_task
    runtime_components_embedding_lookup_embedding_lookup_manager
    runtime_executor_llm_executor_processed_tokens
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
  # litert_litert_cc_litert_api_with_dynamic_runtime litert_litert_c_options_litert_qualcomm_options litert_litert_cc_litert_common litert_litert_cc_litert_compiled_model litert_litert_cc_litert_element_type litert_litert_cc_litert_environment litert_litert_cc_litert_expected litert_litert_cc_litert_layout litert_litert_cc_litert_macros litert_litert_cc_litert_model litert_litert_cc_litert_options litert_litert_cc_litert_tensor_buffer litert_litert_cc_options_litert_google_tensor_options litert_litert_cc_options_litert_mediatek_options litert_litert_cc_options_litert_qualcomm_options)
)

add_litert_library(runtime_executor_magic_number_configs_helper STATIC
  magic_number_configs_helper.cc
)
target_include_directories(runtime_executor_magic_number_configs_helper PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_executor_magic_number_configs_helper
  PUBLIC 
    runtime_executor_llm_executor_settings
    runtime_components_model_resources
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
  # litert_litert_cc_options_litert_magic_number_options
  # litert_litert_cc_litert_api_with_dynamic_runtime
  # litert_litert_cc_litert_environment
  # litert_litert_cc_litert_expected
  # litert_litert_cc_litert_macros
  # litert_litert_cc_litert_model
)

# add_litert_executable(runtime_executor_magic_number_configs_helper_test
#   magic_number_configs_helper_test.cc
# )
# target_link_libraries(runtime_executor_magic_number_configs_helper_test PRIVATE
#   runtime_executor_executor_settings_base
#   runtime_util_litert_status_util
#   runtime_executor_llm_executor_settings
#   runtime_executor_magic_number_configs_helper
#   runtime_components_model_resources
#   runtime_util_test_utils  
#   runtime_comonents_tokenizer
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_cc_litert_macros
#   # litert_litert_cc_litert_model
# )
# add_test(NAME runtime_executor_magic_number_configs_helper_test COMMAND magic_number_configs_helper_test)


add_litert_library(runtime_executor_vision_executor INTERFACE)
target_include_directories(runtime_executor_vision_executor INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)


add_litert_library(runtime_executor_vision_executor_base INTERFACE)
target_include_directories(runtime_executor_vision_executor_base INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)


add_litert_library(runtime_executor_vision_executor_settings STATIC
  vision_executor_settings.cc
)
target_include_directories(runtime_executor_vision_executor_settings
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_executor_vision_executor_settings
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_executor_vision_executor_settings_test
#   vision_executor_settings_test.cc
# )
# target_link_libraries(runtime_executor_vision_executor_settings_test PRIVATE
#   runtime_executor_executor_settings_base
#   runtime_executor_vision_executor_settings
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   )
# add_test(NAME runtime_executor_vision_executor_settings_test COMMAND vision_executor_settings_test)

add_litert_library(runtime_executor_vision_litert_compiled_model_executor STATIC
  vision_litert_compiled_model_executor.cc
)
target_include_directories(runtime_executor_vision_litert_compiled_model_executor
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_executor_vision_litert_compiled_model_executor
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_io_types
    runtime_executor_vision_executor_settings
    runtime_util_convert_tensor_buffer
    runtime_executor_litert_compiled_model_executor_utils
    runtime_util_litert_status_util
    runtime_components_model_resources
    runtime_executor_vision_executor
  PRIVATE
    LITERTLM_DEPS
    litert_libs
  # litert_litert_cc_litert_api_with_dynamic_runtime
  # litert_litert_c_options_litert_qualcomm_options
  # litert_litert_cc_litert_common
  # litert_litert_cc_litert_compiled_model
  # litert_litert_cc_litert_environment
  # litert_litert_cc_litert_macros
  # litert_litert_cc_litert_model
  # litert_litert_cc_litert_options
  # litert_litert_cc_litert_tensor_buffer
  # litert_litert_cc_options_litert_cpu_options
  # litert_litert_cc_options_litert_gpu_options
  # litert_litert_cc_options_litert_qualcomm_options
  # litert_litert_cc_options_litert_runtime_options
)

# add_litert_executable(runtime_executor_vision_litert_compiled_model_executor_test
#   vision_litert_compiled_model_executor_test.cc
# )
# target_link_libraries(runtime_executor_vision_litert_compiled_model_executor_test PRIVATE
#   runtime_executor_executor_settings_base
#   runtime_executor_litert_lm_loader
#   runtime_components_model_resources_litert_lm
#   runtime_util_scoped_file
#   runtime_util_test_utils
#   runtime_executor_vision_executor_settings
#   runtime_executor_vision_litert_compiled_model_executor
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_test_matchers
#   # litert_litert_cc_litert_api_with_dynamic_runtime
#   # litert_litert_cc_litert_environment
# )
# add_test(NAME runtime_executor_vision_litert_compiled_model_executor_test COMMAND vision_litert_compiled_model_executor_test)


add_library(runtime_executor_libs INTERFACE)
target_link_libraries(runtime_executor_libs INTERFACE
  runtime_executor_audio_executor_settings
  runtime_executor_audio_litert_compiled_model_executor
  runtime_executor_executor_settings_base
  runtime_executor_fake_llm_executor
  runtime_executor_litert_compiled_model_executor_utils
  runtime_executor_llm_executor_io_types
  runtime_executor_llm_executor_processed_tokens
  runtime_executor_llm_executor_settings
  runtime_executor_llm_litert_compiled_model_executor_factory
  runtime_executor_llm_litert_compiled_model_cache_utils
  runtime_executor_llm_litert_compiled_model_executor
  runtime_executor_llm_litert_npu_compiled_model_executor
  runtime_executor_magic_number_configs_helper
  runtime_executor_vision_executor_settings
  runtime_executor_vision_litert_compiled_model_executor
)