include(ExternalProject)

set(PROTO_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/protobuf)
set(PROTO_INSTALL_PREFIX ${PROTO_EXT_PREFIX}/install)
set(PROTO_CONFIG_CMAKE_FILE "${PROTO_INSTALL_PREFIX}/lib/cmake/protobuf/protobuf-config.cmake")


set(PROTO_SRC_DIR ${PROTO_INSTALL_PREFIX}/src/protobuf_external/src)
set(PROTO_INCLUDE_DIR ${PROTO_INSTALL_PREFIX}/include)
set(PROTO_LIB_DIR ${PROTO_INSTALL_PREFIX}/lib)
set(PROTO_LITE_LIBRARY ${PROTO_INSTALL_PREFIX}/lib/libprotobuf-lite.a)
set(PROTO_BIN_DIR ${PROTO_INSTALL_PREFIX}/bin)

set(PROTO_PROTOC_EXECUTABLE ${PROTO_BIN_DIR}/protoc)
set(protobuf_generate_PROTOC_EXE ${PROTO_BIN_DIR}/protoc)


set(PROTO_FILES
  ${PROJECT_ROOT}/runtime/proto/engine.proto
  ${PROJECT_ROOT}/runtime/proto/llm_metadata.proto
  ${PROJECT_ROOT}/runtime/proto/llm_model_type.proto
  ${PROJECT_ROOT}/runtime/proto/sampler_params.proto
  ${PROJECT_ROOT}/runtime/proto/token.proto
  ${PROJECT_ROOT}/runtime/executor/proto/constrained_decoding_options.proto
  ${PROJECT_ROOT}/runtime/util/external_file.proto
)



if(NOT EXISTS "${PROTO_CONFIG_CMAKE_FILE}")
  message(STATUS "Protobuf not found. Configuring external build...")
  ExternalProject_Add(
    protobuf_external
    DEPENDS 
      absl_external
      googletest_external
    GIT_REPOSITORY
      https://github.com/protocolbuffers/protobuf
    GIT_TAG
      v33.2
    PREFIX
      ${PROTO_EXT_PREFIX}
    CMAKE_ARGS
      -DCMAKE_PREFIX_PATH=${GTEST_INSTALL_PREFIX};${ABSL_INSTALL_PREFIX}
      -DCMAKE_INSTALL_PREFIX=${PROTO_INSTALL_PREFIX}
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
      -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
      -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
      -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
      -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON
      -Dprotobuf_BUILD_TESTS=OFF
      -Dprotobuf_BUILD_LIBPROTOC=ON
      -Dprotobuf_BUILD_PROTOBUF_BINARIES=ON
      -Dprotobuf_LOCAL_DEPENDENCIES_ONLY=ON
      -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
      -DGTest_DIR=${GTEST_INSTALL_PREFIX}/lib/cmake/GTest
      -DProtobuf_DIR=${PROTO_INSTALL_PREFIX}/lib/cmake/Protobuf

    STEP_TARGETS
      verify_install_step
  )
  verify_install(protobuf_external ${PROTO_CONFIG_CMAKE_FILE})

else()
  message(STATUS "Protobuf already installed at: ${PROTO_INSTALL_PREFIX}")
  if(NOT TARGET protobuf_external)
    add_custom_target(protobuf_external)
  endif()
endif()


import_static_lib(imp_protobuf      "${PROTO_LIB_DIR}/libprotobuf.a")
import_static_lib(imp_utf8_validity "${PROTO_LIB_DIR}/libutf8_validity.a")
import_static_lib(imp_utf8_range    "${PROTO_LIB_DIR}/libutf8_range.a")


if(NOT TARGET protobuf::libprotobuf)
    add_library(protobuf::libprotobuf ALIAS imp_protobuf)
endif()

if(NOT TARGET protobuf::protoc)
    add_executable(protobuf::protoc IMPORTED GLOBAL)
    set_target_properties(protobuf::protoc PROPERTIES
        IMPORTED_LOCATION "${PROTO_PROTOC_EXECUTABLE}"
    )
endif()


add_library(proto_lib STATIC)
add_dependencies(proto_lib protobuf_external)

target_include_directories(proto_lib
  PUBLIC
    ${CMAKE_BINARY_DIR}
    ${PROJECT_ROOT}
    ${PROTO_SRC_DIR}
    ${PROTO_INCLUDE_DIR}
    ${ABSL_INCLUDE_DIR}
)

target_link_libraries(proto_lib
  PUBLIC
    protobuf::libprotobuf
  PRIVATE
    imp_absl_base
    # [FIX] Add these so the linker finds the UTF-8 symbols!
    imp_utf8_validity
    imp_utf8_range
)

generate_protobuf(proto_lib)