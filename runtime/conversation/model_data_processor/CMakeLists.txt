set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Config Registry ---
add_litertlm_library(runtime_conversation_model_data_processor_config_registry INTERFACE)
add_library(LiteRTLM::Conversation::Processor::ConfigRegistry ALIAS runtime_conversation_model_data_processor_config_registry)

target_include_directories(runtime_conversation_model_data_processor_config_registry
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Data Utils ---
add_litertlm_library(runtime_conversation_model_data_processor_data_utils STATIC
  data_utils.cc
)
add_library(LiteRTLM::Conversation::Processor::DataUtils ALIAS runtime_conversation_model_data_processor_data_utils)

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

# --- Gemma3 Data Processor Config ---
add_litertlm_library(runtime_conversation_model_data_processor_gemma3_data_processor_config INTERFACE)
add_library(LiteRTLM::Conversation::Processor::Gemma3Config ALIAS runtime_conversation_model_data_processor_gemma3_data_processor_config)

target_include_directories(runtime_conversation_model_data_processor_gemma3_data_processor_config
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Model Data Processor Interface ---
add_litertlm_library(runtime_conversation_model_data_processor INTERFACE)
add_library(LiteRTLM::Conversation::Processor::Interface ALIAS runtime_conversation_model_data_processor)

target_include_directories(runtime_conversation_model_data_processor
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Gemma3 Data Processor ---
add_litertlm_library(runtime_conversation_model_data_processor_gemma3_data_processor STATIC
  gemma3_data_processor.cc
)
add_library(LiteRTLM::Conversation::Processor::Gemma3 ALIAS runtime_conversation_model_data_processor_gemma3_data_processor)

target_include_directories(runtime_conversation_model_data_processor_gemma3_data_processor
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_conversation_model_data_processor_gemma3_data_processor 
  PUBLIC
    runtime_conversation_io_types
    runtime_engine_io_types
    LiteRTLM::Conversation::Processor::Gemma3Config
    LiteRTLM::Preprocessor::Audio
    LiteRTLM::Preprocessor::AudioMiniAudio
    LiteRTLM::Preprocessor::Image
    LiteRTLM::Preprocessor::StbImage
    LiteRTLM::ToolUse::ParserUtils
    LiteRTLM::ToolUse::PythonFormatUtils
    runtime_util_litert_status_util
    runtime_util_memory_mapped_file
    LiteRTLM::Conversation::Processor::DataUtils  
    LiteRTLM::Conversation::Processor::Interface    
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Generic Data Processor Config ---
add_litertlm_library(runtime_conversation_model_data_processor_generic_data_processor_config INTERFACE)
add_library(LiteRTLM::Conversation::Processor::GenericConfig ALIAS runtime_conversation_model_data_processor_generic_data_processor_config)

target_include_directories(runtime_conversation_model_data_processor_generic_data_processor_config
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Generic Data Processor ---
add_litertlm_library(runtime_conversation_model_data_processor_generic_data_processor STATIC
  generic_data_processor.cc
)
add_library(LiteRTLM::Conversation::Processor::Generic ALIAS runtime_conversation_model_data_processor_generic_data_processor)

target_include_directories(runtime_conversation_model_data_processor_generic_data_processor
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_conversation_model_data_processor_generic_data_processor
  PUBLIC
    LiteRTLM::Conversation::Processor::ConfigRegistry
    LiteRTLM::Conversation::Processor::GenericConfig
    runtime_conversation_io_types
    runtime_engine_io_types
    runtime_util_litert_status_util
    LiteRTLM::Conversation::Processor::Interface
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# --- Qwen3 Data Processor Config ---
add_litertlm_library(runtime_conversation_model_data_processor_qwen3_data_processor_config INTERFACE)
add_library(LiteRTLM::Conversation::Processor::Qwen3Config ALIAS runtime_conversation_model_data_processor_qwen3_data_processor_config)

target_include_directories(runtime_conversation_model_data_processor_qwen3_data_processor_config
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Qwen3 Data Processor ---
add_litertlm_library(runtime_conversation_model_data_processor_qwen3_data_processor STATIC
  qwen3_data_processor.cc
)
add_library(LiteRTLM::Conversation::Processor::Qwen3 ALIAS runtime_conversation_model_data_processor_qwen3_data_processor)

target_include_directories(runtime_conversation_model_data_processor_qwen3_data_processor 
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_conversation_model_data_processor_qwen3_data_processor
  PUBLIC
    LiteRTLM::Conversation::Processor::ConfigRegistry
    LiteRTLM::Conversation::Processor::Interface
    LiteRTLM::Conversation::Processor::Qwen3Config
    LiteRTLM::ToolUse::ParserUtils
    runtime_conversation_io_types
    runtime_engine_io_types
    runtime_util_litert_status_util
  PRIVATE  
    litert_libs
    LITERTLM_DEPS
)

# --- Model Data Processor Factory ---
add_litertlm_library(runtime_conversation_model_data_processor_factory STATIC
  model_data_processor_factory.cc
)
add_library(LiteRTLM::Conversation::Processor::Factory ALIAS runtime_conversation_model_data_processor_factory)

target_include_directories(runtime_conversation_model_data_processor_factory
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_conversation_model_data_processor_factory 
  PUBLIC
    LiteRTLM::Conversation::Processor::ConfigRegistry
    LiteRTLM::Conversation::Processor::Gemma3
    LiteRTLM::Conversation::Processor::Gemma3Config
    LiteRTLM::Conversation::Processor::Generic
    LiteRTLM::Conversation::Processor::GenericConfig
    LiteRTLM::Conversation::Processor::Interface
    LiteRTLM::Conversation::Processor::Qwen3
    LiteRTLM::Conversation::Processor::Qwen3Config
    LiteRTLM::Components::Tokenizer::Interface
    runtime_conversation_io_types
    runtime_util_litert_status_util
  PRIVATE
    proto_lib
    litert_libs
    LITERTLM_DEPS
)

# --- Folder Facade ---
add_library(runtime_conversation_model_data_processor_libs INTERFACE)
add_library(LiteRTLM::Conversation::Processor ALIAS runtime_conversation_model_data_processor_libs)

target_link_libraries(runtime_conversation_model_data_processor_libs INTERFACE
  LiteRTLM::Conversation::Processor::ConfigRegistry
  LiteRTLM::Conversation::Processor::DataUtils
  LiteRTLM::Conversation::Processor::Gemma3
  LiteRTLM::Conversation::Processor::Gemma3Config
  LiteRTLM::Conversation::Processor::Generic
  LiteRTLM::Conversation::Processor::GenericConfig
  LiteRTLM::Conversation::Processor::Interface
  LiteRTLM::Conversation::Processor::Factory
  LiteRTLM::Conversation::Processor::Qwen3
  LiteRTLM::Conversation::Processor::Qwen3Config
)