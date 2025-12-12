set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

find_package(Protobuf REQUIRED)


set(PROTO_FILES
  ${PKG_ROOT}/runtime/proto/engine.proto
  ${PKG_ROOT}/runtime/proto/llm_metadata.proto
  ${PKG_ROOT}/runtime/proto/llm_model_type.proto
  ${PKG_ROOT}/runtime/proto/sampler_params.proto
  ${PKG_ROOT}/runtime/proto/token.proto
  ${PKG_ROOT}/runtime/executor/proto/constrained_decoding_options.proto
  ${PKG_ROOT}/runtime/util/external_file.proto
)

add_library(proto_lib STATIC ${PROTO_FILES})
target_include_directories(proto_lib PUBLIC "${CMAKE_BINARY_DIR}")
target_link_libraries(proto_lib PUBLIC protobuf::libprotobuf)
protobuf_generate(
    TARGET proto_lib
    LANGUAGE cpp
    IMPORT_DIRS ${CMAKE_CURRENT_SOURCE_DIR}
    PROTOS ${PROTO_FILES}
)
