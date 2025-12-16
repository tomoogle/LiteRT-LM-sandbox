include(ExternalProject)
include(FetchContent)

set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

ExternalProject_Add(
    protobuf_external
    GIT_REPOSITORY      https://github.com/protocolbuffers/protobuf
    GIT_TAG             v33.2
    PREFIX              ${EXTERNAL_PROJECTS_DIR}/protobuf
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
        -DCMAKE_CXX_STANDARD=17
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -Dabsl_DIR=${EXTERNAL_PROJECTS_DIR}/abseil/install
        -Dprotobuf_LOCAL_DEPENDENCIES_ONLY=ON
        -Dprotobuf_BUILD_TESTS=OFF
        -Dabsl_DIR=${EXTERNAL_PROJECTS_DIR}/abseil-cpp/install/lib/cmake/absl
)


ExternalProject_Get_Property(protobuf_external INSTALL_DIR BINARY_DIR)
set(PROTOBUF_INSTALL_DIR ${INSTALL_DIR})

# find_package(Protobuf REQUIRED)
# set(PROTO_FILES
#   ${PKG_ROOT}/runtime/proto/engine.proto
#   ${PKG_ROOT}/runtime/proto/llm_metadata.proto
#   ${PKG_ROOT}/runtime/proto/llm_model_type.proto
#   ${PKG_ROOT}/runtime/proto/sampler_params.proto
#   ${PKG_ROOT}/runtime/proto/token.proto
#   ${PKG_ROOT}/runtime/executor/proto/constrained_decoding_options.proto
#   ${PKG_ROOT}/runtime/util/external_file.proto
# )

# add_library(proto_lib STATIC ${PROTO_FILES})
# target_include_directories(proto_lib PUBLIC "${CMAKE_BINARY_DIR}")
# target_link_libraries(proto_lib PUBLIC protobuf::libprotobuf)
# protobuf_generate(
#     TARGET proto_lib
#     LANGUAGE cpp
#     IMPORT_DIRS ${CMAKE_CURRENT_SOURCE_DIR}
#     PROTOS ${PROTO_FILES}
# )
