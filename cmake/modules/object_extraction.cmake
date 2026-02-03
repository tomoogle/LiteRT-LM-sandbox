# --- In cmake/litert.cmake, after ExternalProject_Add ---

# Define a directory for extracted object files
set(LITERT_EXTRACTED_DIR "${CMAKE_BINARY_DIR}/litert_extracted_objects")
file(MAKE_DIRECTORY ${LITERT_EXTRACTED_DIR})

# List of targets whose symbols are failing (C-API and Logging implementations)
set(LITERT_BYPASS_TARGETS litert_c_api litert_logging)

# Variable to hold the actual extracted object filenames (which we need for linking)
set(LITERT_EXTRACTED_OBJECTS "")


# Macro to handle the extraction and collect the object names
macro(extract_target_objects target_name)
    # Define the archive path
    get_target_property(ARCHIVE_PATH ${target_name} IMPORTED_LOCATION)

    # 1. Extraction Custom Command (Runs 'ar x' to dump .o files into the directory)
    add_custom_command(
        OUTPUT ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete
        COMMAND ${CMAKE_COMMAND} -E chdir ${LITERT_EXTRACTED_DIR} ar x ${ARCHIVE_PATH}
        COMMAND ${CMAKE_COMMAND} -E touch ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete
        DEPENDS ${target_name}
        VERBATIM
    )

    # 2. Define a custom target to depend on the extraction
    add_custom_target(${target_name}_extract_objects DEPENDS ${LITERT_EXTRACTED_DIR}/${target_name}_extraction_complete)

    # 3. Add this target to the dependency chain
    add_dependencies(litert_libs ${target_name}_extract_objects)
    
    # TRICKY PART: We need the list of .o files. We'll rely on GLOB for this 
    # specific subdirectory, as we know the archive dumps the files there.
    file(GLOB_RECURSE OBJECT_FILES_TO_LINK "${LITERT_EXTRACTED_DIR}/*.o")
    list(APPEND LITERT_EXTRACTED_OBJECTS ${OBJECT_FILES_TO_LINK})

    # The original target is still defined, but we don't link it below.
endmacro()

# Execute extraction for problematic targets
foreach(target IN LISTS LITERT_BYPASS_TARGETS)
    extract_target_objects(${target})
endforeach()