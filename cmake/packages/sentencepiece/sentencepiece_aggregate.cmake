include_guard(GLOBAL)
include("${LITERTLM_MODULES_DIR}/utils.cmake")
include("${LITERTLM_PACKAGES_DIR}/packages.cmake")
include(${SENTENCEPIECE_PACKAGE_DIR}/sentencepiece_target_map.cmake)


macro(generate_sentencepiece_aggregate)
    if(NOT TARGET LiteRTLM::sentencepiece::sentencepiece)
        message(STATUS "[LiteRTLM] Generating the litert aggregate...")
        
        set(_sentencepiece_lib_names "")
        set(_sentencepiece_lib_paths "")
        kvp_parse_map("${SENTENCEPIECE_TARGET_MAP}" _sentencepiece_lib_names _sentencepiece_lib_paths)

        add_library(LiteRTLM::sentencepiece::sentencepiece INTERFACE IMPORTED GLOBAL)
        
        set_target_properties(LiteRTLM::sentencepiece::sentencepiece PROPERTIES 
            INTERFACE_LIBRARY_NAMES
                "${_sentencepiece_lib_names}"
            INTERFACE_LIBRARY_PATHS
                "${_sentencepiece_lib_paths}"
            INTERFACE_LINK_LIBRARIES
                "-Wl,--start-group -Wl,--whole-archive ${_sentencepiece_lib_paths} -Wl,--no-whole-archive -lz -lrt -lpthread -ldl -Wl,--end-group"
            INTERFACE_INCLUDE_DIRECTORIES
                "${SENTENCEPIECE_INCLUDE_DIR}"
        )
        
        add_library(LiteRTLM::sentencepiece::shim INTERFACE IMPORTED GLOBAL)
        set_target_properties(LiteRTLM::sentencepiece::shim PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES
                "${SENTENCEPIECE_INCLUDE_DIR};${SENTENCEPIECE_BUILD_DIR}"
        )

        foreach(_comp_target IN LISTS ${_sentencepiece_lib_names})
            if(NOT TARGET ${_comp_target})
                add_library(${_comp_target} ALIAS LiteRTLM::sentencepiece::shim)
                message(VERBOSE "[LiteRTLM] Redirected ${_comp_target} to litert shim")
            endif()
        endforeach()

        if(NOT TARGET sentencepiece_libs)
            add_library(sentencepiece_libs ALIAS LiteRTLM::sentencepiece::sentencepiece)
        endif()

        set(SENTENCEPIECE_FOUND TRUE CACHE BOOL "" FORCE)
        message(STATUS "[LiteRTLM] litert aggregate has been generated.")
    endif()
endmacro()