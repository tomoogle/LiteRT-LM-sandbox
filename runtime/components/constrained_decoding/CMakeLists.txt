set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})



add_litert_interface_library(runtime_components_constrained_decoding_bitmap)
target_include_directories(runtime_components_constrained_decoding_bitmap
  INTERFACE 
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
)

add_litert_static_library(runtime_components_constrained_decoding_constrained_decoder
  constrained_decoder.cc
)
target_include_directories(runtime_components_constrained_decoding_constrained_decoder
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
  )
target_link_libraries(runtime_components_constrained_decoding_constrained_decoder
  PUBLIC
    runtime_components_constrained_decoding_constraint
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

add_litert_interface_library(runtime_components_constrained_decoding_constraint)
target_include_directories(runtime_components_constrained_decoding_constraint
  INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
  )

add_litert_interface_library(runtime_components_constrained_decoding_constraint_provider)
target_include_directories(runtime_components_constrained_decoding_constraint_provider
  INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

add_litert_static_library(runtime_components_constrained_decoding_fake_constraint
  fake_constraint.cc
)
target_include_directories(runtime_components_constrained_decoding_fake_constraint
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)
target_link_libraries(runtime_components_constrained_decoding_fake_constraint
  PUBLIC
    runtime_components_constrained_decoding_bitmap
    runtime_components_constrained_decoding_constraint 
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)



add_library(runtime_components_constrained_decoding_libs INTERFACE)
target_link_libraries(runtime_components_constrained_decoding_libs INTERFACE
  runtime_components_constrained_decoding_bitmap
  runtime_components_constrained_decoding_constrained_decoder  
  runtime_components_constrained_decoding_constraint
  runtime_components_constrained_decoding_constraint_provider
  runtime_components_constrained_decoding_fake_constraint
)