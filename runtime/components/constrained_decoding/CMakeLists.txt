set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Embedding Lookup Interface ---
add_litertlm_library(runtime_components_embedding_lookup_embedding_lookup INTERFACE)
add_library(LiteRTLM::EmbeddingLookup::Interface ALIAS runtime_components_embedding_lookup_embedding_lookup)

target_include_directories(runtime_components_embedding_lookup_embedding_lookup
  INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
)

target_link_libraries(runtime_components_embedding_lookup_embedding_lookup
  INTERFACE
    litert_libs
    LITERTLM_DEPS # For absl::status, absl::span
)

# --- Embedding Lookup Text ---
add_litertlm_library(runtime_components_embedding_lookup_embedding_lookup_text STATIC
  embedding_lookup_text.cc
)
add_library(LiteRTLM::EmbeddingLookup::Text ALIAS runtime_components_embedding_lookup_embedding_lookup_text)

target_include_directories(runtime_components_embedding_lookup_embedding_lookup_text
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_text
  PUBLIC
    LiteRTLM::EmbeddingLookup::Interface
    runtime_util_litert_status_util
  PRIVATE
    litert_libs # Covers litert_common, litert_model, etc.
    LITERTLM_DEPS # Covers absl::log, absl::strings
)

# --- Embedding Lookup Multi-Modal ---
add_litertlm_library(runtime_components_embedding_lookup_embedding_lookup_multi_modal STATIC
  embedding_lookup_multi_modal.cc
)
add_library(LiteRTLM::EmbeddingLookup::MultiModal ALIAS runtime_components_embedding_lookup_embedding_lookup_multi_modal)

target_include_directories(runtime_components_embedding_lookup_embedding_lookup_multi_modal
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_multi_modal
  PUBLIC
    LiteRTLM::EmbeddingLookup::Interface
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
  PRIVATE
    litert_libs # Covers tflite::framework, builtin_ops
    LITERTLM_DEPS
)

# --- Embedding Lookup End-of-Multi-Modal ---
add_litertlm_library(runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal STATIC
  embedding_lookup_end_of_multi_modal.cc
)
add_library(LiteRTLM::EmbeddingLookup::EndOfMultiModal ALIAS runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal)

target_include_directories(runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal
  PUBLIC
    LiteRTLM::EmbeddingLookup::Interface
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- Embedding Lookup Manager ---
add_litertlm_library(runtime_components_embedding_lookup_embedding_lookup_manager STATIC
  embedding_lookup_manager.cc
)
add_library(LiteRTLM::EmbeddingLookup::Manager ALIAS runtime_components_embedding_lookup_embedding_lookup_manager)

target_include_directories(runtime_components_embedding_lookup_embedding_lookup_manager
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_manager
  PUBLIC
    LiteRTLM::EmbeddingLookup::EndOfMultiModal
    LiteRTLM::EmbeddingLookup::MultiModal
    LiteRTLM::EmbeddingLookup::Text
    runtime_executor_llm_executor_io_types
    runtime_util_litert_status_util
    runtime_engine_io_types
  PRIVATE
    #runtime_conversation_model_data_processor_gemma3_data_processor # (Uncomment if target exists/needed)
    #runtime_conversation_model_data_processor_gemma3_data_processor_config # (Uncomment if target exists/needed)
    runtime_util_test_utils
    litert_libs
    LITERTLM_DEPS
)

# --- Folder Facade ---
add_library(runtime_components_embedding_lookup_libs INTERFACE)
add_library(LiteRTLM::EmbeddingLookup ALIAS runtime_components_embedding_lookup_libs)

target_link_libraries(runtime_components_embedding_lookup_libs INTERFACE
  LiteRTLM::EmbeddingLookup::Interface
  LiteRTLM::EmbeddingLookup::Text
  LiteRTLM::EmbeddingLookup::MultiModal
  LiteRTLM::EmbeddingLookup::EndOfMultiModal
  LiteRTLM::EmbeddingLookup::Manager
)