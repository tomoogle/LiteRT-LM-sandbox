# flatbuffers_target_map

set(FLATBUFFERS_TARGET_MAP
  "flatbuffers::flatbuffers=${FLATBUFFERS_LIB_DIR}/libflatbuffers.a"
  "flatbuffers=${FLATBUFFERS_LIB_DIR}/libflatbuffers.a"
  "flatbuffers::libflatbuffers=${FLATBUFFERS_LIB_DIR}/libflatbuffers.a"
  "libflatbuffers=${FLATBUFFERS_LIB_DIR}/libflatbuffers.a"
)

set(FLATC_TARGET_MAP
  "flatbuffers::flatc=${FLATBUFFERS_BIN_DIR}/flatc"
  "flatc=${FLATBUFFERS_BIN_DIR}/flatc"
)