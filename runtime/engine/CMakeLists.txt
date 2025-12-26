set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Engine Interface ---
add_litertlm_library(runtime_engine_engine_interface INTERFACE)
add_library(LiteRTLM::Engine::Interface ALIAS runtime_engine_engine_interface)

target_include_directories(runtime_engine_engine_interface
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Engine Settings ---
add_litertlm_library(runtime_engine_engine_settings STATIC
  engine_settings.cc
)
add_library(LiteRTLM::Engine::Settings ALIAS runtime_engine_engine_settings)

target_include_directories(runtime_engine_engine_settings 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
  )

target_link_libraries(runtime_engine_engine_settings
  PUBLIC
    LiteRTLM::Runtime::Components::Tokenizer::Interface
    runtime_executor_audio_executor_settings
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_settings
    runtime_util_litert_status_util
    runtime_util_model_type_utils
  PRIVATE
    tflite_extra_libs
    litert_libs
    LITERTLM_DEPS
    proto_lib
)

# --- IO Types ---
add_litertlm_library(runtime_engine_io_types STATIC
  io_types.cc
)
add_library(LiteRTLM::Engine::IoTypes ALIAS runtime_engine_io_types)

target_include_directories(runtime_engine_io_types
  PRIVATE 
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}
)

target_link_libraries(runtime_engine_io_types
  PUBLIC
    LiteRTLM::Runtime::Components::ConstrainedDecoding::Constraint
    runtime_util_litert_status_util
    tflite_extra_libs
    litert_libs
    LITERTLM_DEPS
    proto_lib
)

# --- Engine Lib (The Aggregator) ---
add_litertlm_library(runtime_engine_litert_lm_lib STATIC
  litert_lm_lib.cc
)
add_library(LiteRTLM::Engine::Lib ALIAS runtime_engine_litert_lm_lib)

target_include_directories(runtime_engine_litert_lm_lib
  PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_engine_litert_lm_lib
  PUBLIC
    # Refactored Modules
    LiteRTLM::Runtime::Components
    LiteRTLM::Runtime::Conversation
    LiteRTLM::Core
    LiteRTLM::Engine::Interface # (Self)
    LiteRTLM::Engine::Settings  # (Self)
    LiteRTLM::Engine::IoTypes   # (Self)
    
    # Not yet refactored
    runtime_executor_libs 
    runtime_util_libs
    
  PRIVATE
    tflite_extra_libs
    litert_libs
    LITERTLM_DEPS
)

# --- Shared Flags ---
add_litertlm_library(runtime_engine_shared_flags STATIC
  shared_flags.cc
)
add_library(LiteRTLM::Engine::SharedFlags ALIAS runtime_engine_shared_flags)

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

# --- Advanced Main Executable ---
add_litertlm_executable(runtime_engine_litert_lm_advanced_main
  litert_lm_advanced_main.cc
)

target_link_libraries(runtime_engine_litert_lm_advanced_main
  PUBLIC
    c_engine
    LiteRTLM::Engine::Lib
    LiteRTLM::Engine::SharedFlags
    
    # Group dependencies
    LiteRTLM::Runtime::Components
    LiteRTLM::Runtime::Conversation
    LiteRTLM::Core
    LiteRTLM::Core::Tasks
    runtime_executor_libs
    runtime_util_libs
    runtime_util_litert_status_util
  PRIVATE
    tflite_extra_libs
    litert_libs
    LITERTLM_DEPS
)

# --- Main Executable ---
add_litertlm_executable(runtime_engine_litert_lm_main
  litert_lm_main.cc
)

target_link_libraries(runtime_engine_litert_lm_main
  PUBLIC
    c_engine
    
    # Engine Internal
    LiteRTLM::Engine::Interface
    LiteRTLM::Engine::Settings
    LiteRTLM::Engine::IoTypes
    
    # Modules
    LiteRTLM::Runtime::Components
    LiteRTLM::Runtime::Conversation
    LiteRTLM::Runtime::Conversation::IoTypes
    LiteRTLM::Core
    LiteRTLM::Core::EngineImpl
    LiteRTLM::Core::Tasks
    
    # Pending Refactor
    runtime_executor_libs
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_settings
    runtime_util_libs
    runtime_util_litert_status_util
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- Folder Facade ---
add_library(runtime_engine_libs INTERFACE)
add_library(LiteRTLM::Engine ALIAS runtime_engine_libs)

target_link_libraries(runtime_engine_libs INTERFACE
  LiteRTLM::Engine::Interface
  LiteRTLM::Engine::Settings
  LiteRTLM::Engine::IoTypes
  LiteRTLM::Engine::Lib
  LiteRTLM::Engine::SharedFlags
)