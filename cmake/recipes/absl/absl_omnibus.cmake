# ==============================================================================
# LiteRTLM Omnibus Generator
# ==============================================================================
include_guard(GLOBAL)
include(${ABSL_RECIPE_DIR}/absl_target_map.cmake)

macro(generate_absl_omnibus)
    if(NOT TARGET LiteRTLM::absl::absl)
        message(STATUS "[LiteRTLM] Summoning the Abseil Omnibus...")

        separate_arguments(_ABSL_LIST NATIVE_COMMAND "${ABSL_LIBS_FLAT}")

        add_library(LiteRTLM::absl::absl INTERFACE IMPORTED GLOBAL)
        
        set_target_properties(LiteRTLM::absl::absl PROPERTIES 
            INTERFACE_LINK_LIBRARIES "-Wl,--start-group;${_ABSL_LIST};-Wl,--end-group"
            INTERFACE_INCLUDE_DIRECTORIES "${ABSL_INCLUDE_DIR}"
        )

        set(_ABSL_SINK_ALIASES strings base status statusor cord hash synchronization flags_parse)
        foreach(_comp ${_ABSL_SINK_ALIASES})
            if(NOT TARGET absl::${_comp})
                add_library(absl::${_comp} ALIAS LiteRTLM::absl::absl)
            endif()
        endforeach()
        
        message(STATUS "[LiteRTLM] Abseil Omnibus is now sovereign.")
    endif()
endmacro()
