include("${LITERTLM_MODULES_DIR}/utils.cmake")
include("${LITERTLM_PACKAGES_DIR}/packages.cmake")


add_library(LITERTLM_DEPS INTERFACE)
add_dependencies(LITERTLM_DEPS
    litert_external
    tflite_external
    opencl_headers_external
    re2_external
    tokenizers-cpp_external
    sentencepiece_external
    flatbuffers_external
    litertlm_generated_protobuf
    protobuf_external
    absl_external
)
target_link_libraries(LITERTLM_DEPS INTERFACE
    libpng_lib
    kissfft_lib
    miniaudio_lib
    minizip_lib
    minja_lib
    antlr_lib
    zlib_lib

    LiteRTLM::litert::shim
    LiteRTLM::tflite::shim
    LiteRTLM::tokenizers::tokenizers
    LiteRTLM::sentencepiece::shim
    LiteRTLM::re2::shim
    LiteRTLM::flatbuffers::shim
    LiteRTLM::protobuf::shim
    LiteRTLM::absl::shim

    LiteRTLM::nlohmann_json::nlohmann_json
    opencl_headers_lib
)

target_include_directories(LITERTLM_DEPS SYSTEM INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
)