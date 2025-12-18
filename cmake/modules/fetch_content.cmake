include(FetchContent)


# set(ABSL_SRC_DIR ${THIRD_PARTY_DIR}/absl)
# FetchContent_Declare(
#   absl_lib
#   GIT_REPOSITORY https://github.com/abseil/abseil-cpp
#   GIT_TAG master
#   GIT_SHALLOW true
#   SOURCE_DIR ${ABSL_SRC_DIR}
# )
# FetchContent_Populate(absl_lib)
# block()
#   set(ABSL_ENABLE_INSTALL OFF)
#   set(ABSL_BUILD_TESTING OFF)
#   set(ABSL_USE_GOOGLETEST_HEAD OFF)
#   set(ABSL_PROPAGATE_CXX_STD ON)
#   FetchContent_MakeAvailable(absl_lib)
# endblock()


# FetchContent_Declare(
#     antlr4_tool
#     URL "https://www.antlr.org/download/antlr-4.13.1-complete.jar"
# )
# FetchContent_MakeAvailable(antlr4_tool)

# set(ANTLR_TOOL_JAR 
#     "${antlr4_tool_SOURCE_DIR}/antlr-4.13.1-complete.jar"
# )




set(ANTLR_SRC_DIR, ${THIRD_PARTY_DIR}/antlr)
FetchContent_Declare(
  antlr_lib
  GIT_REPOSITORY https://github.com/antlr/antlr4.git
  # GIT_TAG faa457ae5b9c39b572334814f0b36c855bc23010
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_SUBDIR runtime/Cpp

)
block()
  set(CMAKE_POLICY_VERSION_MINIMUM "3.5")
  set(ANTLR_BUILD_STATIC)
  FetchContent_MakeAvailable(antlr_lib)
endblock()


# set(GTEST_SRC_DIR, ${THIRD_PARTY_DIR}/gtest)
# FetchContent_Declare(
#   gtest_lib
#   GIT_REPOSITORY https://github.com/google/googletest
#   GIT_TAG main
#   GIT_SHALLOW true
#   SOURCE_DIR ${GTEST_SRC_DIR}
# )
# FetchContent_MakeAvailable(gtest_lib)

set(KISSFFT_SRC_DIR ${THIRD_PARTY_DIR}/kissfft)
FetchContent_Declare(
  kissfft_lib
  GIT_REPOSITORY https://github.com/mborgerding/kissfft
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_DIR ${KISSFFT_SRC_DIR}
)
block()
  cmake_policy(SET CMP0077 OLD)
  set(KISSFFT_TEST OFF)
  set(KISSFFT_TOOLS OFF)
  FetchContent_MakeAvailable(kissfft_lib)
endblock()


set(MINIAUDIO_SRC_DIR ${THIRD_PARTY_DIR}/miniaudio)
FetchContent_Declare(
  miniaudio_lib
  GIT_REPOSITORY https://github.com/mackron/miniaudio
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_DIR ${MINIAUDIO_SRC_DIR}
)
FetchContent_MakeAvailable(miniaudio_lib)


set(MINIZIP_SRC_DIR ${THIRD_PARTY_DIR}/minizip)
FetchContent_Declare(
  minizip_lib
  GIT_REPOSITORY https://github.com/domoticz/minizip
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_DIR ${MINIZIP_SRC_DIR}
)
  FetchContent_MakeAvailable(minizip_lib)


set(MINJA_SRC_DIR ${THIRD_PARTY_DIR}/minja)
FetchContent_Declare(
  minja_lib
  GIT_REPOSITORY https://github.com/google/minja
  GIT_TAG main
  GIT_SHALLOW true
  SOURCE_DIR ${MINJA_SRC_DIR}
)
  set(MINJA_TEST_ENABLED OFF)
  FetchContent_MakeAvailable(minja_lib)



set(JSON_SRC_DIR ${THIRD_PARTY_DIR}/json)
FetchContent_Declare(
  json_lib
  GIT_REPOSITORY https://github.com/nlohmann/json
  GIT_TAG v3.12.0
  GIT_SHALLOW true
  SOURCE_DIR ${JSON_SRC_DIR}
)
FetchContent_Populate(json_lib)


# set(RE2_SRC_DIR ${THIRD_PARTY_DIR}/re2)
# FetchContent_Declare(
#   _re2_lib
#   GIT_REPOSITORY https://github.com/google/re2
#   GIT_TAG main
#   GIT_SHALLOW true
#   SOURCE_DIR ${RE2_SRC_DIR}
# )
# FetchContent_Populate(_re2_lib)


# set(SENTENCEPIECE_SRC_DIR ${THIRD_PARTY_DIR}/sentencepiece)
# FetchContent_Declare(
#   sentencepiece_lib
#   GIT_REPOSITORY https://github.com/google/sentencepiece
#   GIT_TAG master
#   GIT_SHALLOW true
#   SOURCE_DIR ${SENTENCEPIECE_SRC_DIR}
# )
# set(SPM_USE_BUILTIN_PROTOBUF "off" CACHE STRING "Provider of protobuf library")
# set(SPM_ABSL_PROVIDER "package" CACHE STRING "Provider of absl library")
# # set(SPM_USE_EXTERNAL_ABSL ON CACHE BOOL "Use external Abseil" FORCE)
# # file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/external/tokenizers-cpp/sentencepiece//third_party/abseil-cpp")

# # set(CMAKE_DISABLE_FIND_PACKAGE_absl ON)
# FetchContent_Populate(sentencepiece_lib)

set(STB_SRC_DIR ${THIRD_PARTY_DIR}/stb_lib)
FetchContent_Declare(
  stb_lib
  GIT_REPOSITORY https://github.com/nothings/stb.git
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_DIR ${STB_SRC_DIR}
)
FetchContent_Populate(stb_lib)


# set(TOKENIZERS_SRC_DIR ${THIRD_PARTY_DIR}/tokenizers-cpp)
# FetchContent_Declare(
#   tokenizers_cpp_lib
#   GIT_REPOSITORY https://github.com/mlc-ai/tokenizers-cpp
#   GIT_TAG main
#   GIT_SHALLOW true
#   SOURCE_DIR ${TOKENIZERS_SRC_DIR}
# )
# block()
#   set(CMAKE_POLICY_VERSION_MINIMUM "3.5")
#   FetchContent_MakeAvailable(tokenizers_cpp_lib)
# endblock()

set(ZLIB_SRC_DIR ${THIRD_PARTY_DIR}/zlib)
FetchContent_Declare(
  zlib_lib
  GIT_REPOSITORY https://github.com/madler/zlib
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_DIR ${ZLIB_SRC_DIR}
)
block()
  set(BUILD_SHARED_LIBS OFF)
  FetchContent_MakeAvailable(zlib_lib)
endblock()


# set(LITERTLM_DEPS
#   kissfft_lib
#   miniaudio_lib
#   minizip_lib
#   minja_lib
#   gtest_lib
#   json_lib
#   # external::sentencepiece
#   # external::tokenizers_cpp
#   zlib_lib
# )



# _collect_dependency_includes(${LITERTLM_DEPS} LITERTLM_INCLUDE_PATHS)

# set(LITERTLM_INCLUDE_PATHS ${LITERTLM_INCLUDE_PATHS})
# list(APPEND LITERTLM_INCLUDE_PATHS
#   ${PROJECT_ROOT}/cmake/src
#   ${THIRD_PARTY_DIR}
#   ${THIRD_PARTY_DIR}/litert/src/litert_external
#   ${THIRD_PARTY_DIR}/litert/src/litert_external-build/include
#   ${THIRD_PARTY_DIR}/external/absl
#   ${PROJECT_ROOT}/cmake/build/external/json
# )


set(_LITERT_SRC_DIR "${CMAKE_BINARY_DIR}/litert/src/litert_external")
set(_LITERT_BUILD_CONFIG "${CMAKE_BINARY_DIR}/litert/src/litert_external-build/include")
set(_LITERT_ABSL_SRC_DIR "${CMAKE_BINARY_DIR}/litert/src/litert_external-build/abseil-cpp")


set(THIRD_PARTY_SOURCE_DIR
  # ${ABSL_SRC_DIR}
  ${ANTRL_SRC_DIR}
  ${KISSFFT_SRC_DIR}
  ${MINIAUDIO_SRC_DIR}
  ${MINIZIP_SRC_DIR}
  ${MINJA_SRC_DIR}
  ${JSON_SRC_DIR}
  # ${RE2_SRC_DIR}
  # ${SENTENCEPIECE_SRC_DIR}
  ${STB_SRC_DIR}
  # ${TOKENIZERS_SRC_DIR}/sentencepiece
  ${ZLIB_SRC_DIR}
)

set(THIRD_PARTY_INCLUDE_DIR
  ${CMAKE_BINARY_DIR}/_deps/antlr_lib-src/runtime/Cpp/runtime/src
  ${MINIZIP_SRC_DIR}/minizip
  ${MINJA_SRC_DIR}/include
  ${JSON_SRC_DIR}/include
  # ${RE2_SRC_DIR}/re2
  # ${TOKENIZERS_SRC_DIR}/sentencepiece/src
  ${STB_SRC_DIR}/stb_lib
  # ${TOKENIZERS_SRC_DIR}/include
  ${ZLIB_SRC_DIR}
)

set(LITERTLM_INCLUDE_PATHS
  ${GENERATED_SRC_DIR}
  ${THIRD_PARTY_DIR}
  ${_LITERT_SRC_DIR}
  ${_LITERT_BUILD_CONFIG}
  ${_LITERT_ABSL_SRC_DIR}
  ${THIRD_PARTY_SOURCE_DIR}
  ${THIRD_PARTY_INCLUDE_DIR}
  ${CMAKE_CURRENT_BINARY_DIR}/antlr_generated
)



# set(re2_exclude
#   "${RE2_SRC_DIR}/re2/testing/"
#   "${RE2_SRC_DIR}/re2/fuzzing/"
# )


# file(GLOB RE2_SRC 
#   ${RE2_SRC_DIR}/re2/*.cc
#   ${RE2_SRC_DIR}/util/*.cc
# )
# add_library(re2_lib ${RE2_SRC})
# target_include_directories(re2_lib
#   PRIVATE
#   ${LITERTLM_INCLUDE_PATHS}
# )



# add_library(absl_libs INTERFACE)
# target_link_libraries(absl_libs INTERFACE
#     absl::base
#     absl::check
#     absl::flags
#     absl::flags_commandlineflag
#     absl::flags_internal
#     absl::flat_hash_map
#     absl::log
#     absl::log_internal_message
#     absl::log_initialize
#     absl::log_internal_check_op
#     absl::log_internal_format
#     absl::log_internal_globals
#     absl::log_internal_message
#     absl::log_sink
#     absl::random_random
#     absl::status
#     absl::statusor
#     absl::strings
#     absl::str_format
#     absl::span
#     absl::synchronization
# )




add_library(LITERTLM_DEPS INTERFACE)
target_link_libraries(LITERTLM_DEPS INTERFACE
  # absl_libs
  kissfft::kissfft
  miniaudio
  minizip
  minja
  # gtest
  zlibstatic
  # sentencepiece-static
  # tokenizers_cpp
  # proto_lib
  # re2_lib
)



