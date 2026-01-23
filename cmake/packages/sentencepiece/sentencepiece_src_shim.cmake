
include_directories(${ABSL_INCLUDE_DIR} ${PROTO_INCLUDE_DIR})
link_libraries(LiteRTLM::absl::shim LiteRTLM::protobuf::shim)



# set(CMAKE_CXX_STANDARD_LIBRARIES "${CMAKE_CXX_STANDARD_LIBRARIES} -Wl,--allow-multiple-definition ${_PROTOBUF_LINK_FLAGS} -lz -lrt -lpthread -ldl" 
#     CACHE STRING "" FORCE
# )


# set(PROTOBUF_SRC_FILE_PATH "${PROTO_SRC_DIR}/src/google/protobuf" CACHE PATH "" FORCE)
# set(PROTOBUF_LITE_SRCS
#     ${PROTOBUF_SRC_FILE_PATH}/arena.cc
#     ${PROTOBUF_SRC_FILE_PATH}/arenastring.cc
#     ${PROTOBUF_SRC_FILE_PATH}/bytestream.cc
#     ${PROTOBUF_SRC_FILE_PATH}/coded_stream.cc
#     ${PROTOBUF_SRC_FILE_PATH}/common.cc
#     ${PROTOBUF_SRC_FILE_PATH}/extension_set.cc
#     ${PROTOBUF_SRC_FILE_PATH}/generated_enum_util.cc
#     ${PROTOBUF_SRC_FILE_PATH}/generated_message_table_driven_lite.cc
#     ${PROTOBUF_SRC_FILE_PATH}/generated_message_util.cc
#     ${PROTOBUF_SRC_FILE_PATH}/implicit_weak_message.cc
#     ${PROTOBUF_SRC_FILE_PATH}/int128.cc
#     ${PROTOBUF_SRC_FILE_PATH}/io_win32.cc
#     ${PROTOBUF_SRC_FILE_PATH}/message_lite.cc
#     ${PROTOBUF_SRC_FILE_PATH}/parse_context.cc
#     ${PROTOBUF_SRC_FILE_PATH}/repeated_field.cc
#     ${PROTOBUF_SRC_FILE_PATH}/status.cc
#     ${PROTOBUF_SRC_FILE_PATH}/statusor.cc
#     ${PROTOBUF_SRC_FILE_PATH}/stringpiece.cc
#     ${PROTOBUF_SRC_FILE_PATH}/stringprintf.cc
#     ${PROTOBUF_SRC_FILE_PATH}/structurally_valid.cc
#     ${PROTOBUF_SRC_FILE_PATH}/strutil.cc
#     ${PROTOBUF_SRC_FILE_PATH}/time.cc
#     ${PROTOBUF_SRC_FILE_PATH}/wire_format_lite.cc
#     ${PROTOBUF_SRC_FILE_PATH}/zero_copy_stream.cc
#     ${PROTOBUF_SRC_FILE_PATH}/zero_copy_stream_impl.cc
#     ${PROTOBUF_SRC_FILE_PATH}/zero_copy_stream_impl_lite.cc
#     CACHE PATH "" FORCE
# )