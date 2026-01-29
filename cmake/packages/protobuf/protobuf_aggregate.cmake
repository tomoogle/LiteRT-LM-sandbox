include_guard(GLOBAL)
include(${LITERTLM_MODULES_DIR}/utils.cmake)
include(${PROTOBUF_PACKAGE_DIR}/protobuf_target_map.cmake)

macro(generate_protobuf_aggregate)
    if(NOT TARGET LiteRTLM::protobuf::libprotobuf)
        message(STATUS "[LiteRTLM] Generating the Protobuf aggregate...")
        set(_protobuf_lib_names "")
        set(_protobuf_lib_paths "")
        kvp_parse_map("${PROTOBUF_TARGET_MAP}" _protobuf_lib_names _protobuf_lib_paths)

        add_library(LiteRTLM::protobuf::libprotobuf INTERFACE IMPORTED GLOBAL)
        set_target_properties(LiteRTLM::protobuf::libprotobuf PROPERTIES
            INTERFACE_LIBRARY_NAMES
                "${_protobuf_lib_names}"
            INTERFACE_LIBRARY_PATHS
                "${_protobuf_lib_paths}"
            INTERFACE_LINK_LIBRARIES
                "-Wl,--start-group -Wl,--whole-archive ${_protobuf_lib_paths} ${_absl_lib_paths} -Wl,--no-whole-archive -Wl,--end-group"
            INTERFACE_INCLUDE_DIRECTORIES
                "${PROTO_INCLUDE_DIR};${ABSL_INCLUDE_DIR}"
        )

        add_library(LiteRTLM::protobuf::shim INTERFACE IMPORTED GLOBAL)        
        set_target_properties(LiteRTLM::protobuf::shim PROPERTIES 
            INTERFACE_INCLUDE_DIRECTORIES
                "${PROTO_INCLUDE_DIR};${ABSL_INCLUDE_DIR}"
        )

        foreach(_comp_target IN LISTS ${_protobuf_lib_names})
            if(NOT TARGET ${_comp_target})
                add_library(${_comp_target} ALIAS LiteRTLM::protobuf::shim)
                message(VERBOSE "[LiteRTLM] Redirected ${_comp_target} to aggregate")
            endif()
        endforeach()

        if(NOT TARGET protobuf::libprotobuf)
            add_library(protobuf::libprotobuf ALIAS LiteRTLM::protobuf::shim)
        endif()


        if(NOT TARGET protobuf::protoc)
            add_executable(protobuf::protoc IMPORTED GLOBAL)
            set_target_properties(protobuf::protoc PROPERTIES
                IMPORTED_LOCATION "${PROTO_PROTOC_EXECUTABLE}"
            )
        endif()

        get_target_property(_PROTOBUF_PAYLOAD LiteRTLM::protobuf::libprotobuf INTERFACE_LINK_LIBRARIES)
        string(REPLACE ";" " " _PROTOBUF_LINK_FLAGS "${_PROTOBUF_PAYLOAD}")

        message(STATUS "[LiteRTLM] Protobuf aggregate has been generated.")
    endif()
endmacro()

