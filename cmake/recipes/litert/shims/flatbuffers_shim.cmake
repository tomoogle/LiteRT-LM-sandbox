    # FlatBuffers
    set(FLATBUFFERS_BUILD_FLATC "OFF")
    set(FLATBUFFERS_INSTALL "OFF")
    set(FLATBUFFERS_PROJECT_DIR "${FLATBUFFERS_SRC_DIR}/flatbuffers_external")
    set(FlatBuffers_BINARY_DIR "${FLATBUFFERS_BIN_DIR}")
    set(FlatBuffers_SOURCE_DIR "${FLATBUFFERS_SRC_DIR}/flatbuffers_external")
    set(_flatbuffers_LICENSE_FILE:FILEPATH "${FLATBUFFERS_SRC_DIR}/flatbuffers_external/LICENSE")
    set(FLATC_PATHS "${FLATBUFFERS_BIN_DIR}")
    set(FLATBUFFERS_FLATC_EXECUTABLE "${FLATC_EXECUTABLE}")
    set(FLATC_EXECUTABLE "${FLATC_EXECUTABLE}")
    set(flatbuffers_DIR "${FLATBUFFERS_INSTALL_PREFIX}/lib/cmake/flatbuffers")
    set(FETCHCONTENT_SOURCE_DIR_FLATBUFFERS "${FLATBUFFERS_SRC_DIR}/flatbuffers_external")
    