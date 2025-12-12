## flatbuffers.cmake
function(compile_flatbuffer_files flatb_files)

    set(output_dir "${GENERATED_SRC_DIR}/schema/core")

    file(MAKE_DIRECTORY "${output_dir}")

    foreach(fbf ${flatb_files})
        get_filename_component(fbf_name ${fbf} NAME)
        
        message(STATUS " [FlatBuffers] Generating header for ${fbf_name}...")

        execute_process(
            COMMAND flatc --gen-mutable --gen-object-api --cpp -o "${output_dir}/" "${fbf}"
            WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
            RESULT_VARIABLE ret_code
            OUTPUT_VARIABLE flatc_output
            ERROR_VARIABLE flatc_error
        )

        if(NOT "${ret_code}" STREQUAL "0")
            message(FATAL_ERROR "flatc failed for ${fbf}: ${flatc_error}")
        endif()

    endforeach()

endfunction()
