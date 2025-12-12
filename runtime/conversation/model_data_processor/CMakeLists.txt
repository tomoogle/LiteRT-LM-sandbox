set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_library(runtime_conversation_model_data_processor_config_registry INTERFACE)
target_include_directories(runtime_conversation_model_data_processor_config_registry
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

add_library(runtime_conversation_model_data_processor_data_utils STATIC
  data_utils.cc
)
target_include_directories(runtime_conversation_model_data_processor_data_utils
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_conversation_model_data_processor_data_utils
  PUBLIC
    runtime_util_memory_mapped_file
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# add_executable(runtime_conversation_model_data_processor_data_utils_test
#   data_utils_test.cc
# )
# target_link_libraries(runtime_conversation_model_data_processor_data_utils_test PRIVATE runtime_conversation_model_data_processor_data_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_util_memory_mapped_file
#   runtime_util_test_utils)
# add_test(NAME data_utils_test COMMAND data_utils_test)

add_library(runtime_conversation_model_data_processor_gemma3_data_processor STATIC
  gemma3_data_processor.cc
)
target_include_directories(runtime_conversation_model_data_processor_gemma3_data_processor
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_conversation_model_data_processor_gemma3_data_processor 
  PUBLIC
    runtime_conversation_io_types
    runtime_engine_io_types
    runtime_conversation_model_data_processor_gemma3_data_processor_config
    runtime_components_preprocessor_audio_preprocessor
    runtime_components_preprocessor_audio_preprocessor_miniaudio
    runtime_components_preprocessor_image_preprocessor
    runtime_components_preprocessor_stb_image_preprocessor
    runtime_components_tool_use_parser_utils
    runtime_components_tool_use_python_tool_format_utils
    runtime_util_litert_status_util
    runtime_util_memory_mapped_file
    runtime_conversation_model_data_processor_data_utils 
    runtime_conversation_model_data_processor   
  PRIVATE
    LITERTLM_DEPS
    litert_libs

)

add_library(runtime_conversation_model_data_processor_gemma3_data_processor_config INTERFACE)
target_include_directories(runtime_conversation_model_data_processor_gemma3_data_processor_config
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# add_executable(runtime_conversation_model_data_processor_gemma3_data_processor_test
#   gemma3_data_processor_test.cc
# )
# target_link_libraries(runtime_conversation_model_data_processor_gemma3_data_processor_test PRIVATE
#   runtime_conversation_model_data_processor_gemma3_data_processor
#   runtime_conversation_model_data_processor_gemma3_data_processor_config
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   litert_layout
#   runtime_components_prompt_template
#   runtime_components_preprocessor_audio_preprocessor
#   runtime_components_preprocessor_audio_preprocessor_miniaudio
#   runtime_components_preprocessor_image_preprocessor
#   runtime_components_preprocessor_stb_image_preprocessor
#   runtime_conversation_io_types
#   runtime_engine_io_types
#   runtime_util_convert_tensor_buffer
#   runtime_util_test_utils
# )
# add_test(NAME runtime_conversation_model_data_processor_gemma3_data_processor_test COMMAND gemma3_data_processor_test)

add_library(runtime_conversation_model_data_processor_generic_data_processor STATIC
  generic_data_processor.cc
)
target_include_directories(runtime_conversation_model_data_processor_generic_data_processor
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_conversation_model_data_processor_generic_data_processor
  PUBLIC
    runtime_conversation_model_data_processor_config_registry
    runtime_conversation_model_data_processor_generic_data_processor_config
    runtime_conversation_io_types
    runtime_engine_io_types
    runtime_util_litert_status_util
    runtime_conversation_model_data_processor
    
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

add_library(runtime_conversation_model_data_processor_generic_data_processor_config INTERFACE)
target_include_directories(runtime_conversation_model_data_processor_generic_data_processor_config
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# add_executable(runtime_conversation_model_data_processor_generic_data_processor_test
#   generic_data_processor_test.cc
# )
# target_link_libraries(runtime_conversation_model_data_processor_generic_data_processor_test PRIVATE
#   runtime_conversation_model_data_processor_generic_data_processor
#   runtime_conversation_model_data_processor_generic_data_processor_config
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_components_prompt_template
#   runtime_conversation_io_types 
#   runtime_engine_io_types
#   runtime_util_test_utils
# )
# add_test(NAME runtime_conversation_model_data_processor_generic_data_processor_test COMMAND generic_data_processor_test)

add_library(runtime_conversation_model_data_processor INTERFACE)
target_include_directories(runtime_conversation_model_data_processor
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
# NOTE: model_data_processor has deps but is INTERFACE; listing deps for clarity

add_library(runtime_conversation_model_data_processor_factory STATIC
  model_data_processor_factory.cc
)
target_include_directories(runtime_conversation_model_data_processor_factory
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)
target_link_libraries(runtime_conversation_model_data_processor_factory 
  PUBLIC
    runtime_conversation_model_data_processor_config_registry
    runtime_conversation_model_data_processor_gemma3_data_processor
    runtime_conversation_model_data_processor_gemma3_data_processor_config
    runtime_conversation_model_data_processor_generic_data_processor
    runtime_conversation_model_data_processor_generic_data_processor_config
    runtime_conversation_model_data_processor
    runtime_conversation_model_data_processor_qwen3_data_processor
    runtime_conversation_model_data_processor_qwen3_data_processor_config
    runtime_components_tokenizer
    runtime_conversation_io_types
    runtime_util_litert_status_util
  PRIVATE
    proto_lib
    litert_libs
    LITERTLM_DEPS
)

# add_executable(runtime_conversation_model_data_processor_model_data_processor_factory_test
#   model_data_processor_factory_test.cc
# )
# target_link_libraries(runtime_conversation_model_data_processor_model_data_processor_factory_test PRIVATE
#   runtime_conversation_model_data_processor_config_registry
#   runtime_conversation_model_data_processor_gemma3_data_processor_config
#   runtime_conversation_model_data_processor_generic_data_processor_config
#   runtime_conversation_model_data_processor_model_data_processor
#   runtime_conversation_model_data_processor_model_data_processor_factory
#   runtime_conversation_model_data_processor_qwen3_data_processor_config
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_components_sentencepiece_tokenizer
#   runtime_components_tokenizer
#   runtime_conversation_io_types
#   runtime_engine_io_types
#   runtime_proto_llm_model_type_cc_proto
#   runtime_util_litert_status_util
#   runtime_util_test_utils
# )
# add_test(NAME runtime_conversation_model_data_processor_model_data_processor_factory_test COMMAND model_data_processor_factory_test)

add_library(runtime_conversation_model_data_processor_qwen3_data_processor STATIC
  qwen3_data_processor.cc
)
target_include_directories(runtime_conversation_model_data_processor_qwen3_data_processor 
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
  )
target_link_libraries(runtime_conversation_model_data_processor_qwen3_data_processor
  PUBLIC
    runtime_conversation_model_data_processor_config_registry
    runtime_conversation_model_data_processor
    runtime_conversation_model_data_processor_qwen3_data_processor_config
    runtime_components_tool_use_parser_utils
    runtime_conversation_io_types
    runtime_engine_io_types
    runtime_util_litert_status_util
  PRIVATE  
    litert_libs
    LITERTLM_DEPS
)

add_library(runtime_conversation_model_data_processor_qwen3_data_processor_config INTERFACE)
target_include_directories(runtime_conversation_model_data_processor_qwen3_data_processor_config
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# add_executable(runtime_conversation_model_data_processor_qwen3_data_processor_test
#   qwen3_data_processor_test.cc
# )
# target_link_libraries(runtime_conversation_model_data_processor_qwen3_data_processor_test PRIVATE
#   runtime_conversation_model_data_processor_qwen3_data_processor
#   qwen3_data_processor_config
#   ${LITERTLM_DEPS}
#   ${absl_libs}
#   runtime_components_prompt_template
#   runtime_conversation_io_types
#   runtime_engine_io_types
#   runtime_util_test_utils
# )
# add_test(NAME runtime_conversation_model_data_processor_qwen3_data_processor_test COMMAND qwen3_data_processor_test)

add_library(runtime_conversation_model_data_processor_libs INTERFACE)
target_link_libraries(runtime_conversation_model_data_processor_libs INTERFACE
  runtime_conversation_model_data_processor_config_registry
  runtime_conversation_model_data_processor_data_utils
  runtime_conversation_model_data_processor_gemma3_data_processor
  runtime_conversation_model_data_processor_gemma3_data_processor_config
  runtime_conversation_model_data_processor_generic_data_processor
  runtime_conversation_model_data_processor_generic_data_processor_config
  runtime_conversation_model_data_processor
  runtime_conversation_model_data_processor_factory
  runtime_conversation_model_data_processor_qwen3_data_processor
  runtime_conversation_model_data_processor_qwen3_data_processor_config
)