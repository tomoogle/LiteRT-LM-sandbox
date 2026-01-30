# Copyright 2026 Google LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if(CMAKE_VERSION VERSION_LESS "3.25")
    message(FATAL_ERROR 
        "CMake 3.25+ is required because we use the 'block()' command for variable isolation.\n"
        "Your current version is: ${CMAKE_VERSION}.\n"
        "Please upgrade CMake to proceed."
    )
endif()


string(TIMESTAMP FAIL_TIME "%Y%m%d_%H%M%S")
set(FAIL_SNAPSHOT_DIR "${PROJECT_ROOT}/debug_fails/build_at_${FAIL_TIME}")


option(LITERTLM_DEBUG_BUILD_SYSTEM "Enable verbose build system debugging" OFF)
if(LITERTLM_DEBUG_BUILD_SYSTEM)
    if(EXISTS CMAKE_BINARY_DIR)
        add_custom_target(backup_build
            COMMAND ${CMAKE_COMMAND} -E make_directory "${FAIL_SNAPSHOT_DIR}"
            COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_BINARY_DIR}" "${FAIL_SNAPSHOT_DIR}"
            COMMENT "📸 Backing up current (likely broken) build state to ${FAIL_SNAPSHOT_DIR}"
            VERBATIM
        )
    endif()
endif()


cmake_minimum_required(VERSION 3.25 FATAL_ERROR)
project(LiteRT-LM LANGUAGES C CXX)


# --- Global Paths
set(PROJECT_ROOT ${CMAKE_CURRENT_SOURCE_DIR})



# [TODO] Refactor to namespaced CACHE vars
#   1. Update all instances of OLD GLOBAL PATHS
#   2. Delete OLD GLOBAL PATHS
#
### [START] NEW GLOBAL PATHS ###
set(LITERTLM_ROOT_DIR "${PROJECT_ROOT}" CACHE PATH "LiteRT-LM: Root of the LiteRT-LM workspace")

set(LITERTLM_PACKAGES_DIR "${LITERTLM_ROOT_DIR}/cmake/packages" CACHE PATH "LiteRT-LM: Directory for build packages")
include("${LITERTLM_PACKAGES_DIR}/packages.cmake")


set(LITERTLM_PATCHES_DIR "${LITERTLM_ROOT_DIR}/cmake/patches" 
    CACHE PATH "LiteRT-LM: Directory for build patches")

# set(LITERTLM_SHIMS_DIR "${LITERTLM_PATCHES_DIR}/shims" 
    # CACHE PATH "LiteRT-LM: Directory for virtualization shims")

set(LITERTLM_MODULES_DIR "${LITERTLM_ROOT_DIR}/cmake/modules" 
    CACHE PATH "LiteRT-LM: Modules path, appended to CMAKE_MODULE_PATH")

set(LITERTLM_SCRIPTS_DIR "${LITERTLM_ROOT_DIR}/cmake/scripts" 
    CACHE PATH "LiteRT-LM: Directory for internal build and automation scripts")
if(NOT EXISTS "${LITERTLM_MODULES_DIR}")
    message(FATAL_ERROR "LITERTLM Safety Check: ${LITERTLM_MODULES_DIR} not found! Check your LITERTLM_ROOT_DIR.")
endif()



### [END] NEW GLOBAL PATHS###


### [START] OLD GLOBAL PATHS ###
set(SCRIPTS_DIR      "${LITERTLM_SCRIPTS_DIR}")
set(PATCHES_DIR      "${LITERTLM_PATCHES_DIR}")

set(MODULES_DIR        "${LITERTLM_MODULES_DIR}")
list(APPEND CMAKE_MODULE_PATH   "${LITERTLM_MODULES_DIR}")
### [END] OLD GLOBAL PATHS ###




set(EXTERNAL_PROJECT_BINARY_DIR "${CMAKE_BINARY_DIR}/external")
set(THIRD_PARTY_DIR             "${CMAKE_BINARY_DIR}/third_party")

set(GENERATED_SRC_DIR           "${PROJECT_ROOT}/cmake/generated/src")

set(LITERTLM_INCLUDE_PATHS      
  "${GENERATED_SRC_DIR}"
  "${CMAKE_BINARY_DIR}"
)


# --- Environment
if(NOT CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 20)
endif()
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_POLICY_VERSION_MINIMUM 3.20 CACHE STRING "Required CMake policy version." FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive" CACHE STRING "Required CXX flags" FORCE)
# add_link_options("-Wl,-z,muldefs")

set(LITERTLM_LOCAL_STAGING_DIR "${CMAKE_BINARY_DIR}/staging/lib" CACHE INTERNAL "")
file(MAKE_DIRECTORY "${LITERTLM_LOCAL_STAGING_DIR}")
# set(LITERTLM_LOCAL_ARCHIVE_REGISTRY "" CACHE INTERNAL "")
# set(LITERTLM_LOCAL_TARGET_REGISTRY "" CACHE INTERNAL "")



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
include(utils)
include(macros)


# --- Dependencies
include(fetch_content)
include(external_project)


# LITERTLM_INCLUDE_PATHS must be updated before collect_dependencies is called
list(APPEND LITERTLM_INCLUDE_PATHS
  ${OPENCL_HDR_DIR}
  ${ABSL_INCLUDE_DIR}
  ${FLATBUFFERS_INCLUDE_DIR}
  ${GTEST_INCLUDE_DIR}
  ${PROTO_INCLUDE_DIR}
  ${RE2_INCLUDE_DIR}
  ${SENTENCE_INCLUDE_DIR}
  ${TOKENIZER_INCLUDE_DIR}
  ${TFLITE_INCLUDE_DIR}
  ${TFLITE_SRC_DIR}
  ${RUY_INCLUDE_DIR}
  ${TENSORFLOW_SOURCE_DIR}
  ${LITERT_INCLUDE_PATHS}
  ${FETCHCONTENT_MODULE_SRC_DIRS}
  ${FETCHCONTENT_MODULE_INCLUDE_DIR}
  ${CMAKE_CURRENT_BINARY_DIR}/antlr_generated
)

include(collect_dependencies)
if(TARGET LITERTLM_DEPS)
    message(STATUS "✅ DEBUG: LITERTLM_DEPS exists!")
else()
    message(FATAL_ERROR "❌ DEBUG: LITERTLM_DEPS is MISSING!")
endif()

# --- LiteRT-LM Targets
include(setup_generated_src_files)
generate_src_files(ALL_GENERATED_FILES ${ALL_SOURCE_FILES} ${ALL_HEADER_FILES})



add_compile_definitions(
    absl_nullable=
    absl_nonnull=
)


# # set(CMAKE_EXE_LINKER_FLAGS "${ABSL_LINK_FLAGS}")
# # set(CMAKE_SHARED_LINKER_FLAGS "${ABSL_LINK_FLAGS}")

# set(CMAKE_EXE_LINKER_FLAGS
#     "-L${ABSL_LIB_DIR}"
#     "-L${PROTO_INSTALL_PREFIX}/lib"
#     "-L${TFLITE_LIB_DIR}"
#     "-L${TFLITE_BUILD_DIR}"
#     "-L${EXTERNAL_PROJECT_BINARY_DIR}/tflite_external-build/ruy"
# )
# set(CMAKE_SHARED_LINKER_FLAGS
#     " -L${ABSL_LIB_DIR} \
#     -L${PROTO_INSTALL_PREFIX}/lib \
#     -L${TFLITE_LIB_DIR} \
#     -L${TFLITE_BUILD_DIR} \
#     -L${EXTERNAL_PROJECT_BINARY_DIR}/tflite_external-build/ruy \
#     -L${LITERT_INCLUDE_PATHS}"
# )


set(TENSORFLOW_MISSING_SRCS
    "${TENSORFLOW_SOURCE_DIR}/tensorflow/compiler/mlir/lite/allocation.cc"
    "${TENSORFLOW_SOURCE_DIR}/tensorflow/compiler/mlir/lite/mmap_allocation.cc"
    "${TENSORFLOW_SOURCE_DIR}/tensorflow/compiler/mlir/lite/mmap_allocation_disabled.cc"
    "${TENSORFLOW_SOURCE_DIR}/tensorflow/compiler/mlir/lite/core/api/error_reporter.cc"
    "${TENSORFLOW_SOURCE_DIR}/tensorflow/compiler/mlir/lite/core/model_builder_base.cc"

)
set_source_files_properties(${TENSORFLOW_MISSING_SRCS} PROPERTIES GENERATED TRUE)

# add_link_options(
#     "-Wl,--whole-archive"
#     "-Wl,--allow-multiple-definition"
#     "-Wl,--start-group"

# )


# set(LITERTLM_UNIFIED_LINK_SPEC
#     "LINKER:--allow-multiple-definition"
#     "LINKER:--start-group"
#     "LINKER:--whole-archive"
    
#     # 1. Local Registered Archives
#     ${LITERTLM_LOCAL_ARCHIVE_REGISTRY}
    
#     # 2. External Project Aggregates
#     ${_litert_lib_paths} 
#     ${_tflite_lib_paths} 
#     ${_sentencepiece_lib_paths} 
#     ${_protobuf_lib_paths} 
#     ${_absl_lib_paths}
#     ${_re2_lib_paths}
    
#     "LINKER:--no-whole-archive"
#     "LINKER:--end-group"
#     "-lz" "-lrt" "-lpthread" "-ldl"
# )




add_subdirectory(c)
add_subdirectory(schema)
add_subdirectory(runtime)


include("${LITERTLM_MODULES_DIR}/local_aggregate.cmake")
generate_local_aggregate()

# set(CMAKE_CXX_STANDARD_LIBRARIES
#     "${CMAKE_CXX_STANDARD_LIBRARIES} ${_LITERTLM_LINK_FLAGS}" CACHE STRING "" FORCE
# )

add_executable(litert_lm_main
    "runtime/engine/litert_lm_main.cc"
)

if(TARGET litertlm_local_anchor)
    add_dependencies(litert_lm_main litertlm_local_anchor)
endif()

target_link_options(litert_lm_main PRIVATE
  "LINKER:--export-dynamic-symbol=LiteRt*"
)


separate_arguments(_LITERTLM_ODML_EXPANDED_LIST NATIVE_COMMAND "${_LITERTLM_ODML_PAYLOAD}")
separate_arguments(_LITERTLM_CORE_EXPANDED_LIST NATIVE_COMMAND "${_LITERTLM_CORE_PAYLOAD}")
target_link_libraries(litert_lm_main
    PUBLIC
        "-Wl,--allow-multiple-definition"
        "-Wl,--start-group"
        "-Wl,--whole-archive"
        ${_LITERTLM_ODML_EXPANDED_LIST}
        "-Wl,--no-whole-archive"
        ${_LITERTLM_CORE_EXPANDED_LIST}
        libpng_lib
        kissfft_lib
        miniaudio_lib
        minizip_lib
        minja_lib
        zlib_lib
        antlr_lib
        LiteRTLM::nlohmann_json::nlohmann_json
        opencl_headers_lib
        "-lz" "-lrt" "-lpthread" "-ldl" 
        "-Wl,--end-group"
)

target_include_directories(litert_lm_main PRIVATE
    ${LITERTLM_INCLUDE_PATHS}
)

# target_link_libraries(litert_lm_main
#     PUBLIC
#         "Wl,--allow-multiple-definition -Wl,--start-group -Wl,--whole-archive"
#         libpng_lib
#         kissfft_lib
#         miniaudio_lib
#         minizip_lib
#         minja_lib
#         zlib_lib
#         antlr_lib
#         LiteRTLM::nlohmann_json::nlohmann_json
#         opencl_headers_lib
#         ${_LITERTLM_PAYLOAD}
#         "-lz -lrt -lpthread -ldl -Wl,--end-group"
# )


# # Android Specifics
# if(ANDROID)
#   target_link_libraries(litert_lm_main PRIVATE EGL GLESv3)
# endif()

# set(CMAKE_CXX_STANDARD_LIBRARIES 
#     "${CMAKE_CXX_STANDARD_LIBRARIES} -Wl,--allow-multiple-definition -Wl,--start-group -Wl,--whole-archive ${_litert_lib_paths} ${_tflite_lib_paths} ${_sentencepiece_lib_paths} ${_flatbuffers_lib_paths} ${_protobuf_lib_paths} ${_absl_lib_paths} -lz -lrt -lpthread -ldl -Wl,--end-group" CACHE PATH "" FORCE
# )
