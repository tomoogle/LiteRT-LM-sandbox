include_guard(GLOBAL)
include("${LITERTLM_MODULES_DIR}/utils.cmake")
include("${LITERTLM_PACKAGES_DIR}/packages.cmake")
include("${RE2_PACKAGE_DIR}/re2_target_map.cmake")

macro(generate_re2_aggregate)

    if(NOT TARGET LiteRTLM::re2::re2)

        set(re2_lib_names "")
        set(re2_lib_paths "")
        kvp_parse_map("${RE2_TARGET_MAP}" re2_lib_names re2_lib_paths)

        add_library(LiteRTLM::re2::re2 INTERFACE IMPORTED GLOBAL)
        set_target_properties(LiteRTLM::re2::re2 PROPERTIES
            INTERFACE_LIBRARY_NAMES
                "${_re2_lib_names}"
            INTERFACE_LIBRARY_PATHS
                "${_re2_lib_paths}"
            INTERFACE_LINK_LIBRARIES
                "${_re2_lib_paths}"
        )

        add_library(LiteRTLM::re2::shim INTERFACE IMPORTED GLOBAL)
        set_target_properties(LiteRTLM::re2::shim PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES
                "${RE2_INCLUDE_DIR}"
        )

        
        set(re2_FOUND TRUE CACHE INTERNAL "Forced by LiteRTLM" FORCE)
        set(re2_FOUND TRUE CACHE INTERNAL "Forced by LiteRTLM" FORCE)
    endif()
endmacro()
