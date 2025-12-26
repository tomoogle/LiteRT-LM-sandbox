set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Audio Executor Interface ---
add_litertlm_library(runtime_executor_audio_executor INTERFACE)
add_library(LiteRTLM::Executor::Audio::Interface ALIAS runtime_executor_audio_executor)

target_include_directories(runtime_executor_audio_executor
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Audio Executor Base ---
add_litertlm_library(runtime_executor_audio_executor_base INTERFACE)
add_library(LiteRTLM::Executor::Audio::Base ALIAS runtime_executor_audio_executor_base)

target_include_directories(runtime_executor_audio_executor_base
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Audio Executor Settings ---
add_litertlm_library(runtime_executor_audio_executor_settings STATIC
  audio_executor_settings.cc
)
add_library(LiteRTLM::Executor::Audio::Settings ALIAS runtime_executor_audio_executor_settings)

target_include_directories(runtime_executor_audio_executor_settings
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_audio_executor_settings
  PUBLIC
    LiteRTLM::Executor::SettingsBase # (Defined below)
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Audio LiteRT Compiled Model Executor ---
add_litertlm_library(runtime_executor_audio_litert_compiled_model_executor STATIC
  audio_litert_compiled_model_executor.cc
)
add_library(LiteRTLM::Executor::Audio::CompiledModel ALIAS runtime_executor_audio_litert_compiled_model_executor)

target_include_directories(runtime_executor_audio_litert_compiled_model_executor
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_audio_litert_compiled_model_executor
  PUBLIC
    LiteRTLM::Executor::Audio::Interface
    LiteRTLM::Executor::Audio::Settings
    LiteRTLM::Executor::SettingsBase
    LiteRTLM::Executor::LLM::IoTypes # (Defined below)
    LiteRTLM::Runtime::Components::ModelResources::Interface
    runtime_util_litert_status_util
    LiteRTLM::Executor::CompiledModelUtils # (Defined below)
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Executor Settings Base ---
add_litertlm_library(runtime_executor_executor_settings_base STATIC
  executor_settings_base.cc
)
add_library(LiteRTLM::Executor::SettingsBase ALIAS runtime_executor_executor_settings_base)

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

# --- Fake LLM Executor ---
add_litertlm_library(runtime_executor_fake_llm_executor STATIC
  fake_llm_executor.cc
)
add_library(LiteRTLM::Executor::LLM::Fake ALIAS runtime_executor_fake_llm_executor)

target_include_directories(runtime_executor_fake_llm_executor
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_fake_llm_executor
  PUBLIC
    LiteRTLM::Executor::SettingsBase
    LiteRTLM::Executor::LLM::Interface # (Defined below)
    LiteRTLM::Executor::LLM::IoTypes
    LiteRTLM::Executor::LLM::Settings # (Defined below)
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- LiteRT Compiled Model Executor Utils ---
add_litertlm_library(runtime_executor_litert_compiled_model_executor_utils STATIC
  litert_compiled_model_executor_utils.cc
)
add_library(LiteRTLM::Executor::CompiledModelUtils ALIAS runtime_executor_litert_compiled_model_executor_utils)

target_include_directories(runtime_executor_litert_compiled_model_executor_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_litert_compiled_model_executor_utils
  PUBLIC
    LiteRTLM::Executor::SettingsBase
    LiteRTLM::Runtime::Components::ModelResources::Interface
    LiteRTLM::Runtime::Components::ModelResources::LiteRTLM
    LiteRTLM::Runtime::Components::ModelResources::Task
    LiteRTLM::Runtime::Components::Tokenizer::SentencePiece
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
)

# --- LLM Executor Interface ---
add_litertlm_library(runtime_executor_llm_executor INTERFACE)
add_library(LiteRTLM::Executor::LLM::Interface ALIAS runtime_executor_llm_executor)

target_include_directories(runtime_executor_llm_executor 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- LLM Executor Base ---
add_litertlm_library(runtime_executor_llm_executor_base INTERFACE)
add_library(LiteRTLM::Executor::LLM::Base ALIAS runtime_executor_llm_executor_base)

target_include_directories(runtime_executor_llm_executor_base
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- LLM Executor IO Types ---
add_litertlm_library(runtime_executor_llm_executor_io_types STATIC
  llm_executor_io_types.cc
)
add_library(LiteRTLM::Executor::LLM::IoTypes ALIAS runtime_executor_llm_executor_io_types)

target_include_directories(runtime_executor_llm_executor_io_types
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_llm_executor_io_types
  PUBLIC
    LiteRTLM::Runtime::Components::ConstrainedDecoding::Decoder
    runtime_util_logging_tensor_buffer
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

# --- LLM Executor Processed Tokens ---
add_litertlm_library(runtime_executor_llm_executor_processed_tokens STATIC
  llm_executor_processed_tokens.cc
)
add_library(LiteRTLM::Executor::LLM::ProcessedTokens ALIAS runtime_executor_llm_executor_processed_tokens)

target_include_directories(runtime_executor_llm_executor_processed_tokens
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_llm_executor_processed_tokens
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- LLM Executor Settings ---
add_litertlm_library(runtime_executor_llm_executor_settings STATIC
  llm_executor_settings.cc
)
add_library(LiteRTLM::Executor::LLM::Settings ALIAS runtime_executor_llm_executor_settings)

target_include_directories(runtime_executor_llm_executor_settings
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_llm_executor_settings
  PUBLIC
    LiteRTLM::Executor::SettingsBase
    runtime_util_litert_status_util
    runtime_util_logging
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# --- LLM LiteRT Compiled Model Cache Utils ---
add_litertlm_library(runtime_executor_llm_litert_compiled_model_cache_utils STATIC
  llm_litert_compiled_model_cache_utils.cc
)
add_library(LiteRTLM::Executor::LLM::CacheUtils ALIAS runtime_executor_llm_litert_compiled_model_cache_utils)

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

# --- LLM LiteRT Compiled Model Executor Factory ---
add_litertlm_library(runtime_executor_llm_litert_compiled_model_executor_factory STATIC
  llm_litert_compiled_model_executor_factory.cc
)
add_library(LiteRTLM::Executor::LLM::Factory ALIAS runtime_executor_llm_litert_compiled_model_executor_factory)

target_include_directories(runtime_executor_llm_litert_compiled_model_executor_factory
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_llm_litert_compiled_model_executor_factory
  PUBLIC
    LiteRTLM::Executor::SettingsBase
    LiteRTLM::Executor::LLM::IoTypes
    LiteRTLM::Executor::LLM::Settings
    LiteRTLM::Executor::LLM::CompiledModel # (Defined below)
    LiteRTLM::Executor::LLM::NpuCompiledModel # (Defined below)
    LiteRTLM::Executor::CompiledModelUtils
    LiteRTLM::Executor::LLM::Interface
    LiteRTLM::Executor::LLM::ProcessedTokens
    LiteRTLM::Executor::LLM::CacheUtils
    LiteRTLM::Executor::MagicNumberConfigsHelper # (Defined below)
    LiteRTLM::Runtime::Components::ModelResources::Interface
    LiteRTLM::Runtime::Components::ModelResources::LiteRTLM
    LiteRTLM::Runtime::Components::ModelResources::Task
    LiteRTLM::Runtime::Components::Sampler::Interface
    LiteRTLM::Runtime::Components::Sampler::Factory
    LiteRTLM::Runtime::Components::EmbeddingLookup::Manager
    runtime_util_convert_tensor_buffer
    runtime_util_file_util
    runtime_util_litert_status_util
    runtime_util_lora_util
    runtime_util_scoped_file
  PRIVATE
    proto_lib
    LITERTLM_DEPS
    litert_libs
)

# --- LLM LiteRT Compiled Model Executor ---
add_litertlm_library(runtime_executor_llm_litert_compiled_model_executor STATIC
  llm_litert_compiled_model_executor.cc
)
add_library(LiteRTLM::Executor::LLM::CompiledModel ALIAS runtime_executor_llm_litert_compiled_model_executor)

target_include_directories(runtime_executor_llm_litert_compiled_model_executor
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_llm_litert_compiled_model_executor
  PUBLIC
    LiteRTLM::Executor::SettingsBase
    LiteRTLM::Executor::LLM::IoTypes
    LiteRTLM::Executor::LLM::Settings
    LiteRTLM::Executor::CompiledModelUtils
    LiteRTLM::Executor::LLM::Interface
    LiteRTLM::Executor::LLM::ProcessedTokens
    LiteRTLM::Executor::LLM::CacheUtils
    LiteRTLM::Executor::MagicNumberConfigsHelper
    LiteRTLM::Runtime::Components::ModelResources::Interface
    LiteRTLM::Runtime::Components::ModelResources::LiteRTLM
    LiteRTLM::Runtime::Components::ModelResources::Task
    LiteRTLM::Runtime::Components::Sampler::Interface
    LiteRTLM::Runtime::Components::Sampler::Factory
    LiteRTLM::Runtime::Components::EmbeddingLookup::Manager
    runtime_util_convert_tensor_buffer
    runtime_util_file_util
    runtime_util_litert_status_util
    runtime_util_lora_util
    runtime_util_scoped_file
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- LLM LiteRT NPU Compiled Model Executor ---
add_litertlm_library(runtime_executor_llm_litert_npu_compiled_model_executor STATIC
  llm_litert_npu_compiled_model_executor.cc
)
add_library(LiteRTLM::Executor::LLM::NpuCompiledModel ALIAS runtime_executor_llm_litert_npu_compiled_model_executor)

target_include_directories(runtime_executor_llm_litert_npu_compiled_model_executor
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_llm_litert_npu_compiled_model_executor
  PUBLIC
    LiteRTLM::Executor::SettingsBase
    LiteRTLM::Executor::LLM::IoTypes
    LiteRTLM::Executor::LLM::Settings
    LiteRTLM::Executor::CompiledModelUtils
    LiteRTLM::Executor::LLM::Interface
    LiteRTLM::Runtime::Components::ModelResources::Interface
    LiteRTLM::Runtime::Components::ModelResources::Task
    LiteRTLM::Runtime::Components::EmbeddingLookup::Manager
    LiteRTLM::Executor::LLM::ProcessedTokens
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Magic Number Configs Helper ---
add_litertlm_library(runtime_executor_magic_number_configs_helper STATIC
  magic_number_configs_helper.cc
)
add_library(LiteRTLM::Executor::MagicNumberConfigsHelper ALIAS runtime_executor_magic_number_configs_helper)

target_include_directories(runtime_executor_magic_number_configs_helper
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_magic_number_configs_helper
  PUBLIC 
    LiteRTLM::Executor::LLM::Settings
    LiteRTLM::Runtime::Components::ModelResources::Interface
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Vision Executor Interface ---
add_litertlm_library(runtime_executor_vision_executor INTERFACE)
add_library(LiteRTLM::Executor::Vision::Interface ALIAS runtime_executor_vision_executor)

target_include_directories(runtime_executor_vision_executor 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Vision Executor Base ---
add_litertlm_library(runtime_executor_vision_executor_base INTERFACE)
add_library(LiteRTLM::Executor::Vision::Base ALIAS runtime_executor_vision_executor_base)

target_include_directories(runtime_executor_vision_executor_base 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Vision Executor Settings ---
add_litertlm_library(runtime_executor_vision_executor_settings STATIC
  vision_executor_settings.cc
)
add_library(LiteRTLM::Executor::Vision::Settings ALIAS runtime_executor_vision_executor_settings)

target_include_directories(runtime_executor_vision_executor_settings
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_vision_executor_settings
  PUBLIC
    LiteRTLM::Executor::SettingsBase
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Vision LiteRT Compiled Model Executor ---
add_litertlm_library(runtime_executor_vision_litert_compiled_model_executor STATIC
  vision_litert_compiled_model_executor.cc
)
add_library(LiteRTLM::Executor::Vision::CompiledModel ALIAS runtime_executor_vision_litert_compiled_model_executor)

target_include_directories(runtime_executor_vision_litert_compiled_model_executor
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_executor_vision_litert_compiled_model_executor
  PUBLIC
    LiteRTLM::Executor::SettingsBase
    LiteRTLM::Executor::LLM::IoTypes
    LiteRTLM::Executor::Vision::Settings
    runtime_util_convert_tensor_buffer
    LiteRTLM::Executor::CompiledModelUtils
    runtime_util_litert_status_util
    LiteRTLM::Runtime::Components::ModelResources::Interface
    LiteRTLM::Executor::Vision::Interface
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Folder Facade ---
add_library(runtime_executor_libs INTERFACE)
add_library(LiteRTLM::Executor ALIAS runtime_executor_libs)

target_link_libraries(runtime_executor_libs INTERFACE
  LiteRTLM::Executor::Audio::Interface
  LiteRTLM::Executor::Audio::Settings
  LiteRTLM::Executor::Audio::CompiledModel
  LiteRTLM::Executor::SettingsBase
  LiteRTLM::Executor::LLM::Fake
  LiteRTLM::Executor::CompiledModelUtils
  LiteRTLM::Executor::LLM::IoTypes
  LiteRTLM::Executor::LLM::ProcessedTokens
  LiteRTLM::Executor::LLM::Settings
  LiteRTLM::Executor::LLM::Factory
  LiteRTLM::Executor::LLM::CacheUtils
  LiteRTLM::Executor::LLM::CompiledModel
  LiteRTLM::Executor::LLM::NpuCompiledModel
  LiteRTLM::Executor::MagicNumberConfigsHelper
  LiteRTLM::Executor::Vision::Settings
  LiteRTLM::Executor::Vision::CompiledModel
)