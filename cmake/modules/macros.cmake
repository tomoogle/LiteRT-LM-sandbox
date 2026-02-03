include_guard(GLOBAL)

# ==============================================================================
# LITERTLM MACROS
# ==============================================================================

#[[.rst:
import_static_lib
-----------------
Imports an existing static library (.a) as a CMake GLOBAL target.

This bridges the ExternalProject build phase and internal build tree. Once imported, the target can be linked using
target_link_libraries().

Usage:
  import_static_lib(my_target_name "/absolute/path/to/lib.a")

Arguments:
  name : The CMake target name.
  path : The absolute filesystem path to the static library file.
#]]
# macro(import_static_lib target_name lib_full_path)
#     if("${lib_full_path}" STREQUAL "")
#         message(FATAL_ERROR "Critical Error: Attempted to import '${target_name}' with an empty path.")
#     endif()

#     add_library(${target_name} STATIC IMPORTED GLOBAL)
#     set_target_properties(${target_name} PROPERTIES
#         IMPORTED_LOCATION "${lib_full_path}"
#     )
# endmacro()


macro(import_static_lib target_name lib_full_path)
    if("${lib_full_path}" STREQUAL "")
        message(FATAL_ERROR "Critical Error: Empty path for '${target_name}'")
    endif()

    add_library(${target_name} INTERFACE IMPORTED GLOBAL)
    
    # [CRITICAL CHANGE] 
    # Only attach the file if we AREN'T using the global aggregate blob.
    # Since you force the blob in CMAKE_CXX_STANDARD_LIBRARIES, we *never* want
    # the individual file here, or it shadows the group.
    # set_target_properties(${target_name} PROPERTIES IMPORTED_LOCATION "${lib_full_path}")

    # Instead, just map it to the INTERFACE (so CMake is happy it exists)
    # If you need headers, ensure they are attached via target_include_directories elsewhere
endmacro()



# macro(import_absl_lib target_name lib_full_path)
#     if("${lib_full_path}" STREQUAL "")
#         message(FATAL_ERROR "Critical Error: Attempted to import '${target_name}' with an empty path.")
#     endif()

#     # 1. Create the base IMPORTED target
#     add_library(${target_name} STATIC IMPORTED GLOBAL)
#     set_target_properties(${target_name} PROPERTIES
#         IMPORTED_LOCATION "${lib_full_path}"
#     )

#     string(REPLACE "imp_" "" clean_name "${target_name}")
#     string(REPLACE "absl_" "absl::" ns_path "${clean_name}")
    
#     if(NOT TARGET LiteRTLM::${ns_path})
#         add_library(LiteRTLM::${ns_path} ALIAS ${target_name})
#     endif()
# endmacro()
macro(import_absl_lib target_name lib_full_path)
    # Change STATIC to INTERFACE so it doesn't demand a file path on the link line
    add_library(${target_name} INTERFACE IMPORTED GLOBAL)
    
    # We DO NOT set IMPORTED_LOCATION. 
    # The linking is handled by the global --start-group blob.
    # We ONLY provide the include directories.
    set_target_properties(${target_name} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${ABSL_INCLUDE_DIR}"
    )

    string(REPLACE "imp_" "" clean_name "${target_name}")
    string(REPLACE "absl_" "absl::" ns_path "${clean_name}")
    
    if(NOT TARGET LiteRTLM::${ns_path})
        add_library(LiteRTLM::${ns_path} ALIAS ${target_name})
    endif()
endmacro()




# #[[.rst:
# add_litertlm_library
# --------------------
# Wrapper for add_library that automatically ensures the library is only 
# processed after the external dependency packages are configured.

# Supports all standard library types (STATIC, SHARED, INTERFACE).

# Usage:
#   add_litertlm_library(my_lib STATIC src/file.cc)
#   add_litertlm_library(my_interface INTERFACE)
# #]]
# macro(add_litertlm_library target_name lib_type)
#     add_library(${target_name} ${lib_type} ${ARGN})
    
#     if(TARGET litert_external)
#         add_dependencies(${target_name} litert_external)
#     endif()
# endmacro()



#[[.rst:
add_litertlm_executable
-----------------------
Wrapper for add_executable that automatically ensures build order
by linking against the generated target list and dependency tree.

Usage:
  add_litertlm_executable(my_app src/main.cc)
#]]
# macro(add_litertlm_executable target_name)
#     add_executable(${target_name} ${ARGN})

#     # Inject Build Order Dependency
#     if(TARGET litert_external)
#         add_dependencies(${target_name} litert_external)
#     endif()
# endmacro()


# macro(add_litertlm_executable target_name)
#     # 1. Standard executable definition
#     add_executable(${target_name} ${ARGN})
#     if(TARGET litert_external)
#         add_dependencies(${target_name} litert_external)
#     endif()
#     # 2. Build Order Synchronization
#     # We ensure this executable waits for all registered local archives to be ready.
#     # We use a unique check target name per executable to avoid global name collisions.
#     # set(_registry_check_target "${target_name}_registry_check")
#     # if(NOT TARGET ${_registry_check_target})
#     #     add_custom_target(${_registry_check_target} DEPENDS ${LITERTLM_LOCAL_ARCHIVE_REGISTRY})
#     # endif()
#     # add_dependencies(${target_name} ${_registry_check_target})
    
#     separate_arguments(_litert_lib_paths)
#     separate_arguments(_tflite_lib_paths)
#     separate_arguments(_sentencepiece_lib_paths)
#     separate_arguments(_re2_lib_paths)
#     separate_arguments(_flatbuffers_lib_paths)
#     separate_arguments(_protobuf_lib_paths)
#     separate_arguments(_absl_lib_paths)
#     separate_arguments(LITERTLM_LOCAL_ARCHIVE_REGISTRY)


#     set(_registry_check_target "${target_name}_registry_check")
#     if(NOT TARGET ${_registry_check_target})
#         add_custom_target(${_registry_check_target} DEPENDS ${LITERTLM_LOCAL_TARGET_REGISTRY})
#     endif()
#     add_dependencies(${target_name} ${_registry_check_target})

#     # 3. Apply Unified Linkage Specification
#     target_link_libraries(${target_name} PRIVATE
#         "-Wl,--allow-multiple-definition -Wl,--start-group -Wl,--whole-archive ${LITERTLM_LOCAL_ARCHIVE_REGISTRY} ${_litert_lib_paths} ${_tflite_lib_paths} ${_sentencepiece_lib_paths} ${_re2_lib_paths} ${_flatbuffers_lib_paths} ${_protobuf_lib_paths} ${_absl_lib_paths} -Wl,--no-whole-archive -Wl,--end-group -lz -lrt -lpthread -ldl"
#     )
# endmacro()






macro(import_proto_lib target_name lib_path)
    if(NOT TARGET ${target_name})
        add_library(${target_name} INTERFACE IMPORTED GLOBAL)
        set_target_properties(imp_protobuf PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${PROTO_INCLUDE_DIR}")
        add_dependencies(${target_name} protobuf_external)
    endif()
endmacro()



#[[.rst:
load_package
-----------

Orchestrates the resolution and configuration of a project dependency.

This macro implements the "Pre-Satisfied Dependency" principle: it will skip 
local compilation and configuration if it detects the requirement is met.

Dependencies can be pre-satisfied by:
1. Providing an Imported Target:  <name>::<name>
2. Setting a Resolution variable: <UPPER_NAME>_FOUND
3. Setting a lowercase variable:   <name>_FOUND

Example:
  set(ABSL_FOUND TRUE)
  load_package(absl) # Skips the internal Abseil ExternalProject build.

Arguments:
  name : The identifier of the dependency module in cmake/packages/

Requires:
  - LITERTLM_PACKAGES_DIR must be set to the absolute path of the modules folder.
  - LITERTLM_MODULES_DIR must be set to find supporting scripts.

Note:
  This macro is idempotent. Once a dependency is resolved, it utilizes a 
  CACHE variable to prevent redundant configuration cycles.
#]]
macro(load_package name)
    string(TOUPPER "${name}" upper_name)
    set(USE_SYSTEM_VAR "LITERTLM_USE_SYSTEM_${upper_name}")
    
    option(${USE_SYSTEM_VAR} "LiteRT-LM: Use system/pre-existing ${name} instead of bundled distribution" OFF)

    set(SHOULD_PROVISION TRUE)

    if(${${USE_SYSTEM_VAR}})
        find_package(${name} QUIET)
        if(TARGET ${name}::${name} OR TARGET ${name})
            message(STATUS "[LITERTLM] Resolution: Using SYSTEM ${name} (User Override)")
            set(SHOULD_PROVISION FALSE)

            if(TARGET ${name}::${name})
                set(actual_target "${name}::${name}")
            else()
                set(actual_target "${name}")
            endif()

            message(STATUS "[LITERTLM] Mapping ${name}_external to existing target")
            add_dependencies("${name}_external" ${actual_target})

        else()
            message(FATAL_ERROR "[LITERTLM] User set ${USE_SYSTEM_VAR}=ON but ${name} was not found in the environment!")
        endif()

    elseif(TARGET ${name}::${name} OR TARGET ${name})
        message(STATUS "[LITERTLM] Resolution: Using PRE-RESOLVED ${name} (Detected in Namespace)")
        set(SHOULD_PROVISION FALSE)
    endif()

    if(SHOULD_PROVISION)
        message(STATUS "[LITERTLM] Resolution: Using INTERNAL build for ${name}")
        include("${LITERTLM_PACKAGES_DIR}/${name}/${name}.cmake")        
    endif()
    cmake_checkpoint_target("${name}_external" TYPE CUSTOM QUIET)
endmacro()




# ==============================================================================
# LiteRTLM Component Orchestrator
# ==============================================================================
# Usage: literlm_configure_component_interface(sentencepiece "lib1;lib2" "dep1;dep2" "/inc")
# ==============================================================================

macro(literlm_configure_component_interface prefix main_targets dependency_targets include_dirs)
    set(_target "${prefix}_libs")
    set(_ns_target "LiteRTLM::${prefix}::${prefix}")

    if(NOT TARGET ${_target})
        add_library(${_target} INTERFACE IMPORTED GLOBAL)
    endif()

    if(NOT TARGET ${_ns_target})
        add_library(${_ns_target} ALIAS ${_target})
    endif()

    target_include_directories(${_target} SYSTEM INTERFACE ${include_dirs})

    target_link_libraries(${_target} INTERFACE
        $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--start-group>
            ${main_targets}
            ${dependency_targets}
            LiteRTLM::absl::absl
            LiteRTLM::protobuf::libprotobuf
        $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--end-group>
        
        pthread
    )
endmacro()






# macro(add_litertlm_library target_name lib_type)
#     add_library(${target_name} ${lib_type} ${ARGN})
    
#     if(TARGET litert_external)
#         add_dependencies(${target_name} litert_external)
#     endif()
    
#     if("${lib_type}" STREQUAL "STATIC")
#         # 1. Force Output to Staging Dir
#         set_target_properties(${target_name} PROPERTIES 
#             ARCHIVE_OUTPUT_DIRECTORY "${LITERTLM_LOCAL_STAGING_DIR}"
#         )

#         set(_phys_path "${LITERTLM_LOCAL_STAGING_DIR}/${CMAKE_STATIC_LIBRARY_PREFIX}${target_name}${CMAKE_STATIC_LIBRARY_SUFFIX}")
        
#         set(CMAKE_CXX_STANDARD_LIBRARIES 
#             "${CMAKE_CXX_STANDARD_LIBRARIES} -Wl,--whole-archive ${_phys_path} -Wl,--no-whole-archive" 
#             CACHE STRING "" FORCE
#         )
        

#         message(STATUS "[LiteRTLM] Injected local target '${target_name}' into Global Hammer.")
#     endif()
# endmacro()




# macro(add_litertlm_library target_name lib_type)
#     add_library(${target_name} ${lib_type} ${ARGN})
    
#     # Standard build-order dependency
#     if(TARGET litert_external)
#         add_dependencies(${target_name} litert_external)
#     endif()
    
#     if("${lib_type}" STREQUAL "STATIC")
#         # Stage the archive
#         set_target_properties(${target_name} PROPERTIES 
#             ARCHIVE_OUTPUT_DIRECTORY "${LITERTLM_LOCAL_STAGING_DIR}"
#         )

#         # Generate the absolute path to the staged file
#         set(_phys_path "${LITERTLM_LOCAL_STAGING_DIR}/${CMAKE_STATIC_LIBRARY_PREFIX}${target_name}${CMAKE_STATIC_LIBRARY_SUFFIX}")
        
#         # Register the path for the final unified link phase
#         list(APPEND LITERTLM_LOCAL_ARCHIVE_REGISTRY "${_phys_path}")
#         set(LITERTLM_LOCAL_ARCHIVE_REGISTRY "${LITERTLM_LOCAL_ARCHIVE_REGISTRY}" CACHE INTERNAL "")

#         list(APPEND LITERTLM_LOCAL_TARGET_REGISTRY "${target_name}")
#         set(LITERTLM_LOCAL_TARGET_REGISTRY "${LITERTLM_LOCAL_TARGET_REGISTRY}" CACHE INTERNAL "")

#         message(STATUS "[LiteRTLM] Staged and Registered: ${target_name}")
#     endif()
# endmacro()



set_property(GLOBAL PROPERTY LITERTLM_LOCAL_ARCHIVE_REGISTRY "")
set_property(GLOBAL PROPERTY LITERTLM_LOCAL_TARGET_REGISTRY "")

# Define Staging Dir
set(LITERTLM_LOCAL_STAGING_DIR "${CMAKE_BINARY_DIR}/staging/lib" CACHE INTERNAL "")
file(MAKE_DIRECTORY "${LITERTLM_LOCAL_STAGING_DIR}")

macro(add_litertlm_library target_name lib_type)
    add_library(${target_name} ${lib_type} ${ARGN})
    
    # Lock External Deps
    if(TARGET litert_external)
        add_dependencies(${target_name} litert_external)
    endif()

    if("${lib_type}" STREQUAL "STATIC")
        # 1. Stage the File
        set_target_properties(${target_name} PROPERTIES 
            ARCHIVE_OUTPUT_DIRECTORY "${LITERTLM_LOCAL_STAGING_DIR}"
        )
        set(_phys_path "${LITERTLM_LOCAL_STAGING_DIR}/${CMAKE_STATIC_LIBRARY_PREFIX}${target_name}${CMAKE_STATIC_LIBRARY_SUFFIX}")

        # 2. Add to Global Registry (The Map)
        set_property(GLOBAL APPEND PROPERTY LITERTLM_LOCAL_ARCHIVE_REGISTRY "${_phys_path}")
        set_property(GLOBAL APPEND PROPERTY LITERTLM_LOCAL_TARGET_REGISTRY "${target_name}")
    endif()
endmacro()


macro(add_litertlm_executable target_name)
    # add_executable(${target_name} ${ARGN})
    
    # # 1. Generate the Local Aggregate right before we need it
    # # This ensures the registry is fully populated.
    # include("${LITERTLM_MODULES_DIR}/local_aggregate.cmake")
    # generate_local_aggregate()

    # # 2. Link to the Aggregates
    # target_link_libraries(${target_name} PRIVATE
    #     LiteRTLM::Local::Aggregate          # Your local code
    #     LiteRTLM::litert::litert
    #     LiteRTLM::tflite::tflite
    #     LiteRTLM::sentencepiece::sentencepiece
    #     LiteRTLM::flatbuffers::flatbuffers 
    #     LiteRTLM::re2::re2
    #     LiteRTLM::protobuf::libprotobuf
    #     LiteRTLM::absl::absl
    #     "-lz -lrt -lpthread -ldl"
    # )
endmacro()