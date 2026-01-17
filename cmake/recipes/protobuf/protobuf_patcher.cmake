# protobuf_patcher.cmake

message(STATUS "[LITERTLM PATCHER] Injecting shim into Protobuf root...")

set(ROOT_LIST "${PROTO_SRC_DIR}/CMakeLists.txt")

if(EXISTS "${ROOT_LIST}")
    file(READ "${ROOT_LIST}" CONTENT)
    
    set(INJECTION "include(\"${LITERTLM_PROTO_SHIM_PATH}\")\n")
    
    file(WRITE "${ROOT_LIST}" "${INJECTION}${CONTENT}")
    message(STATUS "[LITERTLM PATCHER] Injection successful.")
else()
    message(FATAL_ERROR "Could not find Protobuf root CMakeLists.txt at ${ROOT_LIST}")
endif()