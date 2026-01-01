add_library(LITERTLM_DEPS INTERFACE)
add_dependencies(LITERTLM_DEPS litert_external)
target_link_libraries(LITERTLM_DEPS INTERFACE
    opencl_headers_lib
    absl_libs
    flatbuffers_libs
    antlr_lib
    libpng_lib
    kissfft_lib
    miniaudio_lib
    minizip_lib
    minja_lib
    json_lib
    zlib_lib
    re2_libs
    sentencepiece_libs
    tflite_libs
    proto_lib
)

target_include_directories(LITERTLM_DEPS INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
)
