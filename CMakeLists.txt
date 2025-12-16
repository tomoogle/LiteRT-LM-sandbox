cmake_minimum_required(VERSION 3.22)
project(liteRT-LM LANGUAGES C CXX)

###
#
# [NOTE] Disabled to reduce chance for cache related failures
# [TODO] Add logic to enable with CLI arg
#
# find_program(CCACHE_PROGRAM ccache)
# if(CCACHE_PROGRAM)
#     message(STATUS "🚀 Using CCache to speed up builds")
#     set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
#     set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
# else()
#     message(WARNING "⚠️ CCache not found. Install it (`sudo apt install ccache`) for faster builds!")
# endif()
#
###


set(PROJECT_ROOT ${CMAKE_CURRENT_SOURCE_DIR})
set(_project_root ${CMAKE_SOURCE_DIR}) # [TODO] Remove instances of _project_root in favor of PROJECT_ROOT

set(GENERATED_SRC_DIR "${PROJECT_ROOT}/cmake/src")
set(GEN_C_DIR "${GENERATED_SRC_DIR}/c")
set(GEN_SCHEMA_DIR "${GENERATED_SRC_DIR}/schema")
set(GEN_RUNTIME_DIR "${GENERATED_SRC_DIR}/runtime")


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive" CACHE STRING "Required CXX flags" FORCE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_SHARED_LIBS OFF)

set(EXTERNAL_PROJECTS_DIR ${PROJECT_ROOT}/cmake/external)
set(THIRD_PARTY_DIR "${CMAKE_BINARY_DIR}/third_party")
set(SCRIPTS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/scripts)
include(cmake/scripts/macros.cmake)
include(cmake/scripts/utils.cmake)
include(cmake/scripts/absl.cmake)
include(cmake/scripts/protobuf.cmake)
# include(cmake/scripts/tokenizers.cmake)

# include(cmake/scripts/modules.cmake)
# include(cmake/scripts/litert.cmake)
# include(cmake/scripts/tflite.cmake)
# include(cmake/scripts/flatbuffers.cmake)

###
#
# [NOTE] Was not consistent at finding src
#
# # Sanitize Source
# file(GLOB _all_files
#     CONFIGURE_DEPENDS
#     "${PROJECT_ROOT}/c/*.cc"
#     "${PROJECT_ROOT}/c/*.h"
#     "${PROJECT_ROOT}/runtime/*.cc"
#     "${PROJECT_ROOT}/runtime/*.h"
#     "${PROJECT_ROOT}/schema/*.cc"
#     "${PROJECT_ROOT}/schema/*.h"
# )
#
####


# Generate Source
#
# Using generated source ensures any operations performed
# in CMake does not affect the original files.
#

# file(GLOB_RECURSE C_SRC_FILES "c/*.cc")
# file(GLOB_RECURSE C_HDR_FILES "c/*.h")
# file(GLOB_RECURSE RUNTIME_SRC_FILES "runtime/*.cc")
# file(GLOB_RECURSE RUNTIME_HDR_FILES "runtime/*.h")
# file(GLOB_RECURSE SCHEMA_SRC_FILES "schema/*.cc")
# file(GLOB_RECURSE SCHEMA_HDR_FILES "schema/*.h")

# set(ALL_SOURCE_FILES "")
# set(ALL_HEADER_FILES "")
# list(APPEND ALL_SOURCE_FILES ${C_SRC_FILES} ${RUNTIME_SRC_FILES} ${SCHEMA_SRC_FILES})
# list(APPEND ALL_HEADER_FILES ${C_HDR_FILES} ${RUNTIME_HDR_FILES} ${SCHEMA_HDR_FILES})

# generate_clean_files(ALL_CLEANED_FILES ${ALL_SOURCE_FILES} ${ALL_HEADER_FILES})


# # [TODO] Add to flatbuffers.cmake
# set(schema_fbs
#   "${PROJECT_ROOT}/schema/core/litertlm_header_schema.fbs"
# )
# compile_flatbuffer_files(${schema_fbs})

# set(CMAKE_CXX_STANDARD 20)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
# set(CMAKE_CXX_EXTENSIONS OFF)


# add_subdirectory(runtime)
# add_subdirectory(c)
# add_subdirectory(schema)
