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




# --- target_checkpoint ---
# Logic: Ensure a target identity is registered in the global manifest.
# Purpose: Prevents configuration-time "Target not found" errors in complex 
#          Directed Acyclic Graphs (DAGs) without requiring specific source logic.
function(target_checkpoint TARGET_NAME)
    set(options QUIET)
    set(oneValueArgs TYPE)
    set(multiValueArgs PROPERTIES)
    cmake_parse_arguments(ARG "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(NOT TARGET ${TARGET_NAME})
        # Fulfillment Strategy
        # Note: We use 'GLOBAL' where possible to ensure the checkpoint 
        # spans the entire project tree, as a checkpoint is a promise of existence.
        if(NOT ARG_TYPE OR ARG_TYPE STREQUAL "CUSTOM")
            add_custom_target(${TARGET_NAME})
        elseif(ARG_TYPE STREQUAL "INTERFACE")
            add_library(${TARGET_NAME} INTERFACE IMPORTED GLOBAL)
        elseif(ARG_TYPE STREQUAL "EXECUTABLE")
            add_executable(${TARGET_NAME} IMPORTED GLOBAL)
        elseif(ARG_TYPE STREQUAL "STATIC_LIBRARY")
            add_library(${TARGET_NAME} STATIC IMPORTED GLOBAL)
        endif()

        # Apply standard target properties if provided
        if(ARG_PROPERTIES)
            set_target_properties(${TARGET_NAME} PROPERTIES ${ARG_PROPERTIES})
        endif()

        # Native Audit Trail (Using standard internal property naming conventions)
        set_target_properties(${TARGET_NAME} PROPERTIES 
            IMPORTED_GENERATED_BY_CHECKPOINT TRUE
            CHECKPOINT_LOCATION "${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE}"
        )

        if(NOT ARG_QUIET)
            message(CONFIGURE_LOG "Target checkpoint fulfilled: ${TARGET_NAME}")
        endif()
    endif()
endfunction()