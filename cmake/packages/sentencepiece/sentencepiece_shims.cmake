# sentencepiece_shim.cmake
include_guard(GLOBAL)
message(STATUS "[LiteRTLM] Redirecting SentencePiece dependencies...")


include("${LITERTLM_MODULES_DIR}/utils.cmake")
include("${ABSL_PACKAGE_DIR}/absl_aggregate.cmake")
include("${PROTOBUF_PACKAGE_DIR}/protobuf_aggregate.cmake")

message(STATUS "DEBUG: ABSL_TARGET_MAP IS: '${ABSL_TARGET_MAP}'")
message(STATUS "DEBUG: PROTOBUF_TARGET_MAP IS: '${PROTOBUF_TARGET_MAP}'")

generate_absl_aggregate()

generate_protobuf_aggregate()


set(SPM_USE_BUILTIN_PROTOBUF OFF CACHE BOOL "" FORCE)
set(SPM_PROTOBUF_PROVIDER "package" CACHE STRING "" FORCE)
set(SPM_ABSL_PROVIDER "package" CACHE STRING "" FORCE)

set(Protobuf_INCLUDE_DIRS ${PROTO_INCLUDE_DIR} CACHE PATH "" FORCE)
set(PROTOBUF_INCLUDE_DIR ${PROTO_INCLUDE_DIR} CACHE PATH "" FORCE)

set(ABSL_SRC_FILE_PATH "${ABSL_SRC_DIR}/absl" CACHE PATH "" FORCE)
set(ABSL_INLUDE_FILE_PATH "${ABSL_INCLUDE_DIR}" CACHE PATH "" FORCE)





message(STATUS "DEBUG: ABSL FLAGS ARE: '${_ABSL_LINK_FLAGS}'")
message(STATUS "DEBUG: PROTO FLAGS ARE: '${_PROTOBUF_LINK_FLAGS}'")

if("${_ABSL_LINK_FLAGS}" STREQUAL "")
    message(FATAL_ERROR "The Macro ran, but _ABSL_LINK_FLAGS is still empty!")
endif()



set(PROTOBUF_SRC_FILE_PATH "${PROTO_SRC_DIR}/src/google/protobuf" CACHE PATH "" FORCE)
set(PROTOBUF_LITE_SRCS
    ${PROTOBUF_SRC_FILE_PATH}/arena.cc
    ${PROTOBUF_SRC_FILE_PATH}/arenastring.cc
    ${PROTOBUF_SRC_FILE_PATH}/bytestream.cc
    ${PROTOBUF_SRC_FILE_PATH}/coded_stream.cc
    ${PROTOBUF_SRC_FILE_PATH}/common.cc
    ${PROTOBUF_SRC_FILE_PATH}/extension_set.cc
    ${PROTOBUF_SRC_FILE_PATH}/generated_enum_util.cc
    ${PROTOBUF_SRC_FILE_PATH}/generated_message_table_driven_lite.cc
    ${PROTOBUF_SRC_FILE_PATH}/generated_message_util.cc
    ${PROTOBUF_SRC_FILE_PATH}/implicit_weak_message.cc
    ${PROTOBUF_SRC_FILE_PATH}/int128.cc
    ${PROTOBUF_SRC_FILE_PATH}/io_win32.cc
    ${PROTOBUF_SRC_FILE_PATH}/message_lite.cc
    ${PROTOBUF_SRC_FILE_PATH}/parse_context.cc
    ${PROTOBUF_SRC_FILE_PATH}/repeated_field.cc
    ${PROTOBUF_SRC_FILE_PATH}/status.cc
    ${PROTOBUF_SRC_FILE_PATH}/statusor.cc
    ${PROTOBUF_SRC_FILE_PATH}/stringpiece.cc
    ${PROTOBUF_SRC_FILE_PATH}/stringprintf.cc
    ${PROTOBUF_SRC_FILE_PATH}/structurally_valid.cc
    ${PROTOBUF_SRC_FILE_PATH}/strutil.cc
    ${PROTOBUF_SRC_FILE_PATH}/time.cc
    ${PROTOBUF_SRC_FILE_PATH}/wire_format_lite.cc
    ${PROTOBUF_SRC_FILE_PATH}/zero_copy_stream.cc
    ${PROTOBUF_SRC_FILE_PATH}/zero_copy_stream_impl.cc
    ${PROTOBUF_SRC_FILE_PATH}/zero_copy_stream_impl_lite.cc
    CACHE PATH "" FORCE
)


# if(NOT TARGET LiteRTLM::absl::absl)
#     separate_arguments(_ABSL_LIST NATIVE_COMMAND "${LITERTLM_ABSL_LIBS_FLAT}")
#     add_library(LiteRTLM::absl::absl INTERFACE IMPORTED GLOBAL)
#     set_target_properties(LiteRTLM::absl::absl PROPERTIES 
#         INTERFACE_LINK_LIBRARIES "-Wl,--start-group;${_ABSL_LIST};-Wl,--end-group"
#         INTERFACE_INCLUDE_DIRECTORIES "${LITERTLM_ABSL_INCLUDE_DIRS}"
#     )
# endif()

# if(NOT TARGET LiteRTLM::protobuf::libprotobuf)
#     add_library(LiteRTLM::protobuf::libprotobuf INTERFACE IMPORTED GLOBAL)
#     set_target_properties(LiteRTLM::protobuf::libprotobuf PROPERTIES 
#         INTERFACE_LINK_LIBRARIES "${PROTO_LIB_DIR}/libprotobuf.a;LiteRTLM::absl::absl"
#         INTERFACE_INCLUDE_DIRECTORIES "${PROTO_INCLUDE_DIR}"
#     )
# endif()

# if(NOT TARGET protobuf::libprotobuf)
#     add_library(protobuf::libprotobuf ALIAS LiteRTLM::protobuf::libprotobuf)
# endif()

# if(NOT TARGET protobuf::libprotobuf-lite)
#     add_library(protobuf::libprotobuf-lite ALIAS LiteRTLM::protobuf::libprotobuf)
# endif()




include_directories(${ABSL_INCLUDE_DIR} ${PROTO_INCLUDE_DIR})




set(CMAKE_CXX_STANDARD_LIBRARIES 
    "${CMAKE_CXX_STANDARD_LIBRARIES} -Wl,--start-group -Wl,--whole-archive ${_PROTOBUF_LINK_FLAGS} ${_ABSL_LINK_FLAGS} -Wl,--no-whole-archive -Wl,--end-group" 
    CACHE STRING "Forced Abseil and Protobuf aggregates for SentencePiece internal linking" FORCE
)
