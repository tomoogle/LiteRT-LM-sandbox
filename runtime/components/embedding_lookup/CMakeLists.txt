set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Interface ---
add_litertlm_library(runtime_components_embedding_lookup_embedding_lookup INTERFACE)
add_library(LiteRTLM::Runtime::Components::EmbeddingLookup::Interface ALIAS runtime_components_embedding_lookup_embedding_lookup)

target_include_directories(runtime_components_embedding_lookup_embedding_lookup
  INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

# --- End of Multi Modal ---
add_litertlm_library(runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal STATIC
  embedding_lookup_end_of_multi_modal.cc
)
add_library(LiteRTLM::Runtime::Components::EmbeddingLookup::EndOfMultiModal ALIAS runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal)

target_include_directories(runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal 
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal
  PUBLIC
    LiteRTLM::Runtime::Components::EmbeddingLookup::Interface
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Manager ---
add_litertlm_library(runtime_components_embedding_lookup_embedding_lookup_manager STATIC
  embedding_lookup_manager.cc
)
add_library(LiteRTLM::Runtime::Components::EmbeddingLookup::Manager ALIAS runtime_components_embedding_lookup_embedding_lookup_manager)

target_include_directories(runtime_components_embedding_lookup_embedding_lookup_manager 
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
  )

target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_manager
  PUBLIC
    runtime_executor_llm_executor_io_types
    LiteRTLM::Runtime::Components::EmbeddingLookup::EndOfMultiModal
    LiteRTLM::Runtime::Components::EmbeddingLookup::MultiModal
    LiteRTLM::Runtime::Components::EmbeddingLookup::Text
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Multi Modal ---
add_litertlm_library(runtime_components_embedding_lookup_embedding_lookup_multi_modal STATIC
  embedding_lookup_multi_modal.cc
)
add_library(LiteRTLM::Runtime::Components::EmbeddingLookup::MultiModal ALIAS runtime_components_embedding_lookup_embedding_lookup_multi_modal)

target_include_directories(runtime_components_embedding_lookup_embedding_lookup_multi_modal
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_multi_modal
  PUBLIC
    LiteRTLM::Runtime::Components::EmbeddingLookup::Interface
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Text ---
add_litertlm_library(runtime_components_embedding_lookup_embedding_lookup_text STATIC
  embedding_lookup_text.cc
)
add_library(LiteRTLM::Runtime::Components::EmbeddingLookup::Text ALIAS runtime_components_embedding_lookup_embedding_lookup_text)

target_include_directories(runtime_components_embedding_lookup_embedding_lookup_text 
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
  )

target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_text
  PUBLIC
    LiteRTLM::Runtime::Components::EmbeddingLookup::Interface
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Facade ---
add_library(runtime_components_embedding_lookup_libs INTERFACE)
add_library(LiteRTLM::Runtime::Components::EmbeddingLookup ALIAS runtime_components_embedding_lookup_libs)

target_link_libraries(runtime_components_embedding_lookup_libs INTERFACE
  LiteRTLM::Runtime::Components::EmbeddingLookup::EndOfMultiModal
  LiteRTLM::Runtime::Components::EmbeddingLookup::Manager
  LiteRTLM::Runtime::Components::EmbeddingLookup::MultiModal
  LiteRTLM::Runtime::Components::EmbeddingLookup::Text
)