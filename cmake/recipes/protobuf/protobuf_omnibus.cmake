include_guard(GLOBAL)
include(${LITERTLM_MODULES_DIR}/utils.cmake)
include(${PROTOBUF_RECIPE_DIR}/protobuf_target_map.cmake)

macro(generate_protobuf_omnibus)
    if(NOT TARGET LiteRTLM::protobuf::libprotobuf)
        message(STATUS "[LiteRTLM] Generating the Protobuf Omnibus...")
        set(_protobuf_lib_names "")
        set(_protobuf_lib_paths "")
        kvp_parse_map("${PROTOBUF_TARGET_MAP}" _protobuf_lib_names _protobuf_lib_paths)

        add_library(LiteRTLM::protobuf::libprotobuf INTERFACE IMPORTED GLOBAL)
        
        set_target_properties(LiteRTLM::protobuf::libprotobuf PROPERTIES 
            INTERFACE_LINK_LIBRARIES
                "-Wl,--start-group -Wl,--whole-archive ${_protobuf_lib_paths} ${_absl_lib_paths} -Wl,--no-whole-archive -Wl,--end-group"
            INTERFACE_INCLUDE_DIRECTORIES
                "${PROTO_INCLUDE_DIR}"
        )

        foreach(_comp_target IN LISTS _protobuf_lib_names)
            if(NOT TARGET ${_comp_target})
                add_library(${_comp_target} ALIAS LiteRTLM::protobuf::libprotobuf)
                message(VERBOSE "[LiteRTLM] Redirected ${_comp_target} to Omnibus")
            endif()
        endforeach()

        get_target_property(_PROTOBUF_PAYLOAD LiteRTLM::protobuf::libprotobuf INTERFACE_LINK_LIBRARIES)
        string(REPLACE ";" " " _PROTOBUF_LINK_FLAGS "${_PROTOBUF_PAYLOAD}")

        message(STATUS "[LiteRTLM] Protobuf Omnibus has been generated.")
    endif()
endmacro()

