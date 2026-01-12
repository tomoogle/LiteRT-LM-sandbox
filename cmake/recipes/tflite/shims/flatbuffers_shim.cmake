if(NOT TARGET LiteRTLM::flatbuffers::flatbuffers)
    add_library(LiteRTLM::flatbuffers::flatbuffers INTERFACE IMPORTED GLOBAL)
    set_target_properties(LiteRTLM::flatbuffers::flatbuffers PROPERTIES 
        INTERFACE_LINK_LIBRARIES "imp_flatbuffers"
        INTERFACE_INCLUDE_DIRECTORIES "${FLATBUFFERS_INCLUDE_DIR}"
    )

    # Alias the names TFLite actually uses
    add_library(flatbuffers::flatbuffers ALIAS LiteRTLM::flatbuffers::flatbuffers)
endif()

# 2. Bridge the FLATC compiler using the CACHE INTERNAL var you just verified
if(NOT TARGET flatbuffers-flatc)
    add_executable(flatbuffers-flatc IMPORTED GLOBAL)
    set_target_properties(flatbuffers-flatc PROPERTIES 
        IMPORTED_LOCATION "${FLATC_EXECUTABLE}"
    )
endif()

if(NOT TARGET flatbuffers-flatc-NOTFOUND)
    add_executable(flatbuffers-flatc-NOTFOUND IMPORTED GLOBAL)
    set_target_properties(flatbuffers-flatc-NOTFOUND PROPERTIES 
        IMPORTED_LOCATION "${FLATC_EXECUTABLE}"
    )
endif()

set(FLATC_TARGET "${FLATC_EXECUTABLE}" CACHE INTERNAL "" FORCE)

# 3. Final spoofing for TFLite's internal checks
set(flatbuffers_FLATC_EXECUTABLE "${FLATC_EXECUTABLE}")
set(FLATBUFFERS_FLATC_EXECUTABLE "${FLATC_EXECUTABLE}")
set(flatbuffers_FOUND TRUE CACHE INTERNAL "")


message(STATUS "LITERTLM: Commencing surgical strike on kernels/CMakeLists.txt")

execute_process(
    COMMAND sed -i "1,/set(FLATBUFFERS_FLATC_SCHEMA_EXTRA_ARGS/ { /set(FLATBUFFERS_FLATC_SCHEMA_EXTRA_ARGS/!d }" 
    "${TENSORFLOW_SOURCE_DIR}/tensorflow/lite/kernels/CMakeLists.txt"
)

execute_process(
    COMMAND sed -i "1s|^|set(FLATBUFFERS_FLATC_EXECUTABLE \"${FLATC_EXECUTABLE}\")\\n|" "${TENSORFLOW_SOURCE_DIR}/tensorflow/lite/kernels/CMakeLists.txt"
    RESULT_VARIABLE patch_result2
)

# Combine the results for your check
math(EXPR patch_result "${patch_result1} + ${patch_result2}")

if(NOT patch_result EQUAL 0)
    message(FATAL_ERROR "LITERTLM: Failed to decapitate the Kernels check!")
endif()