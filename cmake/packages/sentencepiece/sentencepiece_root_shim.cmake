# sentencepiece_shim.cmake
include_guard(GLOBAL)
message(STATUS "[LiteRTLM] Redirecting SentencePiece dependencies...")

set(SPM_USE_BUILTIN_PROTOBUF OFF CACHE BOOL "" FORCE)
set(SPM_PROTOBUF_PROVIDER "package" CACHE STRING "" FORCE)
set(SPM_ABSL_PROVIDER "package" CACHE STRING "" FORCE)

set(Protobuf_INCLUDE_DIRS ${PROTO_INCLUDE_DIR} CACHE PATH "" FORCE)
set(PROTOBUF_INCLUDE_DIR ${PROTO_INCLUDE_DIR} CACHE PATH "" FORCE)

set(ABSL_SRC_FILE_PATH "${ABSL_SRC_DIR}/absl" CACHE PATH "" FORCE)
set(ABSL_INLUDE_FILE_PATH "${ABSL_INCLUDE_DIR}" CACHE PATH "" FORCE)


include("${LITERTLM_MODULES_DIR}/utils.cmake")
include("${ABSL_PACKAGE_DIR}/absl_aggregate.cmake")
include("${PROTOBUF_PACKAGE_DIR}/protobuf_aggregate.cmake")

add_definitions(-D_GLIBCXX_USE_CXX11_ABI=1)

generate_absl_aggregate()

generate_protobuf_aggregate()



include_directories(${ABSL_INCLUDE_DIR} ${PROTO_INCLUDE_DIR})
# link_libraries(LiteRTLM::absl::shim LiteRTLM::protobuf::shim)



set(CMAKE_CXX_STANDARD_LIBRARIES "${CMAKE_CXX_STANDARD_LIBRARIES} -Wl,--allow-multiple-definition -Wl,--start-group ${_PROTOBUF_PAYLOAD} ${_ABSL_PAYLOAD} -lz -lrt -lpthread -ldl -Wl,--end-group" 
    CACHE STRING "" FORCE
)
