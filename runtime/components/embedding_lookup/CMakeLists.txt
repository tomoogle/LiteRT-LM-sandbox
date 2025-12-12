set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_library(runtime_components_embedding_lookup_embedding_lookup INTERFACE)
target_include_directories(runtime_components_embedding_lookup_embedding_lookup
  INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

add_library(runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal STATIC
  embedding_lookup_end_of_multi_modal.cc
)
target_include_directories(runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal 
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)
target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal
  PUBLIC
    runtime_components_embedding_lookup_embedding_lookup
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

add_library(runtime_components_embedding_lookup_embedding_lookup_manager STATIC
  embedding_lookup_manager.cc
)
target_include_directories(runtime_components_embedding_lookup_embedding_lookup_manager 
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
  )
target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_manager
  PUBLIC
    runtime_executor_llm_executor_io_types
    runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal
    runtime_components_embedding_lookup_embedding_lookup_multi_modal
    runtime_components_embedding_lookup_embedding_lookup_text
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

add_library(runtime_components_embedding_lookup_embedding_lookup_multi_modal
  STATIC
    embedding_lookup_multi_modal.cc
)
target_include_directories(runtime_components_embedding_lookup_embedding_lookup_multi_modal
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)
target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_multi_modal
  PUBLIC
    runtime_components_embedding_lookup_embedding_lookup
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

add_library(runtime_components_embedding_lookup_embedding_lookup_text
  STATIC
    embedding_lookup_text.cc
)
target_include_directories(runtime_components_embedding_lookup_embedding_lookup_text PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
  )
target_link_libraries(runtime_components_embedding_lookup_embedding_lookup_text
  PUBLIC
    runtime_components_embedding_lookup_embedding_lookup
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

add_library(runtime_components_embedding_lookup_libs INTERFACE)
target_link_libraries(runtime_components_embedding_lookup_libs INTERFACE
  runtime_components_embedding_lookup_embedding_lookup_end_of_multi_modal
  runtime_components_embedding_lookup_embedding_lookup_manager
  runtime_components_embedding_lookup_embedding_lookup_multi_modal
  runtime_components_embedding_lookup_embedding_lookup_text
)