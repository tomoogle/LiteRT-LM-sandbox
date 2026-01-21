# ==============================================================================
# LiteRTLM Omnibus Generator
# ==============================================================================
include_guard(GLOBAL)
include(${LITERTLM_MODULES_DIR}/utils.cmake)
include(${ABSL_RECIPE_DIR}/absl_target_map.cmake)

macro(generate_absl_omnibus)
    message(STATUS "[TRAP] generate_absl_omnibus called.")
    
    if(TARGET LiteRTLM::absl::absl)
        message(STATUS "[TRAP] Target already exists. Skipping logic!")
        # This tests Theory 3 (The Guard Trap)
    else()
        message(STATUS "[TRAP] Target does not exist. Initializing...")
        
        # Theory 1 & 2 Check
        message(STATUS "[TRAP] RAW MAP: ${ABSL_TARGET_MAP}")
        
        set(_test_names "")
        set(_test_paths "")
        kvp_parse_map("${ABSL_TARGET_MAP}" _test_names _test_paths)
        
        message(STATUS "[TRAP] NAMES FOUND: ${_test_names}")
        message(STATUS "[TRAP] PATHS FOUND: ${_test_paths}")
        if(NOT TARGET LiteRTLM::absl::absl)
            message(STATUS "[LiteRTLM] Generating the Abseil Omnibus...")
            set(_absl_lib_names "")
            set(_absl_lib_paths "")
            kvp_parse_map("${ABSL_TARGET_MAP}" _absl_lib_names _absl_lib_paths)

            add_library(LiteRTLM::absl::absl INTERFACE IMPORTED GLOBAL)
            
            set_target_properties(LiteRTLM::absl::absl PROPERTIES 
                INTERFACE_LINK_LIBRARIES
                    "-Wl,--start-group -Wl,--whole-archive ${_absl_lib_paths} -Wl,--no-whole-archive -Wl,--end-group"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${ABSL_INCLUDE_DIR}"
            )

            foreach(_comp_target IN ITEMS ${_absl_lib_names})
                if(NOT TARGET ${_comp_target})
                    add_library(${_comp_target} ALIAS LiteRTLM::absl::absl)
                    message(VERBOSE "[LiteRTLM] Redirected ${_comp_target} to Omnibus")
                endif()
            endforeach()


            set(_missing_libs
                "absl::absl_check"
                "absl::absl_log"
                "absl::algorithm"
                "absl::bind_front"
                "absl::bits"
                "absl::btree"
                "absl::cleanup"
                "absl::core_headers"
                "absl::debugging"
                "absl::dynamic_annotations"
                "absl::flags"
                "absl::flat_hash_map"
                "absl::flat_hash_set"
                "absl::function_ref"
                "absl::layout"
                "absl::memory"
                "absl::node_hash_map"
                "absl::node_hash_set"
                "absl::optional"
                "absl::random_random"
                "absl::span"
                "absl::type_traits"
                "absl::utility"
            )

            foreach(_missing_target IN ITEMS ${_missing_libs})
                if(NOT TARGET ${_missing_target})
                    add_library(${_missing_target} ALIAS LiteRTLM::absl::absl)
                    message(VERBOSE "[LiteRTLM] Redirected ${_missing_target} to Omnibus")
                endif()
            endforeach()



            get_target_property(_ABSL_PAYLOAD LiteRTLM::absl::absl INTERFACE_LINK_LIBRARIES)
            string(REPLACE ";" " " _ABSL_LINK_FLAGS "${_ABSL_PAYLOAD}")
            message(STATUS "[LiteRTLM] Abseil Omnibus has been generated.")
        endif()
    endif()
endmacro()

