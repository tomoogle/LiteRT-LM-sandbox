include(ExternalProject)
set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})


set(LITERT_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/protobuf)
set(LITERT_INSTALL_PREFIX ${LITERT_EXT_PREFIX}/install)
set(LITERT_CONFIG_CMAKE_FILE "${LITERT_INSTALL_PREFIX}/lib/cmake/litert/litert-config.cmake")


# set(PATCH_FILE "${PROJECT_ROOT}/cmake/patches/litert_fixes.patch")

ExternalProject_Add(
  litert_external
  DEPENDS
    absl_external
  GIT_REPOSITORY
    https://github.com/google-ai-edge/LiteRT.git
  GIT_TAG
    08735bb886df5e3e1294604c61175efbc72c59dd
  PREFIX
    ${EXTERNAL_PROJECT_BINARY_DIR}/litert
  SOURCE_SUBDIR
    litert
  # PATCH_COMMAND
  #   git apply --ignore-space-change --ignore-whitespace "${PATCH_FILE}" || ${CMAKE_COMMAND} -E echo "Git apply failed (or not needed)..."
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${TFLITE_INSTALL_PREFIX}
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
    -DCMAKE_POLICY_DEFAULT_CMP0170=OLD
    -DCMAKE_CXX_STANDARD=17
    -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON

    "-D_abseil-cpp_LICENSE_FILE:FILEPATH=${ABSL_EXT_PREFIX}/src/absl_external/LICENSE"

    # -DFETCHCONTENT_SOURCE_DIR_ABSEIL_CPP=${ABSL_EXT_PREFIX}/src/absl_external
    -Dabseil-cpp_SOURCE_DIR=${ABSL_EXT_PREFIX}/src/absl_external
    -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
    -Dabseil-cpp_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl


    -Dflatbuffers_DIR=${FLATBUFFERS_INSTALL_PREFIX}/lib/cmake/flatbuffers
    
    -DTFLITE_ENABLE_INSTALL=OFF
    -DTFLITE_ENABLE_XNNPACK=ON
        
    -DTFLITE_ENABLE_RESOURCE_VARIABLE=OFF
    
    -DXNNPACK_SET_VERBOSITY=OFF
    
    "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DTF_MAJOR_VERSION=2 -DTF_MINOR_VERSION=20 -DTF_PATCH_VERSION=0 -DTF_VERSION_SUFFIX=\"\""
    "-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS} -DTF_MAJOR_VERSION=2 -DTF_MINOR_VERSION=20 -DTF_PATCH_VERSION=0 -DTF_VERSION_SUFFIX=\"\""




      # -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
      # -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
      # -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
      # -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
      # -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
      # -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
      # -DCMAKE_POSITION_INDEPENDENT_CODE=ON
      # -DLITERT_DISABLE_KLEIDIAI=ON
      # -DLITERT_BUILD_C_API=ON
      # -DFLATBUFFERS_INSTALL=OFF
      # -DFLATBUFFERS_BUILD_TESTS=OFF
      # -DLITERT_ENABLE_GPU=OFF
      # -DLITERT_ENABLE_NPU=OFF
)

# ExternalProject_Get_Property(litert_external INSTALL_DIR BINARY_DIR)
# set(LITERT_INSTALL_DIR ${INSTALL_DIR})
# set(LITERT_BUILD_DIR ${BINARY_DIR})

# set(LITERT_INCLUDE_DIR
#     "$<BUILD_INTERFACE:${BINARY_DIR}/include>"
#     "$<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/litert/src/litert_external>"
# )

# define_litert_target(litert_core             "liblitert_core.a"              "core")
# define_litert_target(litert_core_model       "liblitert_core_model.a"        "core/model")
# define_litert_target(litert_core_cache       "liblitert_core_cache.a"        "core/cache")
# define_litert_target(litert_c_api            "liblitert_c_api.a"             "c")
# define_litert_target(litert_c_options        "liblitert_c_options.a"         "c/options")
# # define_litert_target(litert_cc_internal      "liblitert_cc_internal.a"       "cc")
# define_litert_target(litert_cc_options       "liblitert_cc_options.a"        "cc/options")
# define_litert_target(litert_runtime          "liblitert_runtime.a"           "runtime")
# define_litert_target(litert_logging          "liblitert_logging.a"           "c")
# define_litert_target(tensorflow-lite         "libtensorflow-lite.a"          "tflite_build")
# define_litert_target(flatbuffers             "libflatbuffers.a"              "_deps/flatbuffers-build")
# define_litert_target(xnnpack-delegate        "libxnnpack-delegate.a"         "tflite_build")
# define_litert_target(xnnpack-core            "libXNNPACK.a"                  "tflite_build/_deps/xnnpack-build")




# add_library(litert_libs INTERFACE)


# # --- Post-Build Object Extraction (Fixing the dependency order) ---

# # Define a directory for extracted object files
# set(LITERT_EXTRACTED_DIR "${CMAKE_BINARY_DIR}/litert_extracted_objects")
# file(MAKE_DIRECTORY ${LITERT_EXTRACTED_DIR})

# # List of targets whose symbols are failing (C-API and Logging implementations)
# set(LITERT_BYPASS_TARGETS
#   litert_c_api
#   litert_logging
#   litert_core
#   litert_runtime
#   litert_core_model
#   tensorflow-lite

#   ${absl_base_targets}
#   ${absl_container_targets}
#   ${absl_debugging_targets}
#   ${absl_flags_targets}
#   ${absl_crc_targets}
#   ${absl_hash_targets}
#   ${absl_log_targets}
#   ${absl_numeric_targets}
#   ${absl_profiling_targets}
#   ${absl_random_targets}
#   ${absl_status_targets}
#   ${absl_strings_targets}
#   ${absl_synchronization_targets}
#   ${absl_time_targets}
# )
# set(LITERT_EXTRACTION_TARGETS "")


# Macro to handle the extraction: Now correctly adds dependency to the CUSTOM target
# macro(extract_target_objects target_name)
#     get_target_property(ARCHIVE_PATH ${target_name} IMPORTED_LOCATION)
#     set(EXTRACTION_TARGET_NAME "${target_name}_extract_objects")

#     add_custom_command(
#         OUTPUT ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete
#         COMMAND ${CMAKE_COMMAND} -E chdir ${LITERT_EXTRACTED_DIR} ar x ${ARCHIVE_PATH}
#         COMMAND ${CMAKE_COMMAND} -E touch ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete
#         DEPENDS ${target_name}
#         VERBATIM
#     )
# Macro to handle the extraction: Now correctly adds dependency to the CUSTOM target
# macro(extract_target_objects target_name)
#     get_target_property(ARCHIVE_PATH ${target_name} IMPORTED_LOCATION)
#     set(EXTRACTION_TARGET_NAME "${target_name}_extract_objects")

#     add_custom_command(
#         OUTPUT ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete
#         COMMAND ${CMAKE_COMMAND} -E chdir ${LITERT_EXTRACTED_DIR} ar x ${ARCHIVE_PATH}
#         COMMAND ${CMAKE_COMMAND} -E touch ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete
#         DEPENDS ${target_name} litert_external
#         VERBATIM
#     )
#     add_custom_target(${EXTRACTION_TARGET_NAME} DEPENDS ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete)

#     # Collect the custom target name to establish final dependency chain later
#     list(APPEND LITERT_EXTRACTION_TARGETS ${EXTRACTION_TARGET_NAME})
# endmacro()

# # Execute extraction for problematic targets
# foreach(target IN LISTS LITERT_BYPASS_TARGETS)
#     extract_target_objects(${target})
# endforeach()

# add_dependencies(litert_libs ${LITERT_EXTRACTION_TARGETS})



# set(LITERT_REMAINING_ARCHIVES)
# file(GLOB_RECURSE ALL_ARCHIVES_PATHS "${LITERT_BUILD_DIR}/**/*.a")

# foreach(archive_path IN LISTS ALL_ARCHIVES_PATHS)
#     if(archive_path MATCHES "/liblitert_c_api.a" OR
#        archive_path MATCHES "/liblitert_logging.a" OR
#        archive_path MATCHES "/input.a$" OR
#        archive_path MATCHES "/liblitert_npu_numerics_check.a" OR
#        archive_path MATCHES "/_deps/abseil-cpp-build/" OR
#        archive_path MATCHES "internal"
#     )
#         # Skip the problematic/redundant archives
#     else()
#         list(APPEND LITERT_REMAINING_ARCHIVES ${archive_path})
#     endif()
# endforeach()


# if(UNIX AND NOT APPLE)
#     target_link_libraries(litert_libs INTERFACE
#         -Wl,--start-group

#         # 1. Link the extracted object files directly by linking the directory
#         # -L flag tells the linker to search this directory for symbols.
#         -L${LITERT_EXTRACTED_DIR}

#         # 2. Explicitly name the bypass targets (the linker finds their .o files via the -L flag)
#         ${LITERT_BYPASS_TARGETS}

#         # 3. Link ALL remaining archives (TFLite, Ruy, Abseil, etc.)
#         ${LITERT_REMAINING_ARCHIVES}

#         -Wl,--end-group
#     )
# else()
#     # Non-Linux platforms linkage
#     target_link_libraries(litert_libs INTERFACE
#         ${LITERT_EXTRACTED_DIR}
#         ${LITERT_BYPASS_TARGETS}
#         ${LITERT_REMAINING_ARCHIVES}
#     )
# endif()

# target_include_directories(litert_libs INTERFACE ${LITERT_INCLUDE_DIR})
# add_dependencies(litert_libs litert_external)
# add_dependencies(litert_libs litert_external-build)
