set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Subdirectories ---
add_subdirectory(constrained_decoding)
add_subdirectory(embedding_lookup)
add_subdirectory(preprocessor)
add_subdirectory(testdata)
add_subdirectory(tool_use)
# add_subdirectory(tool_use/antlr) # (Already included by tool_use/CMakeLists.txt)

# --- HuggingFace Tokenizer ---
add_litertlm_library(runtime_components_huggingface_tokenizer STATIC
  huggingface_tokenizer.cc
)
add_library(LiteRTLM::Runtime::Components::Tokenizer::HuggingFace ALIAS runtime_components_huggingface_tokenizer)

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
    LiteRTLM::Runtime::Components::Tokenizer::Interface # (Defined below)
    runtime_util_litert_status_util
    runtime_util_memory_mapped_file
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- LoRA ---
add_litertlm_library(runtime_components_lora STATIC
  lora.cc
)
add_library(LiteRTLM::Runtime::Components::::LoRA ALIAS runtime_components_lora)

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

# --- LoRA Manager ---
add_litertlm_library(runtime_components_lora_manager STATIC
  lora_manager.cc
)
add_library(LiteRTLM::Runtime::Components::::LoRAManager ALIAS runtime_components_lora_manager)

target_include_directories(runtime_components_lora_manager
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_lora_manager
  PUBLIC
    LiteRTLM::Runtime::Components::::LoRA
    runtime_util_litert_status_util
    runtime_util_lora_data
    runtime_executor_executor_settings_base
  PRIVATE 
    litert_libs
    LITERTLM_DEPS
)

# --- Model Resources Interface ---
add_litertlm_library(runtime_components_model_resources INTERFACE)
add_library(LiteRTLM::Runtime::Components::::ModelResources::Interface ALIAS runtime_components_model_resources)

target_include_directories(runtime_components_model_resources
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Model Resources LiteRT LM ---
add_litertlm_library(runtime_components_model_resources_litert_lm STATIC
  model_resources_litert_lm.cc
)
add_library(LiteRTLM::Runtime::Components::::ModelResources::LiteRTLM ALIAS runtime_components_model_resources_litert_lm)

target_include_directories(runtime_components_model_resources_litert_lm
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_model_resources_litert_lm 
  PUBLIC
    LiteRTLM::Runtime::Components::::ModelResources::Interface
    runtime_util_litert_lm_loader
    runtime_util_litert_status_util
    LiteRTLM::Runtime::Components::Tokenizer::HuggingFace
    LiteRTLM::Runtime::Components::Tokenizer::SentencePiece # (Defined below)
    LiteRTLM::Runtime::Components::Tokenizer::Interface
  PRIVATE
    proto_lib
    LITERTLM_DEPS
    litert_libs
)

# --- Model Resources Task ---
add_litertlm_library(runtime_components_model_resources_task STATIC
  model_resources_task.cc
)
add_library(LiteRTLM::Runtime::Components::::ModelResources::Task ALIAS runtime_components_model_resources_task)

target_include_directories(runtime_components_model_resources_task
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_model_resources_task
  PUBLIC
    LiteRTLM::Runtime::Components::::ModelResources::Interface
    runtime_util_model_asset_bundle_resources
    runtime_util_litert_status_util
    runtime_util_metadata_util
    LiteRTLM::Runtime::Components::Tokenizer::SentencePiece
    LiteRTLM::Runtime::Components::Tokenizer::Interface
  PRIVATE
    proto_lib 
    LITERTLM_DEPS
    litert_libs
)

# --- Prompt Template ---
add_litertlm_library(runtime_components_prompt_template STATIC
  prompt_template.cc
)
add_library(LiteRTLM::Runtime::Components::::PromptTemplate ALIAS runtime_components_prompt_template)

target_include_directories(runtime_components_prompt_template
  PRIVATE
    ${THIRD_PARTY_DIR}/json/include
    ${THIRD_PARTY_DIR}/minja/include
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_prompt_template
  PUBLIC
    runtime_util_litert_status_util
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

# --- Sampler Interface ---
add_litertlm_library(runtime_components_sampler INTERFACE)
add_library(LiteRTLM::Runtime::Components::::Sampler::Interface ALIAS runtime_components_sampler)

target_include_directories(runtime_components_sampler
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Sampler Factory ---
add_litertlm_library(runtime_components_sampler_factory STATIC
  sampler_factory.cc
)
add_library(LiteRTLM::Runtime::Components::::Sampler::Factory ALIAS runtime_components_sampler_factory)

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
    LiteRTLM::Runtime::Components::::Sampler::Interface
    LiteRTLM::Runtime::Components::::Sampler::TopP # (Defined below)
  PRIVATE
    proto_lib
    litert_libs
    LITERTLM_DEPS
)

# --- Sampling CPU Util ---
add_litertlm_library(runtime_components_sampling_cpu_util STATIC
  sampling_cpu_util.cc
)
add_library(LiteRTLM::Runtime::Components::::SamplingCpuUtil ALIAS runtime_components_sampling_cpu_util)

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

# --- Scoring CPU Util ---
add_litertlm_library(runtime_components_scoring_cpu_util STATIC
  scoring_cpu_util.cc
)
add_library(LiteRTLM::Runtime::Components::::ScoringCpuUtil ALIAS runtime_components_scoring_cpu_util)

target_include_directories(runtime_components_scoring_cpu_util
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

target_link_libraries(runtime_components_scoring_cpu_util
  PUBLIC
    LiteRTLM::Runtime::Components::::SamplingCpuUtil 
    runtime_util_litert_status_util
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- SentencePiece Tokenizer ---
add_litertlm_library(runtime_components_sentencepiece_tokenizer STATIC
  sentencepiece_tokenizer.cc
)
add_library(LiteRTLM::Runtime::Components::Tokenizer::SentencePiece ALIAS runtime_components_sentencepiece_tokenizer)

target_include_directories(runtime_components_sentencepiece_tokenizer
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_sentencepiece_tokenizer
  PUBLIC
    LiteRTLM::Runtime::Components::Tokenizer::Interface
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Stop Token Detector ---
add_litertlm_library(runtime_components_stop_token_detector STATIC
  stop_token_detector.cc
)
add_library(LiteRTLM::Runtime::Components::::StopTokenDetector ALIAS runtime_components_stop_token_detector)

target_include_directories(runtime_components_stop_token_detector
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_stop_token_detector
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Token ID Util ---
add_litertlm_library(runtime_components_token_id_util STATIC
  token_id_util.cc
)
add_library(LiteRTLM::Runtime::Components::TokenIdUtil ALIAS runtime_components_token_id_util)

target_include_directories(runtime_components_token_id_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_token_id_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Tokenizer Interface ---
add_litertlm_library(runtime_components_tokenizer INTERFACE)
add_library(LiteRTLM::Runtime::Components::Tokenizer::Interface ALIAS runtime_components_tokenizer)

target_include_directories(runtime_components_tokenizer
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Top P CPU Sampler ---
add_litertlm_library(runtime_components_top_p_cpu_sampler STATIC
  top_p_cpu_sampler.cc
)
add_library(LiteRTLM::Runtime::Components::::Sampler::TopP ALIAS runtime_components_top_p_cpu_sampler)

target_include_directories(runtime_components_top_p_cpu_sampler
  PUBLIC
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_top_p_cpu_sampler
  PUBLIC
    LiteRTLM::Runtime::Components::::Sampler::Interface
    LiteRTLM::Runtime::Components::::SamplingCpuUtil
    runtime_util_convert_tensor_buffer
    runtime_util_tensor_buffer_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Folder Facade ---
add_library(runtime_components_libs INTERFACE)
add_library(LiteRTLM::Runtime::Components:: ALIAS runtime_components_libs)

target_link_libraries(runtime_components_libs INTERFACE
  # Subdirectories
  LiteRTLM::Runtime::Components::ConstrainedDecoding
  LiteRTLM::Runtime::Components::EmbeddingLookup
  LiteRTLM::Runtime::Components::Preprocessor
  LiteRTLM::Runtime::Components::ToolUse
  
  # Local Components
  LiteRTLM::Runtime::Components::Tokenizer::HuggingFace
  LiteRTLM::Runtime::Components::::LoRA
  LiteRTLM::Runtime::Components::::LoRAManager
  LiteRTLM::Runtime::Components::::ModelResources::Interface
  LiteRTLM::Runtime::Components::::ModelResources::LiteRTLM
  LiteRTLM::Runtime::Components::::ModelResources::Task
  LiteRTLM::Runtime::Components::::PromptTemplate
  LiteRTLM::Runtime::Components::::Sampler::Interface
  LiteRTLM::Runtime::Components::::Sampler::Factory
  LiteRTLM::Runtime::Components::::SamplingCpuUtil
  LiteRTLM::Runtime::Components::::ScoringCpuUtil
  LiteRTLM::Runtime::Components::Tokenizer::SentencePiece
  LiteRTLM::Runtime::Components::::StopTokenDetector
  LiteRTLM::Runtime::Components::TokenIdUtil
  LiteRTLM::Runtime::Components::Tokenizer::Interface
  LiteRTLM::Runtime::Components::::Sampler::TopP
)