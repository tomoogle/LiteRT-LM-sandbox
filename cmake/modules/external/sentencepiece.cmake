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

if(NOT EXISTS "${SENTENCE_LIBRARY_STATIC}")
  message(STATUS "SentencePiece not found. Configuring external build...")
  
  ExternalProject_Add(
    sentencepiece_external
    DEPENDS 
      absl_external
      protobuf_external
    GIT_REPOSITORY https://github.com/google/sentencepiece.git
    GIT_TAG        v0.2.0
    PREFIX         ${SENTENCE_EXT_PREFIX}
    
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${SENTENCE_INSTALL_PREFIX}
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
      -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
      
      # [CRITICAL] Force usage of external dependencies
      -DSPM_USE_EXTERNAL_ABSL=ON
      -DSPM_USE_EXTERNAL_PROTOBUF=ON
      -DSPM_ENABLE_SHARED=OFF
      
      # [CRITICAL] Help it find the specific versions we built
      "-DCMAKE_PREFIX_PATH=${ABSL_INSTALL_PREFIX};${PROTO_INSTALL_PREFIX}"
  )
else()
  if(NOT TARGET sentencepiece_external)
    add_custom_target(sentencepiece_external)
  endif()
endif()

# Import the library
import_static_lib(imp_sentencepiece "${SENTENCE_LIBRARY_STATIC}")

add_library(sentencepiece_libs INTERFACE)
target_include_directories(sentencepiece_libs INTERFACE ${SENTENCE_INCLUDE_DIR})
target_link_libraries(sentencepiece_libs INTERFACE 
    imp_sentencepiece
    # It depends on these, so we link them here to be safe
    absl_libs 
    proto_lib
)



# include(ExternalProject)


# set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})


# set(SENTENCE_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/sentencepiece)
# set(SENTENCE_INSTALL_PREFIX ${SENTENCE_EXT_PREFIX}/install)
# set(SENTENCE_INCLUDE_DIR ${SENTENCE_INSTALL_PREFIX}/include)
# set(SENTENCEPIECE_LIB_DIR ${SENTENCE_INSTALL_PREFIX}/lib)
# set(SENTENCE_CONFIG_CMAKE_FILE "${SENTENCE_INSTALL_PREFIX}/lib/cmake/sentence/sentence-config.cmake")


# if(NOT EXISTS "${SENTENCE_CONFIG_CMAKE_FILE}")
#   message(STATUS "Sentencepiece not found. Configuring external build...")
#   ExternalProject_Add(
#     sentencepiece_external
#     GIT_REPOSITORY https://github.com/google/sentencepiece.git
#     GIT_TAG        v0.2.0
#     PREFIX         ${EXTERNAL_PROJECT_BINARY_DIR}/sentencepiece
    
#     DEPENDS 
#       absl_external
#       protobuf_external

#     PATCH_COMMAND
#       # 1. DELETE the hardcoded C++17 requirement
#       # This is the root cause of the "partial_ordering" error. 
#       # It allows your -DCMAKE_CXX_STANDARD=20 to actually take effect.
#       sed -i "/set(CMAKE_CXX_STANDARD 17)/d" <SOURCE_DIR>/CMakeLists.txt &&
      
#       # 2. REMOVE rogue commas from option() calls 
#       # Fixes the syntax error caused by auto-formatters.
#       # Transforms: option(VAR, "Help") -> option(VAR "Help")
#       sed -i "s/option(\\([^,]*\\),/option(\\1/g" <SOURCE_DIR>/CMakeLists.txt &&
      
#       # 3. FORCE external Abseil usage
#       # We replace the internal logic with standard CMake finding
#       sed -i "s|add_subdirectory(third_party/abseil-cpp)|find_package(absl REQUIRED)|g" <SOURCE_DIR>/CMakeLists.txt

#     CMAKE_ARGS
#       -DCMAKE_INSTALL_PREFIX=${EXTERNAL_PROJECT_BINARY_DIR}/sentencepiece/install
#       -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
#       -DCMAKE_POLICY_VERSION_MINIMUM=3.5
      
#       # Force C++20 to match LiteRT/Abseil expectations
#       -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
#       -DCMAKE_CXX_STANDARD_REQUIRED=ON
      
#       # SentencePiece Settings
#       -DSPM_USE_EXTERNAL_ABSL=ON
#       -DSPM_ENABLE_SHARED=OFF
      
#       # Dependency Paths
#       -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
#       -DProtobuf_DIR=${PROTO_PREFIX}/lib/cmake/protobuf
#   )
# # verify_install(sentencepiece_external ${SENTENCE_CONFIG_CMAKE_FILE})

# else()
#   message(STATUS "Sentencepiece already installed at: ${SENTENCE_INSTALL_PREFIX}")
#   if(NOT TARGET sentencepiece_external)
#     add_custom_target(sentencepiece_external)
#   endif()
# endif()


# import_static_lib(imp_sentencepiece              "${SENTENCEPIECE_LIB_DIR}/libsentencepiece.a")
# import_static_lib(imp_sentencepiece_train        "${SENTENCEPIECE_LIB_DIR}/libsentencepiece_train.a")

# add_library(sentencepiece_libs INTERFACE)
# target_link_libraries(sentencepiece_libs INTERFACE
#     imp_sentencepiece
#     imp_sentencepiece_train
# )