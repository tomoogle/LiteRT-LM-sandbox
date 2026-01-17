add_library(LITERTLM_DEPS INTERFACE)
add_dependencies(LITERTLM_DEPS litert_external)

target_link_libraries(LITERTLM_DEPS INTERFACE
    LiteRTLM::litert::litert           # Depends on TFLite, Abseil, FlatBuffers
    LiteRTLM::tflite::tflite           # Depends on Abseil, FlatBuffers, Ruy
    
    LiteRTLM::tokenizers::tokenizers    # Depends on Abseil, Protobuf
    LiteRTLM::sentencepiece::sentencepiece        # Depends on SentencePiece
    LiteRTLM::re2::re2              # Depends on Abseil

    opencl_headers_lib
    libpng_lib
    kissfft_lib
    miniaudio_lib
    minizip_lib
    minja_lib
    zlib_lib

    LiteRTLM::nlohmann_json::nlohmann_json
    LiteRTLM::protobuf::libprotobuf
    LiteRTLM::flatbuffers::flatbuffers
    LiteRTLM::absl::absl
)

target_include_directories(LITERTLM_DEPS SYSTEM INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
)