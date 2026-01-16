include(ExternalProject)


set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})


set(TOKENIZER_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/tokenizers-cpp)
set(TOKENIZER_SRC_DIR ${TOKENIZER_EXT_PREFIX}/src/tokenizers-cpp_external)
set(TOKENIZER_BUILD_DIR ${TOKENIZER_EXT_PREFIX}/src/tokenizers-cpp_external-build) 
set(TOKENIZER_INSTALL_PREFIX ${TOKENIZER_EXT_PREFIX}/install)
set(TOKENIZER_INCLUDE_DIR 
  ${TOKENIZER_INSTALL_PREFIX}/include
  ${TOKENIZER_SRC_DIR}
)

set(TOKENIZER_LIB_CHECK "${TOKENIZER_BUILD_DIR}/libtokenizers_cpp.a")

if(NOT EXISTS "${TOKENIZER_LIB_CHECK}") 
  message(STATUS "tokenizers-cpp not found. Configuring external build...")
  ExternalProject_Add(
    tokenizers-cpp_external
    DEPENDS 
      absl_external
      protobuf_external
      gtest_external
      sentencepiece_external
    GIT_REPOSITORY
        https://github.com/mlc-ai/tokenizers-cpp
    GIT_TAG
        main
    PREFIX
        ${TOKENIZER_EXT_PREFIX}
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E env 
      "LDFLAGS=-L${ABSL_INSTALL_PREFIX}/lib -L${PROTO_INSTALL_PREFIX}/lib"
      "CXXFLAGS=-I${ABSL_INSTALL_PREFIX}/include -I${PROTO_INSTALL_PREFIX}/include"
      ${CMAKE_COMMAND} -S <SOURCE_DIR> -B <BINARY_DIR>
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
        -DCMAKE_INSTALL_PREFIX=${TOKENIZER_INSTALL_PREFIX}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
        -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        "-DCMAKE_PREFIX_PATH=${ABSL_INSTALL_PREFIX};${PROTO_INSTALL_PREFIX};${SENTENCE_INSTALL_PREFIX}"
  )

else()
    message(STATUS "tokenizers-cpp already installed at: ${TOKENIZER_INSTALL_PREFIX}")
    if(NOT TARGET tokenizers-cpp_external)
        add_custom_target(tokenizers-cpp_external)
    endif()
endif()


import_static_lib(imp_tokenizers_c              "${TOKENIZER_BUILD_DIR}/libtokenizers_c.a")
import_static_lib(imp_tokenizers_cpp              "${TOKENIZER_BUILD_DIR}/libtokenizers_cpp.a")


add_library(tokenizers_lib INTERFACE)
target_include_directories(tokenizers_lib INTERFACE ${TOKENIZER_INCLUDE_DIR})

target_link_libraries(tokenizers_lib INTERFACE
  imp_tokenizers_c
  imp_tokenizers_cpp
  sentencepiece_libs 
  absl_libs
)
