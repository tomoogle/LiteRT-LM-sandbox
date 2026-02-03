# protobuf_patcher.cmake

message(STATUS "[LITERTLM PATCHER] Injecting shim into Protobuf root...")

set(ROOT_LIST "${PROTO_SRC_DIR}/CMakeLists.txt")

if(EXISTS "${ROOT_LIST}")
    file(READ "${ROOT_LIST}" CONTENT)
    
    # set(INJECTION "include(${LITERTLM_PROTO_SHIM_PATH})\n")

    string(REPLACE "project(protobuf C CXX)" 
               "project(protobuf C CXX)\ninclude(${LITERTLM_PROTO_SHIM_PATH})" 
               CONTENT "${CONTENT}")

    
    file(WRITE "${ROOT_LIST}" "${INJECTION}${CONTENT}")
    message(STATUS "[LITERTLM PATCHER] Injection successful.")
else()
    message(FATAL_ERROR "Could not find Protobuf root CMakeLists.txt at ${ROOT_LIST}")
endif()



# List of files to de-classify from "Hidden"
set(_proto_cmake_files
    "cmake/libupb.cmake"
    "cmake/libprotoc.cmake"
    "cmake/libprotobuf.cmake"
    "cmake/libprotobuf-lite.cmake"
)

foreach(_file IN LISTS _proto_cmake_files)
    set(_path "${PROTO_SRC_DIR}/${_file}")
    if(EXISTS "${_path}")
        message(STATUS "[LiteRTLM] Patching visibility in ${_file}")
        file(READ "${_path}" _content)
        
        # Replace the preset
        string(REPLACE "CXX_VISIBILITY_PRESET hidden" "CXX_VISIBILITY_PRESET default" _content "${_content}")
        
        # Disable the inline hiding
        string(REPLACE "VISIBILITY_INLINES_HIDDEN ON" "VISIBILITY_INLINES_HIDDEN OFF" _content "${_content}")
        
        file(WRITE "${_path}" "${_content}")
    endif()
endforeach()