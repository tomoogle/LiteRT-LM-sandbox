include(ExternalProject)

set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})


set(PROTO_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/protobuf)
set(PROTO_INSTALL_PREFIX ${PROTO_EXT_PREFIX}/install)
set(PROTO_CONFIG_CMAKE_FILE "${PROTO_INSTALL_PREFIX}/lib/cmake/protobuf/protobuf-config.cmake")

set(Protobuf_INCLUDE_DIR ${PROTO_INSTALL_PREFIX}/include)
set(Protobuf_LIBRARIES ${PROTO_INSTALL_PREFIX}/lib/cmake/protobuf)
set(Protobuf_PROTOC_EXECUTABLE ${PROTO_INSTALL_PREFIX}/bin/protoc)
set(Protobuf_LITE_LIBRARY ${PROTO_INSTALL_PREFIX}/lib/libprotobuf-lite.a)



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
      -DCMAKE_CXX_STANDARD=17
      -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
      -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON
      -Dprotobuf_BUILD_TESTS=OFF
      -Dprotobuf_BUILD_LIBPROTOC=ON
      -Dprotobuf_LOCAL_DEPENDENCIES_ONLY=ON
      -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
      -DGTest_DIR=${GTEST_INSTALL_PREFIX}/lib/cmake/GTest

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



# find_package(Protobuf REQUIRED PATHS ${PROTO_INSTALL_PREFIX})
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
