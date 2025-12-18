include(ExternalProject)

set(FLATBUFFERS_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/flatbuffers)
set(FLATBUFFERS_INSTALL_PREFIX ${FLATBUFFERS_EXT_PREFIX}/install)

ExternalProject_Add(
    flatbuffers_external
    DEPENDS
      absl_external
      googletest_external
    GIT_REPOSITORY https://github.com/google/flatbuffers.git
    GIT_TAG v23.5.26
    PREFIX ${FLATBUFFERS_EXT_PREFIX}
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${FLATBUFFERS_INSTALL_PREFIX}
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_CXX_STANDARD=17
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DFLATBUFFERS_BUILD_TESTS=OFF
        -DFLATBUFFERS_INSTALL=ON
        -DFLATBUFFERS_BUILD_FLATC=ON
        -DFLATBUFFERS_BUILD_FLATHASH=OFF
)

# Export the location for LiteRT to see
set(FLATBUFFERS_DIR "${FLATBUFFERS_INSTALL_PREFIX}/lib/cmake/flatbuffers" CACHE INTERNAL "")
set(FLATC_EXECUTABLE "${FLATBUFFERS_INSTALL_PREFIX}/bin/flatc" CACHE INTERNAL "")




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
