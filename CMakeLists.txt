cmake_minimum_required(VERSION 3.20 FATAL_ERROR)
project(LiteRT-LM LANGUAGES C CXX)


# --- Paths
set(PROJECT_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

set(GENERATED_SRC_DIR    "${PROJECT_ROOT}/cmake/src")
set(LITERTLM_SCRIPTS_DIR "${PROJECT_ROOT}/cmake/scripts")
set(LITERTLM_MODULES_DIR "${PROJECT_ROOT}/cmake/modules")
list(APPEND CMAKE_MODULE_PATH "${LITERTLM_MODULES_DIR}")

set(EXTERNAL_PROJECT_BINARY_DIR "${CMAKE_BINARY_DIR}/external")
set(THIRD_PARTY_DIR             "${CMAKE_BINARY_DIR}/third_party")


# --- Environment
set(CMAKE_CXX_STANDARD 17)
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


# --- Targets
include(generated_files_setup)
generate_clean_files(ALL_CLEANED_FILES ${ALL_SOURCE_FILES} ${ALL_HEADER_FILES})

# set(schema_fbs
#   "${PROJECT_ROOT}/schema/core/litertlm_header_schema.fbs"
# )
# compile_flatbuffer_files(${schema_fbs})

# add_subdirectory(runtime)
# add_subdirectory(c)
# add_subdirectory(schema)
