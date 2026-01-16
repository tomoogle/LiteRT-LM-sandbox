# WARNING: DO NOT USE ANYTHING FROM macros.cmake IN THIS FILE!!

include_guard(GLOBAL)

function(verify_install target_name config_path)
    ExternalProject_Add_Step(${target_name} step_verify_install
        COMMAND ${CMAKE_COMMAND} -E echo "Verifying installation..."
        COMMAND ${CMAKE_COMMAND} -DFILE_TO_CHECK=${config_path} -P "${LITERTLM_SCRIPTS_DIR}/verify_install.cmake"
        DEPENDEES install
        COMMENT "Ensuring ${config_path} was actually generated."
    )
endfunction()


function(generate_src_files OUTPUT_CLEAN_PATHS)
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

        list(APPEND CLEANED_PATHS_OUT ${ABS_CLEAN_FILE})
    endforeach()
    
    set(${OUTPUT_CLEAN_PATHS} "${CLEANED_PATHS_OUT}" PARENT_SCOPE)
endfunction()



function(generate_protobuf TARGET_NAME)
    set(GENERATED_SRCS)
    set(GENERATED_HDRS)


    add_custom_command(
        OUTPUT ""
        COMMAND $<TARGET_FILE:protobuf::protoc>
        ARGS --version
    )

    foreach(PROTO_FILE ${PROTO_FILES})
        file(RELATIVE_PATH REL_PROTO_PATH "${PROJECT_ROOT}" "${PROTO_FILE}")
        
        get_filename_component(REL_DIR "${REL_PROTO_PATH}" DIRECTORY)
        get_filename_component(FIL_WE "${REL_PROTO_PATH}" NAME_WE)

        set(OUT_DIR "${CMAKE_BINARY_DIR}/${REL_DIR}")
        set(SRC_FILE "${OUT_DIR}/${FIL_WE}.pb.cc")
        set(HDR_FILE "${OUT_DIR}/${FIL_WE}.pb.h")

        file(MAKE_DIRECTORY "${OUT_DIR}")

        add_custom_command(
            OUTPUT "${SRC_FILE}" "${HDR_FILE}"
            COMMAND $<TARGET_FILE:protobuf::protoc>
            ARGS --cpp_out "${CMAKE_BINARY_DIR}"
                 -I "${PROJECT_ROOT}" 
                 "${PROTO_FILE}"
                 
            DEPENDS "${PROTO_FILE}" protobuf::protoc
            COMMENT "Generating C++ from ${REL_PROTO_PATH}"
            VERBATIM
        )

        list(APPEND GENERATED_SRCS "${SRC_FILE}")
        list(APPEND GENERATED_HDRS "${HDR_FILE}")
    endforeach()

    target_sources(${TARGET_NAME} PRIVATE ${GENERATED_SRCS} ${GENERATED_HDRS})
endfunction()


function(compile_flatbuffer_files FBS_FILE)
    get_filename_component(FILE_NAME ${FBS_FILE} NAME_WE)
    get_filename_component(FILE_DIR ${FBS_FILE} DIRECTORY)
    
    set(GENERATED_HEADER "${GENERATED_SRC_DIR}/${FILE_DIR}/${FILE_NAME}_generated.h")

    add_custom_command(
        OUTPUT ${GENERATED_HEADER}
        COMMAND ${FLATC_EXECUTABLE} --cpp --gen-object-api --reflect-names --gen-mutable -o "${PROJECT_ROOT}/${FILE_DIR}" "${FBS_FILE}"
        DEPENDS ${FBS_FILE} flatbuffers_external
        COMMENT "Generating C++ header for ${FILE_NAME}.fbs"
    )

    set_source_files_properties(${GENERATED_HEADER} PROPERTIES GENERATED TRUE)
    set(GENERATED_FLATBUFFER_HEADERS ${GENERATED_FLATBUFFER_HEADERS} ${GENERATED_HEADER} PARENT_SCOPE)
endfunction()




function(patch_file_content FILE_PATH MATCH_STR REPLACE_STR IS_REGEX)
    if(EXISTS "${FILE_PATH}")
        file(READ "${FILE_PATH}" CONTENT)
        if(IS_REGEX)
            string(REGEX REPLACE "${MATCH_STR}" "${REPLACE_STR}" CONTENT "${CONTENT}")
        else()
            string(REPLACE "${MATCH_STR}" "${REPLACE_STR}" CONTENT "${CONTENT}")
        endif()
        file(WRITE "${FILE_PATH}" "${CONTENT}")
    endif()
endfunction()





# --- cmake_checkpoint_target ---
#
# Synopsis:
#   cmake_checkpoint_target(<name>
#       [TYPE <Interface|Object|Static|Shared|Executable|Custom>]
#       [GLOBAL]
#       [QUIET]
#       [PROPERTIES <prop> <value>...]
#   )
#
# Description:
#   Enforces the existence of a logical target in the current build graph.
#   If the target does not exist, it creates a "Contract Shim" (Imported Target)
#   to satisfy downstream dependencies without defining an implementation.
#
#   This separates the *Declaration* of a dependency from its *Definition*.
#
# Options:
#   TYPE     : The CMake target type. Defaults to INTERFACE.
#   GLOBAL   : Promotes the shim to Global Scope (visible to all directories).
#              Default is Directory Scope (standard CMake visibility).
#   QUIET    : Suppresses status messages.
#   PROPERTIES: List of properties to apply to the shim.

function(cmake_checkpoint_target TARGET_NAME)
    set(options GLOBAL QUIET)
    set(oneValueArgs TYPE)
    set(multiValueArgs PROPERTIES)
    cmake_parse_arguments(CHK "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    # 1. State Check (Idempotency)
    if(TARGET ${TARGET_NAME})
        # Optional: verify scope visibility here if we wanted to be strict
        if(NOT CHK_QUIET)
             message(STATUS "[Checkpoint] Target '${TARGET_NAME}' satisfied (Existing).")
        endif()
        return()
    endif()

    # 2. Type Normalization
    if(NOT CHK_TYPE)
        set(CHK_TYPE "INTERFACE")
    endif()
    string(TOUPPER "${CHK_TYPE}" CHK_TYPE)

    # 3. Scope Handling
    set(SCOPE_FLAG "")
    if(CHK_GLOBAL)
        set(SCOPE_FLAG "GLOBAL")
    endif()

    # 4. Fulfillment Strategy (The Shim)
    if(CHK_TYPE STREQUAL "CUSTOM")
        # Custom targets are always global in scope by nature in CMake,
        # but we treat them consistently here.
        add_custom_target(${TARGET_NAME})

    elseif(CHK_TYPE STREQUAL "INTERFACE")
        add_library(${TARGET_NAME} INTERFACE IMPORTED ${SCOPE_FLAG})

    elseif(CHK_TYPE MATCHES "^(STATIC|SHARED|MODULE|UNKNOWN)$")
        add_library(${TARGET_NAME} ${CHK_TYPE} IMPORTED ${SCOPE_FLAG})

    elseif(CHK_TYPE STREQUAL "EXECUTABLE")
        add_executable(${TARGET_NAME} IMPORTED ${SCOPE_FLAG})

    else()
        message(FATAL_ERROR "cmake_checkpoint_target: Unsupported TYPE '${CHK_TYPE}'")
    endif()

    # 5. Contract Signing (Properties)
    if(CHK_PROPERTIES)
        set_target_properties(${TARGET_NAME} PROPERTIES ${CHK_PROPERTIES})
    endif()

    # 6. Audit Trail (Metadata)
    set_target_properties(${TARGET_NAME} PROPERTIES
        CHECKPOINT_TYPE "SHIM"
        CHECKPOINT_ORIGIN "${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE}"
    )

    if(NOT CHK_QUIET)
        message(STATUS "[Checkpoint] Created shim for '${TARGET_NAME}' (${CHK_TYPE} ${SCOPE_FLAG})")
    endif()

endfunction()