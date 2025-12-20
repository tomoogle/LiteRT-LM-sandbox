set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Subdirectories ---
add_subdirectory(model_data_processor)

# --- Conversation ---
add_litertlm_library(runtime_conversation_conversation STATIC
  conversation.cc
)
add_library(LiteRTLM::Conversation::Conversation ALIAS runtime_conversation_conversation)

target_include_directories(runtime_conversation_conversation
  PUBLIC
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_conversation_conversation
  PUBLIC
    # Local Dependencies
    LiteRTLM::Conversation::InternalCallbackUtil # (Defined below)
    LiteRTLM::Conversation::IoTypes # (Defined below)
    LiteRTLM::Conversation::Processor::ConfigRegistry
    LiteRTLM::Conversation::Processor::Factory
    LiteRTLM::Conversation::Processor::Interface

    # Cross-Module Dependencies
    LiteRTLM::Components::PromptTemplate
    LiteRTLM::ConstrainedDecoding::Constraint
    # runtime_engine_engine_interface (Likely defined in runtime/engine)
    # runtime_engine_engine_settings (Likely defined in runtime/engine)
    # runtime_engine_io_types (Likely defined in runtime/engine)
    runtime_util_litert_status_util

  PRIVATE
    proto_lib
    LITERTLM_DEPS
    litert_libs
)

# --- Internal Callback Util ---
add_litertlm_library(runtime_conversation_internal_callback_util STATIC
  internal_callback_util.cc
)
add_library(LiteRTLM::Conversation::InternalCallbackUtil ALIAS runtime_conversation_internal_callback_util)

target_include_directories(runtime_conversation_internal_callback_util
  PUBLIC
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_conversation_internal_callback_util
  PUBLIC
    LiteRTLM::Conversation::IoTypes # (Defined below)
    LiteRTLM::Conversation::Processor::ConfigRegistry
    LiteRTLM::Conversation::Processor::Interface
    # runtime_engine_io_types (Likely defined in runtime/engine)
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- IO Types ---
add_litertlm_library(runtime_conversation_io_types STATIC
  io_types.cc
)
add_library(LiteRTLM::Conversation::IoTypes ALIAS runtime_conversation_io_types)

target_include_directories(runtime_conversation_io_types
  PUBLIC
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_conversation_io_types
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

# --- Folder Facade ---
add_library(runtime_conversation_libs INTERFACE)
add_library(LiteRTLM::Conversation ALIAS runtime_conversation_libs)

target_link_libraries(runtime_conversation_libs INTERFACE
  LiteRTLM::Conversation::Conversation
  LiteRTLM::Conversation::InternalCallbackUtil
  LiteRTLM::Conversation::IoTypes
  LiteRTLM::Conversation::Processor
)