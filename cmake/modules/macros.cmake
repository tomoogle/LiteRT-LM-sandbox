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
macro(import_static_lib target_name lib_full_path)
    if("${lib_full_path}" STREQUAL "")
        message(FATAL_ERROR "Critical Error: Attempted to import '${target_name}' with an empty path.")
    endif()

    add_library(${target_name} STATIC IMPORTED GLOBAL)
    set_target_properties(${target_name} PROPERTIES
        IMPORTED_LOCATION "${lib_full_path}"
    )
endmacro()



#[[.rst:
add_litertlm_library
--------------------
Wrapper for add_library that automatically ensures the library is only 
processed after the external dependency recipes are configured.

Supports all standard library types (STATIC, SHARED, INTERFACE).

Usage:
  add_litertlm_library(my_lib STATIC src/file.cc)
  add_litertlm_library(my_interface INTERFACE)
#]]
macro(add_litertlm_library target_name lib_type)
    add_library(${target_name} ${lib_type} ${ARGN})
    
    if(TARGET litert_external)
        add_dependencies(${target_name} litert_external)
    endif()
endmacro()



#[[.rst:
add_litertlm_executable
-----------------------
Wrapper for add_executable that automatically ensures build order
by linking against the generated target list and dependency tree.

Usage:
  add_litertlm_executable(my_app src/main.cc)
#]]
macro(add_litertlm_executable target_name)
    add_executable(${target_name} ${ARGN})

    # Inject Build Order Dependency
    if(TARGET litert_external)
        add_dependencies(${target_name} litert_external)
    endif()
endmacro()



macro(import_proto_lib target_name lib_path)
    if(NOT TARGET ${target_name})
        add_library(${target_name} STATIC IMPORTED GLOBAL)
        set_target_properties(${target_name} PROPERTIES
            IMPORTED_LOCATION "${lib_path}"
            INTERFACE_INCLUDE_DIRECTORIES "${PROTO_INCLUDE_DIR}"
        )
        add_dependencies(${target_name} protobuf_external)
    endif()
endmacro()



#[[.rst:
load_recipe
-----------

Orchestrates the configuration of a project dependency.

This macro follows the "Friendly Human" principle: it will skip its own 
internal build logic if it detects the dependency is already satisfied.

Users can pre-satisfy a dependency by:
1. Providing an Imported Target:  <name>::<name>
2. Setting a Found variable:     <UPPER_NAME>_FOUND
3. Setting a lowercase variable: <name>_FOUND

Example:
  set(ABSL_FOUND TRUE)
  load_recipe(absl) # This will now skip the internal Abseil build.

Arguments:
  name : The lowercase name of the recipe folder in cmake/recipes/

Requires:
  - LITERTLM_RECIPES_DIR must be set to the absolute path of the recipes folder.
  - LITERTLM_MODULES_DIR must be set to find supporting scripts.

Note:
  This macro is "sticky." Once a recipe is loaded, it sets a CACHE variable
  to prevent redundant configuration cycles.
#]]
macro(load_recipe name)
    string(TOUPPER "${name}" upper_name)
    if(TARGET ${name}::${name} OR ${upper_name}_FOUND OR ${name}_FOUND)
        message(STATUS "[LITERTLM] Recipe '${name}' satisfied. Skipping build.")
    else()
        set(recipe_file "${LITERTLM_RECIPES_DIR}/${name}/${name}.cmake")
        if(EXISTS "${recipe_file}")
            message(STATUS "[LITERTLM] Cooking Recipe: ${name}.cmake")
            include("${recipe_file}")            
            set(${upper_name}_FOUND TRUE CACHE INTERNAL "Recipe ${name} loaded")
        else()
            message(FATAL_ERROR "[LITERTLM] FATAL: Recipe '${name}.cmake' is missing!")
        endif()
    endif()
endmacro()