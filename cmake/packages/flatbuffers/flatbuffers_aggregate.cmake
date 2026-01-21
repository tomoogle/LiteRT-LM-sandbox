add_library(flatbuffers_libs INTERFACE)
target_link_libraries(flatbuffers_libs INTERFACE imp_flatbuffers)
target_include_directories(flatbuffers_libs INTERFACE ${FLATBUFFERS_INCLUDE_DIR})


if(NOT TARGET LiteRTLM::flatbuffers::flatbuffers)
    add_library(LiteRTLM::flatbuffers::flatbuffers INTERFACE IMPORTED GLOBAL)
    target_link_libraries(LiteRTLM::flatbuffers::flatbuffers INTERFACE flatbuffers_libs)
endif()

