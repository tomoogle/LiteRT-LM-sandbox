include_guard(GLOBAL)

include("${FLATBUFFERS_PACKAGE_DIR}/flatbuffers_target_map.cmake")


macro(generate_flatbuffers_aggregate)
    if(NOT TARGET LiteRTLM::flatbuffers::flatbuffers)
        message(STATUS "[LiteRTLM] Generating the Flatbuffers aggregate...")
        set(_flatbuffers_lib_names "")
        set(_flatbuffers_lib_paths "")
        kvp_parse_map("${FLATBUFFERS_TARGET_MAP}" _flatbuffers_lib_names _flatbuffers_lib_paths)

        add_library(LiteRTLM::flatbuffers::flatbuffers INTERFACE IMPORTED GLOBAL)
        set_target_properties(LiteRTLM::flatbuffers::flatbuffers PROPERTIES
            INTERFACE_LIBRARY_NAMES
                "${_flatbuffers_lib_names}"
            INTERFACE_LIBRARY_PATHS
                "${_flatbuffers_lib_paths}"
            INTERFACE_LINK_LIBRARIES 
                "-Wl,--start-group ${_flatbuffers_lib_paths} -Wl,--end-group"
            INTERFACE_INCLUDE_DIRECTORIES 
                "${FLATBUFFERS_INCLUDE_DIR}"
        )

        add_library(LiteRTLM::flatbuffers::shim INTERFACE IMPORTED GLOBAL)        
        set_target_properties(LiteRTLM::flatbuffers::shim PROPERTIES 
            INTERFACE_INCLUDE_DIRECTORIES "${FLATBUFFERS_INCLUDE_DIR}"
        )

        foreach(_comp_target IN LISTS ${_flatbuffers_lib_names})
            if(NOT TARGET ${_comp_target})
                add_library(${_comp_target} ALIAS LiteRTLM::flatbuffers::shim)
                message(VERBOSE "[LiteRTLM] Redirected ${_comp_target} to aggregate")
            endif()
        endforeach()


        get_target_property(_FLATBUFFERS_PAYLOAD LiteRTLM::flatbuffers::flatbuffers INTERFACE_LINK_LIBRARIES)
        string(REPLACE ";" " " _FLATBUFFERS_LINK_FLAGS "${_FLATBUFFERS_PAYLOAD}")


        # Force-feed the "Found" variables so internal FindFlatbuffers.cmake doesn't run
        set(FlatBuffers_FOUND TRUE CACHE INTERNAL "Forced by LiteRTLM" FORCE)
        set(flatbuffers_FOUND TRUE CACHE INTERNAL "Forced by LiteRTLM" FORCE)
        message(STATUS "[LiteRTLM] Flatbuffers aggregate has been generated.")
    endif()
endmacro()


macro(generate_flatc_aggregate)
    if(NOT TARGET LiteRTLM::flatbuffers::flatc)
        message(STATUS "[LiteRTLM] Generating the flatc aggregate...")
        set(_flatc_lib_names "")
        set(_flatc_lib_paths "")
        kvp_parse_map("${FLATC_TARGET_MAP}" _flatc_lib_names _flatc_lib_paths)

        add_library(LiteRTLM::flatbuffers::flatc INTERFACE IMPORTED GLOBAL)
        set_target_properties(LiteRTLM::flatbuffers::flatc PROPERTIES
            INTERFACE_LINK_LIBRARIES 
                "${_flatc_lib_paths}"
            INTERFACE_INCLUDE_DIRECTORIES 
                "${FLATC_INCLUDE_DIR}"
        )
        

        add_library(LiteRTLM::flatc::shim INTERFACE IMPORTED GLOBAL)        
        set_target_properties(LiteRTLM::flatc::shim PROPERTIES 
            INTERFACE_INCLUDE_DIRECTORIES "${FLATC_INCLUDE_DIR}"
        )


        foreach(_comp_target IN LISTS ${_flatc_lib_names})
            if(NOT TARGET ${_comp_target})
                add_library(${_comp_target} ALIAS LiteRTLM::flatc::shim)
                message(VERBOSE "[LiteRTLM] Redirected ${_comp_target} to aggregate")
            endif()
        endforeach()

        get_target_property(_FLATC_PAYLOAD LiteRTLM::flatbuffers::flatc INTERFACE_LINK_LIBRARIES)
        string(REPLACE ";" " " _FLATC_LINK_FLAGS "${_FLATC_PAYLOAD}")


        # Force-feed the "Found" variables so internal FindFlatbuffers.cmake doesn't run
        set(FlatC_FOUND TRUE CACHE INTERNAL "Forced by LiteRTLM" FORCE)
        set(flatc_FOUND TRUE CACHE INTERNAL "Forced by LiteRTLM" FORCE)
        message(STATUS "[LiteRTLM] flatc aggregate has been generated.")
    endif()
endmacro()