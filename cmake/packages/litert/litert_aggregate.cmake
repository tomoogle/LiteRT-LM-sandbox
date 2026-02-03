include_guard(GLOBAL)
include("${LITERTLM_MODULES_DIR}/utils.cmake")
include("${LITERTLM_PACKAGES_DIR}/packages.cmake")
include("${LITERT_PACKAGE_DIR}/litert_target_map.cmake")


macro(generate_litert_aggregate)
    if(NOT TARGET LiteRTLM::litert::litert)
        message(STATUS "[LiteRTLM] Generating the litert aggregate...")
        
        set(_litert_lib_names "")
        set(_litert_lib_paths "")
        kvp_parse_map("${LITERT_TARGET_MAP}" _litert_lib_names _litert_lib_paths)

        add_library(LiteRTLM::litert::litert INTERFACE IMPORTED GLOBAL)
        
        set_target_properties(LiteRTLM::litert::litert PROPERTIES
            INTERFACE_LIBRARY_NAMES
                "${_litert_lib_names}"
            INTERFACE_LIBRARY_PATHS
                "${_litert_lib_paths}"
            INTERFACE_LINK_LIBRARIES
                "${_litert_lib_paths}"
            INTERFACE_INCLUDE_DIRECTORIES
                "${LITERT_INCLUDE_DIR}"
        )
        
        add_library(LiteRTLM::litert::shim INTERFACE IMPORTED GLOBAL)
        set_target_properties(LiteRTLM::litert::shim PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES
                "${LITERT_INCLUDE_DIR};${LITERT_BUILD_DIR}"
        )

        foreach(_comp_target IN LISTS ${_litert_lib_names})
            if(NOT TARGET ${_comp_target})
                add_library(${_comp_target} ALIAS LiteRTLM::litert::shim)
                message(VERBOSE "[LiteRTLM] Redirected ${_comp_target} to litert shim")
            endif()
        endforeach()

        if(NOT TARGET litert_libs)
            add_library(litert_libs ALIAS LiteRTLM::litert::shim)
        endif()

        set(LITERT_FOUND TRUE CACHE BOOL "" FORCE)
        message(STATUS "[LiteRTLM] litert aggregate has been generated.")
    endif()
endmacro()