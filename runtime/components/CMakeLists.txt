set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})


add_subdirectory(constrained_decoding)
add_subdirectory(embedding_lookup)
add_subdirectory(preprocessor)
#add_subdirectory(preprocessor/testdata)
add_subdirectory(testdata)
add_subdirectory(tool_use)
add_subdirectory(tool_use/antlr)




add_litert_library(runtime_components_huggingface_tokenizer STATIC
  huggingface_tokenizer.cc
)
target_include_directories(runtime_components_huggingface_tokenizer
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}/tokenizers-cpp
)
target_link_libraries(runtime_components_huggingface_tokenizer
  PUBLIC
    runtime_components_tokenizer
    runtime_util_litert_status_util
    runtime_util_memory_mapped_file
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# add_litert_executable(runtime_components_huggingface_tokenizer_test
#   huggingface_tokenizer_test.cc
# )
# target_link_libraries(runtime_components_huggingface_tokenizer_test PRIVATE
#   runtime_components_huggingface_tokenizer
#   runtime_components_tokenizer
#   runtime_util_litert_status_util
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_components_huggingface_tokenizer_test COMMAND runtime_components_huggingface_tokenizer_test)

add_litert_library(runtime_components_lora STATIC
  lora.cc
)
target_include_directories(runtime_components_lora
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}/litert/src/litert_external-build/include
  )
target_link_libraries(runtime_components_lora
  PUBLIC
    runtime_util_litert_status_util
    runtime_util_lora_data
    runtime_util_lora_util
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

add_litert_library(runtime_components_lora_manager STATIC
  lora_manager.cc
)
target_include_directories(runtime_components_lora_manager
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_components_lora_manager
  PUBLIC
    runtime_components_lora
    runtime_util_litert_status_util
    runtime_util_lora_data
    runtime_executor_executor_settings_base
  PRIVATE 
    litert_libs
    LITERTLM_DEPS
)

# add_litert_executable(runtime_components_lora_manager_test
#   lora_manager_test.cc
# )
# target_link_libraries(runtime_components_lora_manager_test PRIVATE
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_components_lora_manager
#   com_google_googletest_gtest_maincom_google_absl_absl_status_status
#   litert_cc_litert_common
#   litert_cc_litert_compiled_model
#   litert_cc_litert_environment
#   litert_litert_cc_litert_model litert_litert_cc_litert_options litert_litert_cc_litert_tensor_buffer litert_litert_test_matchers
#   runtime_executor_executor_settings_base
#   runtime_util_test_utils
# )
# add_test(NAME runtime_components_lora_manager_test COMMAND runtime_components_lora_manager_test)

# add_litert_executable(runtime_components_lora_test
#   lora_test.cc
# )
# target_link_libraries(runtime_components_lora_test PRIVATE runtime_components_lora 
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   #litert_litert_cc_litert_common litert_litert_cc_litert_compiled_model litert_litert_cc_litert_environment litert_litert_cc_litert_model litert_litert_cc_litert_options litert_litert_cc_litert_tensor_buffer litert_litert_test_matchers
#   runtime_util_lora_data
#   runtime_util_test_utils
# )
# add_test(NAME runtime_components_lora_test COMMAND runtime_components_lora_test)

add_litert_library(runtime_components_model_resources INTERFACE)
target_include_directories(runtime_components_model_resources
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS})

add_litert_library(runtime_components_model_resources_litert_lm STATIC
  model_resources_litert_lm.cc
)
target_include_directories(runtime_components_model_resources_litert_lm
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
  )
target_link_libraries(runtime_components_model_resources_litert_lm 
  PUBLIC
    runtime_components_model_resources
    runtime_util_litert_lm_loader
    runtime_util_litert_status_util
    runtime_components_huggingface_tokenizer
    runtime_components_sentencepiece_tokenizer
    runtime_components_tokenizer
  PRIVATE
    proto_lib
    LITERTLM_DEPS
    litert_libs
  #litert_litert_cc_litert_api_with_dynamic_runtime litert_litert_cc_litert_buffer_ref litert_litert_cc_litert_macros litert_litert_cc_litert_model
)

add_litert_library(runtime_components_model_resources_task STATIC
  model_resources_task.cc
)
target_include_directories(runtime_components_model_resources_task
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_components_model_resources_task
  PUBLIC
    runtime_components_model_resources
    runtime_util_model_asset_bundle_resources
    runtime_util_litert_status_util
    runtime_util_metadata_util
    runtime_components_sentencepiece_tokenizer
    runtime_components_tokenizer
  PRIVATE
    proto_lib 
    LITERTLM_DEPS
    litert_libs

  #litert_litert_cc_litert_api_with_dynamic_runtime litert_litert_cc_litert_buffer_ref litert_litert_cc_litert_macros litert_litert_cc_litert_model
)

add_litert_library(runtime_components_prompt_template STATIC
  prompt_template.cc
)
target_include_directories(runtime_components_prompt_template
  PRIVATE
    ${THIRD_PARTY_DIR}/json/include
    ${THIRD_PARTY_DIR}/minja/include
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_components_prompt_template
  PUBLIC
    runtime_util_litert_status_util
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_components_prompt_template_test
#   prompt_template_test.cc
# )
# target_link_libraries(runtime_components_prompt_template_test PRIVATE
#   runtime_components_prompt_template
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_util_litert_status_util
#   runtime_util_test_utils
# )
# add_test(NAME runtime_components_prompt_template_test COMMAND runtime_components_prompt_template_test)

add_litert_library(runtime_components_sampler INTERFACE)
target_include_directories(runtime_components_sampler
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
  )
add_litert_library(runtime_components_sampler_factory STATIC
  sampler_factory.cc
)
target_include_directories(runtime_components_sampler_factory 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
  )
target_link_libraries(runtime_components_sampler_factory
  PUBLIC
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_settings 
    runtime_util_litert_status_util
    runtime_components_sampler
    runtime_components_top_p_cpu_sampler 
  PRIVATE
    proto_lib
    litert_libs
    LITERTLM_DEPS
    # litert_litert_cc_litert_macros litert_litert_cc_internal_litert_shared_library litert_litert_cc_litert_api_with_dynamic_runtime litert_litert_cc_litert_tensor_buffer
)

# add_litert_executable(runtime_components_sampler_factory_failed_dlopen_test
#   sampler_factory_failed_dlopen_test.cc
# )
# target_link_libraries(runtime_components_sampler_factory_failed_dlopen_test PRIVATE
#   runtime_components_sampler_factory runtime_components_top_p_cpu_sampler
#   runtime_executor_executor_settings_base
#   runtime_proto_sampler_params_cc_proto
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   #litert_litert_cc_litert_api_with_dynamic_runtime litert_litert_cc_litert_environment
# )
# add_test(NAME runtime_components_sampler_factory_failed_dlopen_test COMMAND runtime_components_sampler_factory_failed_dlopen_test)

# add_litert_executable(runtime_components_sampler_factory_test
#   sampler_factory_test.cc
# )
# target_link_libraries(runtime_components_sampler_factory_test PRIVATE
#   runtime_components_model_resources
#   runtime_components_model_resources_task
#   runtime_components_sampler_factory
#   runtime_components_top_p_cpu_sampler 
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   #litert_litert_cc_litert_compiled_model litert_litert_cc_litert_environment litert_litert_cc_litert_expected litert_litert_cc_litert_options litert_litert_cc_options_litert_gpu_options
#   runtime_executor_executor_settings_base
#   runtime_proto_sampler_params_cc_proto
#   runtime_util_litert_status_util
#   runtime_util_model_asset_bundle_resources
#   runtime_util_scoped_file
#   runtime_util_test_utils
# )
# add_test(NAME runtime_components_sampler_factory_test COMMAND runtime_components_sampler_factory_test)

add_litert_library(runtime_components_sampling_cpu_util STATIC
  sampling_cpu_util.cc
)
target_include_directories(runtime_components_sampling_cpu_util
  PRIVATE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)
target_link_libraries(runtime_components_sampling_cpu_util
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_components_sampling_cpu_util_test
#   sampling_cpu_util_test.cc
# )
# target_link_libraries(runtime_components_sampling_cpu_util_test PRIVATE
#   
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_components_sampling_cpu_util_test COMMAND runtime_components_sampling_cpu_util_test)

add_litert_library(runtime_components_scoring_cpu_util STATIC
  scoring_cpu_util.cc
)
target_include_directories(runtime_components_scoring_cpu_util
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR})
target_link_libraries(runtime_components_scoring_cpu_util
  PUBLIC
    runtime_components_sampling_cpu_util 
    runtime_util_litert_status_util
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# add_litert_executable(runtime_components_scoring_cpu_util_test
#   scoring_cpu_util_test.cc
# )
# target_link_libraries(runtime_components_scoring_cpu_util_test PRIVATE
#   runtime_components_sampling_cpu_util
#   runtime_components_scoring_cpu_util
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_util_litert_status_util
#   runtime_util_test_utils
# )
# add_test(NAME runtime_components_scoring_cpu_util_test COMMAND runtime_components_scoring_cpu_util_test)

add_litert_library(runtime_components_sentencepiece_tokenizer STATIC
  sentencepiece_tokenizer.cc
)
target_include_directories(runtime_components_sentencepiece_tokenizer
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_components_sentencepiece_tokenizer
  PUBLIC
  runtime_components_tokenizer
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_components_sentencepiece_tokenizer_test
#   sentencepiece_tokenizer_test.cc
# )
# target_link_libraries(runtime_components_sentencepiece_tokenizer_test PRIVATE runtime_components_sentencepiece_tokenizer
#   runtime_components_tokenizer
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_util_test_utils
# )

# add_test(NAME runtime_components_sentencepiece_tokenizer_test COMMAND runtime_components_sentencepiece_tokenizer_test)

add_litert_library(runtime_components_stop_token_detector STATIC
  stop_token_detector.cc
)
target_include_directories(runtime_components_stop_token_detector
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_components_stop_token_detector
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_components_stop_token_detector_test
#   stop_token_detector_test.cc
# )
# target_link_libraries(runtime_components_stop_token_detector_test PRIVATE
#   runtime_components_stop_token_detector
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_util_test_utils
# )
# add_test(NAME runtime_components_stop_token_detector_test COMMAND runtime_components_stop_token_detector_test)

add_litert_library(runtime_components_token_id_util STATIC
  token_id_util.cc
)
target_include_directories(runtime_components_token_id_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_components_token_id_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# add_litert_executable(runtime_components_token_id_util_test
#   token_id_util_test.cc
# )
# target_link_libraries(runtime_components_token_id_util_test PRIVATE runtime_components_token_id_util com_google_googletest_gtest_main com_google_absl_absl_status_status runtime_util_test_utils)
# add_test(NAME runtime_components_token_id_util_test COMMAND runtime_components_token_id_util_test)

add_litert_library(runtime_components_tokenizer INTERFACE)
target_include_directories(runtime_components_tokenizer
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS})
# NOTE: runtime_components_tokenizer has deps but is INTERFACE; listing deps for clarity

# add_litert_executable(runtime_components_tokenizer_test
#   tokenizer_test.cc
# )
# target_link_libraries(runtime_components_tokenizer_test PRIVATE
#   runtime_components_tokenizer
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   #litert_litert_cc_litert_layout litert_litert_cc_litert_tensor_buffer litert_litert_test_matchers
#   runtime_util_convert_tensor_buffer
# )
# add_test(NAME runtime_components_tokenizer_test COMMAND runtime_components_tokenizer_test)

add_litert_library(runtime_components_top_p_cpu_sampler STATIC
  top_p_cpu_sampler.cc
)
target_include_directories(runtime_components_top_p_cpu_sampler
  PUBLIC
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_components_top_p_cpu_sampler
  PUBLIC
    runtime_components_sampler
    runtime_components_sampling_cpu_util
    runtime_util_convert_tensor_buffer
    runtime_util_tensor_buffer_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    #litert_litert_cc_litert_api_with_dynamic_runtime litert_litert_cc_litert_macros litert_litert_cc_litert_tensor_buffer
)

# add_litert_executable(runtime_components_top_p_cpu_sampler_test
#   top_p_cpu_sampler_test.cc
# )
# target_link_libraries(runtime_components_top_p_cpu_sampler_test PRIVATE
#   runtime_components_top_p_cpu_sampler
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_util_convert_tensor_buffer
# )
# add_test(NAME runtime_components_top_p_cpu_sampler_test COMMAND runtime_components_top_p_cpu_sampler_test)


add_library(runtime_components_libs INTERFACE)
target_link_libraries(runtime_components_libs INTERFACE
  runtime_components_huggingface_tokenizer
  runtime_components_lora
  runtime_components_lora_manager
  runtime_components_model_resources
  runtime_components_model_resources_litert_lm
  runtime_components_model_resources_task
  runtime_components_prompt_template
  runtime_components_sampler
  runtime_components_sampler_factory
  runtime_components_sampling_cpu_util
  runtime_components_sentencepiece_tokenizer
  runtime_components_stop_token_detector
  runtime_components_token_id_util
  runtime_components_tokenizer
  runtime_components_top_p_cpu_sampler
  runtime_components_constrained_decoding_libs
  runtime_components_embedding_lookup_libs
  runtime_components_preprocessor_libs
  runtime_components_tool_use_libs
)