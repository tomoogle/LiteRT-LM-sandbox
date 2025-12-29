include(ExternalProject)

set(SENTENCE_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/sentencepiece)
set(SENTENCE_INSTALL_PREFIX ${SENTENCE_EXT_PREFIX}/install)
set(SENTENCE_INCLUDE_DIR ${SENTENCE_INSTALL_PREFIX}/include)

# Detect lib vs lib64
if(EXISTS "${SENTENCE_INSTALL_PREFIX}/lib64")
  set(SENTENCE_LIB_DIR "${SENTENCE_INSTALL_PREFIX}/lib64")
else()
  set(SENTENCE_LIB_DIR "${SENTENCE_INSTALL_PREFIX}/lib")
endif()

set(SENTENCE_LIBRARY_STATIC "${SENTENCE_LIB_DIR}/libsentencepiece.a")
set(SENTENCE_LIBRARY_TRAIN  "${SENTENCE_LIB_DIR}/libsentencepiece_train.a")

if(NOT EXISTS "${SENTENCE_LIBRARY_STATIC}")
  message(STATUS "SentencePiece not found. Configuring external build...")
  
  ExternalProject_Add(
    sentencepiece_external
    DEPENDS 
      absl_external
      protobuf_external
    GIT_REPOSITORY https://github.com/google/sentencepiece.git
    GIT_TAG        v0.2.1
    PREFIX         ${SENTENCE_EXT_PREFIX}
    
    PATCH_COMMAND
      ${CMAKE_COMMAND} -E remove_directory <SOURCE_DIR>/third_party/abseil-cpp &&
      ${CMAKE_COMMAND} -E remove_directory <SOURCE_DIR>/third_party/protobuf &&
      sed -i "/set(CMAKE_CXX_STANDARD 17)/d" <SOURCE_DIR>/CMakeLists.txt &&
      sed -i "s|add_subdirectory(third_party/abseil-cpp)|find_package(absl REQUIRED CONFIG)|g" <SOURCE_DIR>/CMakeLists.txt &&
      sed -i "s|add_subdirectory(third_party/protobuf)|find_package(Protobuf REQUIRED CONFIG)|g" <SOURCE_DIR>/CMakeLists.txt

    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${SENTENCE_INSTALL_PREFIX}
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5
      
      # Force C++20
      -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
      -DCMAKE_CXX_STANDARD_REQUIRED=ON
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON
      
      # Provider Settings
      -DSPM_ABSL_PROVIDER=package
      -DSPM_PROTOBUF_PROVIDER=package
      -DSPM_ENABLE_SHARED=OFF
      -DSPM_ENABLE_TCMALLOC=OFF
      
      -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl

      -DProtobuf_DIR=${PROTO_INSTALL_PREFIX}/lib/cmake/protobuf
      -DProtobuf_LIBRARIES=${PROTO_LIB_DIR}
      -DProtobuf_INCLUDE_DIR=${PROTO_INCLUDE_DIR}
      -DProtobuf_LIBRARY_DEBUG=${PROTO_LIB_DIR}/libprotobuf.a
      -DProtobuf_LIBRARY_RELEASE=${PROTO_LIB_DIR}/libprotobuf.a
      -DProtobuf_LITE_LIBRARY_DEBUG=${PROTO_LIB_DIR}/libprotobuf-lite.a
      -DProtobuf_LITE_LIBRARY_RELEASE=${PROTO_LIB_DIR}/libprotobuf-lite.a
      -DProtobuf_PROTOC_EXECUTABLE=${PROTO_PROTOC_EXECUTABLE}
      -DProtobuf_PROTOC_LIBRARY_DEBUG=${PROTO_LIB_DIR}/libprotoc.a
      -DProtobuf_PROTOC_LIBRARY_RELEASE=${PROTO_LIB_DIR}/libprotoc.a

  )
else()
  if(NOT TARGET sentencepiece_external)
    add_custom_target(sentencepiece_external)
  endif()
endif()

# Import Libs
import_static_lib(imp_sentencepiece       "${SENTENCE_LIBRARY_STATIC}")
import_static_lib(imp_sentencepiece_train "${SENTENCE_LIBRARY_TRAIN}")

add_library(sentencepiece_libs INTERFACE)
target_include_directories(sentencepiece_libs INTERFACE ${SENTENCE_INCLUDE_DIR})

target_link_libraries(sentencepiece_libs INTERFACE 
    imp_sentencepiece
    imp_sentencepiece_train
    absl_libs 
    proto_lib
)