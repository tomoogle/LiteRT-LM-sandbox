find_package(Python3 COMPONENTS Interpreter)



function(_collect_dependency_includes LIB_NAMES_LIST OUTPUT_VAR)

    set(COLLECTED_INCLUDE_PATHS "")

    foreach(LIB_NAME IN ITEMS ${LIB_NAMES_LIST})
        set(SOURCE_DIR_VAR "${LIB_NAME}-src")
        
        if (DEFINED ${SOURCE_DIR_VAR})
            set(INCLUDE_PATH_VALUE "${${SOURCE_DIR_VAR}}")

            list(APPEND COLLECTED_INCLUDE_PATHS "${INCLUDE_PATH_VALUE}")
            list(APPEND COLLECTED_INCLUDE_PATHS "${INCLUDE_PATH_VALUE}/include")
        else()
            message(WARNING "Dependency source directory variable not found: ${SOURCE_DIR_VAR}. Check FetchContent usage.")
        endif()
    endforeach()
    
    # Pass the final list of include paths back to the parent scope
    set(${OUTPUT_VAR} "${COLLECTED_INCLUDE_PATHS}" PARENT_SCOPE)
endfunction()


# --- SANITIZE --- 

function(generate_clean_files OUTPUT_CLEAN_PATHS)
    # The list of files to process is in ARGN
    set(RAW_FILES ${ARGN})
    
    set(CLEANED_PATHS_OUT "")

    foreach(RAW_FILE IN ITEMS ${RAW_FILES})
        get_filename_component(FILE_NAME ${RAW_FILE} NAME)
        get_filename_component(FILE_DIR ${RAW_FILE} DIRECTORY)
        file(RELATIVE_PATH REL_PATH ${PROJECT_ROOT} ${FILE_DIR})

        set(GEN_DIR "${GENERATED_SRC_DIR}/${REL_PATH}")
        file(MAKE_DIRECTORY ${GEN_DIR})

        set(CLEAN_FILE "${GEN_DIR}/${FILE_NAME}") 

        execute_process(
          COMMAND
              sed -e s:odml/litert_lm/::g
                  -e s:odml/litert/::g

              #     -e s:third_party/c/:c/:g
              #     -e s:third_party/runtime/:runtime/:g
              #     -e s:third_party/schema/:schema/:g
              #     -e s:third_party/absl/:third_party/absl/absl/:g
              #     # -e s:json/include/nlohmann/:include/nlohmann/:g
              #     -e s:json/src/json.hpp:json/include/nlohmann/json.hpp:g
              #     -e s:minja/include/minja/google/:minja/include/minja/:g
              #     -e s:third_party/litert/:_deps/litert_lib-src/litert/:g
              #     -e s:litert/litert/:litert/:g
              
          WORKING_DIRECTORY ${PROJECT_ROOT}
          INPUT_FILE ${RAW_FILE}
          OUTPUT_FILE ${CLEAN_FILE}
          # ERROR_FILE "${CLEAN_FILE}_err"
          RESULT_VARIABLE SED_RESULT
        )

        if (SED_RESULT GREATER 0)
            message(FATAL_ERROR "SED failed on file: ${RAW_FILE}")
        endif()
        
        # 6. Append the path to the newly generated file
        list(APPEND CLEANED_PATHS_OUT ${ABS_CLEAN_FILE})
    endforeach()
    
    set(${OUTPUT_CLEAN_PATHS} "${CLEANED_PATHS_OUT}" PARENT_SCOPE)
endfunction()



add_library(MacroFixer INTERFACE)

target_compile_options(MacroFixer INTERFACE 
    $<$<CXX_COMPILER_ID:GNU,Clang>:-include${CMAKE_CURRENT_SOURCE_DIR}/cmake/fix_macros.h>
)




# -------------------------------------------------------------------------
# Function: generate_import_targets
# Args:
#   SEARCH_ROOT: The absolute path to the directory to scan (e.g., third_party)
#   ARGN:        A list of folder names to EXCLUDE (The Blocklist)
# -------------------------------------------------------------------------
function(generate_import_targets SEARCH_ROOT)
    
    # 1. Capture the optional arguments (the exclude list)
    set(EXCLUDE_LIST ${ARGN})

    # 2. Sanity Check
    if(NOT IS_DIRECTORY "${SEARCH_ROOT}")
        message(WARNING "⚠️  [Target Gen] Directory not found: ${SEARCH_ROOT}")
        return()
    endif()

    # 3. Get all subdirectories
    file(GLOB children RELATIVE "${SEARCH_ROOT}" "${SEARCH_ROOT}/*")

    message(STATUS "🤖 [Target Gen] Scanning ${SEARCH_ROOT} for libraries...")

    foreach(child ${children})
        if(IS_DIRECTORY "${SEARCH_ROOT}/${child}")
            
            # --- FILTER: Check against the Blocklist ---
            if("${child}" IN_LIST EXCLUDE_LIST)
                message(VERBOSE "   🚫 Skipping excluded lib: ${child}")
                continue()
            endif()

            # --- DETECTOR: Find the include path ---
            # Heuristic: Prefer 'include/', fallback to root
            set(inc_dir "${SEARCH_ROOT}/${child}/include")
            if(NOT EXISTS "${inc_dir}")
                set(inc_dir "${SEARCH_ROOT}/${child}")
            endif()

            # --- FACTORY: Create the Target ---
            # Naming convention: external::<foldername>
            set(target_name "external::${child}")

            if(NOT TARGET ${target_name})
                add_library(${target_name} INTERFACE IMPORTED)
                set_target_properties(${target_name} PROPERTIES
                    INTERFACE_INCLUDE_DIRECTORIES "${inc_dir}"
                )
                message(STATUS "   ✨ Auto-linked: ${target_name}")
            endif()

        endif()
    endforeach()
endfunction()



add_custom_target(CheckObjects
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/scripts # Ensure output dir exists
    COMMAND ${PYTHON_EXECUTABLE} ${CMAKE_SOURCE_DIR}/scripts/duplicate_check.py
        --build-dir ${CMAKE_BINARY_DIR}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)



macro(add_litert_library target_name lib_type)
    add_library(${target_name} ${lib_type} ${ARGN})
    # Inject the critical build order dependency
    add_dependencies(${target_name} litert_external) 
endmacro()


### [DEPRECATED] [TODO] Refactor to add_litert_library ###
macro(add_litert_static_library target_name)
    add_library(${target_name} STATIC ${ARGN})
    # Inject the critical build order dependency
    add_dependencies(${target_name} litert_external) 
endmacro()

### [DEPRECATED] [TODO] Refactor to add_litert_library ###
macro(add_litert_interface_library target_name)
    add_library(${target_name} INTERFACE ${ARGN})
    # Inject the critical build order dependency
    add_dependencies(${target_name} litert_external) 
endmacro()


macro(add_litert_executable target_name)
    add_executable(${target_name} ${ARGN})
    # Inject the critical build order dependency
    add_dependencies(${target_name} litert_external) 
endmacro()