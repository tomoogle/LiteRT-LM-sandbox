if(CMAKE_VERSION VERSION_LESS "3.25")
    message(FATAL_ERROR 
        "CMake 3.25+ is required because we use the 'block()' command for variable isolation.\n"
        "Your current version is: ${CMAKE_VERSION}.\n"
        "Please upgrade CMake to proceed."
    )
endif()
cmake_minimum_required(VERSION 3.25 FATAL_ERROR)
project(LiteRT-LM LANGUAGES C CXX)


# --- Global Paths
set(PROJECT_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

set(LITERTLM_SCRIPTS_DIR        "${PROJECT_ROOT}/cmake/scripts")
set(LITERTLM_MODULES_DIR        "${PROJECT_ROOT}/cmake/modules")
list(APPEND CMAKE_MODULE_PATH   "${LITERTLM_MODULES_DIR}")

set(EXTERNAL_PROJECT_BINARY_DIR "${CMAKE_BINARY_DIR}/external")
set(THIRD_PARTY_DIR             "${CMAKE_BINARY_DIR}/third_party")

set(GENERATED_SRC_DIR           "${PROJECT_ROOT}/cmake/generated/src")

set(LITERTLM_INCLUDE_PATHS      "${GENERATED_SRC_DIR}")


# --- Environment
if(NOT CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 20)
endif()
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include(build_flags)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive" CACHE STRING "Required CXX flags" FORCE)


# --- Optimization
option(ENABLE_CCACHE "Enables the use of ccache" OFF)
if(${ENABLE_CCACHE} STREQUAL "ON")
  find_program(CCACHE_PROGRAM ccache)
  if(CCACHE_PROGRAM)
      message(STATUS "🚀 Using CCache to speed up builds")
      set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
      set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
  else()
      message(WARNING "⚠️ CCache not found. Install it (`sudo apt install ccache`) for faster builds!")
  endif()
endif()


# --- Utilities
include(macros)
include(utils)


# --- Dependencies
include(external_project)
include(fetch_content)

# LITERTLM_INCLUDE_PATHS must be updated before collect_dependencies is called
list(APPEND LITERTLM_INCLUDE_PATHS
  ${OPENCL_HDR_DIR}
  ${ABSL_INCLUDE_DIR}
  ${FLATBUFFERS_INCLUDE_DIR}
  ${GTEST_INCLUDE_DIR}
  ${Protobuf_INCLUDE_DIR}
  ${RE2_INCLUDE_DIR}
  ${SENTENCE_INCLUDE_DIR}
  ${TOKENIZER_INCLUDE_DIR}
  ${LITERT_INCLUDE_PATHS}
  ${FETCHCONTENT_MODULE_SRC_DIRS}
  ${FETCHCONTENT_MODULE_INCLUDE_DIR}
  ${CMAKE_CURRENT_BINARY_DIR}/antlr_generated
)

include(collect_dependencies)


# --- LiteRT-LM Targets
include(setup_generated_src_files)
generate_src_files(ALL_GENERATED_FILES ${ALL_SOURCE_FILES} ${ALL_HEADER_FILES})


add_subdirectory(c)
# add_subdirectory(schema)
# add_subdirectory(runtime)