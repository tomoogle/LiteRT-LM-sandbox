set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_litert_library(runtime_core_engine_impl STATIC
  engine_impl.cc
)
target_include_directories(runtime_core_engine_impl
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_core_engine_impl 
  PUBLIC
    runtime_core_session_factory
    runtime_core_tasks
    # litert_litert_cc_litert_macros
    runtime_components_model_resources
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_audio_executor_settings
    runtime_executor_audio_litert_compiled_model_executor
    runtime_executor_executor_settings_base
    runtime_executor_litert_compiled_model_executor_utils
    runtime_executor_llm_executor
    runtime_executor_llm_executor_settings
    runtime_executor_llm_litert_compiled_model_executor
    runtime_executor_llm_litert_npu_compiled_model_executor
    runtime_executor_magic_number_configs_helper
    runtime_executor_vision_executor
    runtime_executor_vision_executor_settings
    runtime_executor_vision_litert_compiled_model_executor
    runtime_framework_threadpool
    runtime_executor_llm_litert_compiled_model_executor_factory
    proto_lib
    runtime_util_file_format_util
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    # litert_litert_cc_litert_api_with_dynamic_runtime
    # litert_litert_cc_litert_environment
    # runtime_components_default_static_gpu_samplers
    # runtime_executor_default_static_gpu_accelerator
)

add_litert_library(runtime_core_engine_impl_cpu_only STATIC
  engine_impl.cc
)
target_include_directories(runtime_core_engine_impl_cpu_only PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_core_engine_impl_cpu_only
  PUBLIC
    runtime_core_tasks
    # litert_litert_cc_litert_macros
    runtime_components_model_resources
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_audio_executor_settings
    runtime_executor_audio_litert_compiled_model_executor
    runtime_executor_executor_settings_base
    runtime_executor_litert_compiled_model_executor_utils
    runtime_executor_llm_executor
    runtime_executor_llm_executor_settings
    runtime_executor_llm_litert_compiled_model_executor
    runtime_executor_llm_litert_npu_compiled_model_executor
    runtime_executor_magic_number_configs_helper
    runtime_executor_vision_executor
    runtime_executor_vision_executor_settings
    runtime_executor_vision_litert_compiled_model_executor
    runtime_framework_threadpool
    runtime_core_session_factory
    runtime_util_file_format_util
    runtime_util_litert_status_util
    # litert_litert_cc_litert_api_with_dynamic_runtime
    # litert_litert_cc_litert_environment
  PRIVATE 
    litert_libs
    LITERTLM_DEPS
    proto_lib

)

# add_litert_executable(runtime_core_engine_impl_test
#   engine_impl_test.cc
# )
# target_link_libraries(runtime_core_engine_impl_test PRIVATE runtime_core_engine_impl   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_engine_engine_interface
#   runtime_engine_engine_settings
#   runtime_engine_io_types
#   runtime_executor_executor_settings_base
#   runtime_executor_llm_executor_settings
#   runtime_proto_sampler_params_cc_proto
#   runtime_util_scoped_file
#   runtime_util_test_utils
# )
# add_test(NAME runtime_core_engine_impl_test COMMAND runtime_core_engine_impl_test)

add_litert_library(runtime_core_pipeline STATIC
  pipeline.cc
)
target_include_directories(runtime_core_pipeline
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_core_pipeline
  PUBLIC
    runtime_core_tasks
    runtime_components_sampler
    runtime_components_scoring_cpu_util
    runtime_components_stop_token_detector
    runtime_components_token_id_util
    runtime_components_tokenizer
    runtime_components_top_p_cpu_sampler
    runtime_components_constrained_decoding_constrained_decoder
    runtime_components_constrained_decoding_constraint
    runtime_engine_io_types
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor
    runtime_executor_llm_executor_io_types
    runtime_executor_llm_executor_settings
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util    
    runtime_executor_llm_litert_compiled_model_executor
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
    proto_lib
    # litert_litert_cc_litert_api_with_dynamic_runtime
    # litert_litert_cc_litert_macros
    # litert_litert_cc_litert_tensor_buffer
)

# add_litert_executable(runtime_core_pipeline_test
#   pipeline_test.cc
# )
# target_link_libraries(runtime_core_pipeline_test PRIVATE runtime_core_pipeline
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_components_sentencepiece_tokenizer
#   runtime_components_stop_token_detector
#   runtime_components_tokenizer
#   runtime_components_top_p_cpu_sampler
#   runtime_components_constrained_decoding_fake_constraint
#   runtime_engine_io_types
#   runtime_executor_fake_llm_executor
#   runtime_executor_llm_executor_io_types
#   runtime_framework_threadpool
#   runtime_util_convert_tensor_buffer
#   runtime_util_test_utils)
# add_test(NAME runtime_core_pipeline_test COMMAND runtime_core_pipeline_test)

add_litert_library(runtime_core_session_basic STATIC
  session_basic.cc
)
target_include_directories(runtime_core_session_basic
  PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_core_session_basic
  PUBLIC
    runtime_core_tasks
    runtime_core_pipeline
    runtime_components_sampler
    runtime_components_sampler_factory
    runtime_components_stop_token_detector
    runtime_components_tokenizer
    runtime_components_constrained_decoding_constraint
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor
    runtime_executor_llm_executor_io_types
    runtime_executor_vision_executor
    runtime_framework_threadpool
    runtime_util_convert_tensor_buffer
    runtime_util_executor_data_util
    runtime_util_litert_status_util
    runtime_util_model_type_utils
    runtime_util_tensor_buffer_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# add_litert_executable(runtime_core_session_basic_test
#   session_basic_test.cc
# )
# target_link_libraries(runtime_core_session_basic_test PRIVATE runtime_core_session_basic
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   # litert_litert_cc_litert_tensor_buffer
#   # litert_litert_test_matchers
#   runtime_components_sentencepiece_tokenizer
#   runtime_components_tokenizer
#   runtime_components_constrained_decoding_fake_constraint
#   runtime_engine_engine_settings
#   runtime_engine_io_types
#   runtime_executor_audio_executor_settings
#   runtime_executor_audio_litert_compiled_model_executor
#   runtime_executor_executor_settings_base
#   runtime_executor_fake_llm_executor
#   runtime_executor_llm_executor_io_types
#   runtime_framework_threadpool
#   runtime_util_convert_tensor_buffer
#   runtime_util_litert_status_util
#   runtime_util_scoped_file
#   runtime_util_tensor_buffer_util
#   runtime_util_test_utils
#   # litert_litert_cc_litert_api_with_dynamic_runtime
#   # litert_litert_cc_litert_environment
# )
# add_test(NAME runtime_core_session_basic_test COMMAND runtime_core_session_basic_test)

add_litert_library(runtime_core_session_factory STATIC
  session_factory.cc
)
target_include_directories(runtime_core_session_factory
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_core_session_factory
  PUBLIC
    runtime_core_tasks
    runtime_core_session_basic
    runtime_components_tokenizer
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_llm_executor
    runtime_executor_vision_executor
    runtime_framework_threadpool
    runtime_util_litert_status_util
    runtime_core_session_utils
  PRIVATE
    LITERTLM_DEPS
    litert_libs  
    proto_lib
)



add_litert_library(runtime_core_session_utils STATIC
  session_utils.cc
)
target_include_directories(runtime_core_session_utils
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_core_session_utils
  PUBLIC
    runtime_core_tasks
    runtime_core_session_basic
    runtime_components_tokenizer
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_llm_executor
    runtime_executor_vision_executor
    runtime_framework_threadpool
    runtime_util_litert_status_util
  PRIVATE
    litert_libs
    proto_lib
    LITERTLM_DEPS  
)


add_litert_library(runtime_core_tasks STATIC
  tasks.cc
)
target_include_directories(runtime_core_tasks
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_core_tasks
  PUBLIC
    runtime_core_session_basic
    runtime_components_tokenizer
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_llm_executor
    runtime_executor_vision_executor
    runtime_framework_threadpool
    runtime_util_litert_status_util
  PRIVATE
    litert_libs    
    proto_lib
    LITERTLM_DEPS
)




# add_litert_executable(runtime_core_session_factory_test
#   session_factory_test.cc
# )
# target_link_libraries(runtime_core_session_factory_test PRIVATE
#   runtime_core_session_factory
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_components_tokenizer
#   runtime_engine_engine_settings
#   runtime_executor_executor_settings_base
#   runtime_executor_fake_llm_executor
#   runtime_executor_llm_executor
#   runtime_framework_threadpool
#   runtime_util_test_utils
# )
# add_test(NAME runtime_core_session_factory_test COMMAND runtime_core_session_factory_test)

add_library(runtime_core_libs INTERFACE)
target_link_libraries(runtime_core_libs INTERFACE
  runtime_core_engine_impl
  runtime_core_engine_impl_cpu_only
  runtime_core_pipeline
  runtime_core_session_basic
  runtime_core_session_factory
  runtime_core_session_utils
  runtime_core_tasks
)