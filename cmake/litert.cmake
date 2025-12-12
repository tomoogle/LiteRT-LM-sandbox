include(ExternalProject)


set(PATCH_FILE "${CMAKE_SOURCE_DIR}/cmake/patches/litert_fixes.patch")

ExternalProject_Add(
    litert_external 
    GIT_REPOSITORY      https://github.com/google-ai-edge/LiteRT.git
    GIT_TAG             08735bb886df5e3e1294604c61175efbc72c59dd
    PREFIX              ${CMAKE_CURRENT_BINARY_DIR}/litert
    SOURCE_SUBDIR       litert
    PATCH_COMMAND       git apply --ignore-space-change --ignore-whitespace "${PATCH_FILE}" || ${CMAKE_COMMAND} -E echo "Git apply failed (or not needed)..."
    CMAKE_ARGS          
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> 
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DLITERT_DISABLE_KLEIDIAI=ON
        -DLITERT_BUILD_C_API=ON
        -DFLATBUFFERS_INSTALL=OFF
        -DFLATBUFFERS_BUILD_TESTS=OFF
        -DLITERT_ENABLE_GPU=OFF
        -DLITERT_ENABLE_NPU=OFF
)

ExternalProject_Get_Property(litert_external INSTALL_DIR BINARY_DIR)
set(LITERT_INSTALL_DIR ${INSTALL_DIR})
set(LITERT_BUILD_DIR ${BINARY_DIR})      

set(LITERT_INCLUDE_DIR 
    "$<BUILD_INTERFACE:${LITERT_INSTALL_DIR}/include>"
    "$<BUILD_INTERFACE:${BINARY_DIR}/include>"
)

macro(define_litert_target target_name lib_name lib_subdir)
    add_library(${target_name} STATIC IMPORTED)
    set_target_properties(${target_name} PROPERTIES
        IMPORTED_LOCATION "${LITERT_BUILD_DIR}/${lib_subdir}/${lib_name}" 
        INTERFACE_INCLUDE_DIRECTORIES "${LITERT_INCLUDE_DIR}"
    )
    add_dependencies(${target_name} litert_external)
endmacro()

define_litert_target(litert_core             "liblitert_core.a"              "core")
define_litert_target(litert_core_model       "liblitert_core_model.a"        "core/model")
define_litert_target(litert_core_cache       "liblitert_core_cache.a"        "core/cache") 
define_litert_target(litert_c_api            "liblitert_c_api.a"             "c")
define_litert_target(litert_c_options        "liblitert_c_options.a"         "c/options")
define_litert_target(litert_cc_internal      "liblitert_cc_internal.a"       "cc")
define_litert_target(litert_cc_options       "liblitert_cc_options.a"        "cc/options")
define_litert_target(litert_runtime          "liblitert_runtime.a"           "runtime")
define_litert_target(litert_logging          "liblitert_logging.a"           "c")
define_litert_target(tensorflow-lite         "libtensorflow-lite.a"          "tflite_build")
define_litert_target(flatbuffers             "libflatbuffers.a"              "_deps/flatbuffers-build")
define_litert_target(xnnpack-delegate        "libxnnpack-delegate.a"         "tflite_build")
define_litert_target(xnnpack-core            "libXNNPACK.a"                  "tflite_build/_deps/xnnpack-build")

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/absl.cmake)



add_library(litert_libs INTERFACE)


# --- Post-Build Object Extraction (Fixing the dependency order) ---

# Define a directory for extracted object files
set(LITERT_EXTRACTED_DIR "${CMAKE_BINARY_DIR}/litert_extracted_objects")
file(MAKE_DIRECTORY ${LITERT_EXTRACTED_DIR})

# List of targets whose symbols are failing (C-API and Logging implementations)
set(LITERT_BYPASS_TARGETS
  litert_c_api
  litert_logging
  litert_core
  litert_runtime
  litert_core_model

# Abseil Base & Core Utilities
  absl_base        
  absl_base_internal
  absl_check       
  absl_strerror
  absl_throw_delegate
  absl_hash
  absl_span
  
  # Status, Error, and Synchronization (Fixes Mutex::unlock, Status builders)
  absl_status      
  absl_statusor    
  absl_status_builders
  absl_status_core
  absl_synchronization
  absl_synchronization_core

  # Logging (Fixes Flush, MinLogLevel)
  absl_log         
  absl_log_internal_message
  absl_log_internal_globals
  absl_log_initialize 
  absl_log_sink

  # Strings, Numeric, and Containers
  absl_strings_lib 
  absl_str_format
  absl_flat_hash_map
  absl_random_random
  
  # Flags and Parsing (Fixes FlagImpl::ReadOneWord, RegisterCommandLineFlag)
  absl_flags       
  absl_flags_internal
  absl_flags_commandlineflag
  absl_flags_marshalling 
  absl_flags_program_name # Critical low-level flag logic
  absl_flags_registry
)
set(LITERT_EXTRACTION_TARGETS "")


# Macro to handle the extraction: Now correctly adds dependency to the CUSTOM target
macro(extract_target_objects target_name)
    get_target_property(ARCHIVE_PATH ${target_name} IMPORTED_LOCATION)
    set(EXTRACTION_TARGET_NAME "${target_name}_extract_objects")

    add_custom_command(
        OUTPUT ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete
        COMMAND ${CMAKE_COMMAND} -E chdir ${LITERT_EXTRACTED_DIR} ar x ${ARCHIVE_PATH}
        COMMAND ${CMAKE_COMMAND} -E touch ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete
        DEPENDS ${target_name}
        VERBATIM
    )
    add_custom_target(${EXTRACTION_TARGET_NAME} DEPENDS ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete)
    
    # Collect the custom target name to establish final dependency chain later
    list(APPEND LITERT_EXTRACTION_TARGETS ${EXTRACTION_TARGET_NAME})
endmacro()

# Execute extraction for problematic targets
foreach(target IN LISTS LITERT_BYPASS_TARGETS)
    extract_target_objects(${target})
endforeach()

# CRITICAL FIX: Ensure the final litert_libs target depends on the extraction custom targets.
add_dependencies(litert_libs ${LITERT_EXTRACTION_TARGETS})


# --- 6. Define the Remaining Archives for Linkage ---

set(LITERT_REMAINING_ARCHIVES)
file(GLOB_RECURSE ALL_ARCHIVES_PATHS "${LITERT_BUILD_DIR}/**/*.a")

foreach(archive_path IN LISTS ALL_ARCHIVES_PATHS)
    if(archive_path MATCHES "/liblitert_c_api.a" OR 
       archive_path MATCHES "/liblitert_logging.a" OR 
       archive_path MATCHES "/input.a$" OR
       archive_path MATCHES "/liblitert_npu_numerics_check.a"
    )
        # Skip the problematic/redundant archives
    else()
        list(APPEND LITERT_REMAINING_ARCHIVES ${archive_path})
    endif()
endforeach()


# --- 7. The Final Linkage Block (Using the Extracted Objects/Directory) ---

if(UNIX AND NOT APPLE)
    target_link_libraries(litert_libs INTERFACE
        -Wl,--start-group
        
        # 1. Link the extracted object files directly by linking the directory
        # -L flag tells the linker to search this directory for symbols.
        -L${LITERT_EXTRACTED_DIR}
        
        # 2. Explicitly name the bypass targets (the linker finds their .o files via the -L flag)
        ${LITERT_BYPASS_TARGETS}
        
        # 3. Link ALL remaining archives (TFLite, Ruy, Abseil, etc.)
        ${LITERT_REMAINING_ARCHIVES}
        
        -Wl,--end-group
    )
else()
    # Non-Linux platforms linkage
    target_link_libraries(litert_libs INTERFACE
        -L${LITERT_EXTRACTED_DIR}
        ${LITERT_BYPASS_TARGETS}
        ${LITERT_REMAINING_ARCHIVES}
    )
endif()

target_include_directories(litert_libs INTERFACE ${LITERT_INCLUDE_DIR})
add_dependencies(litert_libs litert_external)