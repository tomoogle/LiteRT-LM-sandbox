include_guard(GLOBAL)

macro(generate_local_aggregate)
    if(NOT TARGET LiteRTLM::Local::Aggregate)
        message(STATUS "[LiteRTLM] Generating Local Aggregate...")



        # 1. Read the Registry (The "Map")
        get_property(_local_lib_paths GLOBAL PROPERTY LITERTLM_LOCAL_ARCHIVE_REGISTRY)
        
        # 2. Create the Interface Target
        add_library(LiteRTLM::Local::Aggregate INTERFACE IMPORTED GLOBAL)


        # 3. The Nuclear Payload (Exact SentencePiece Pattern)
        # Note: We rely on CMake's list expansion within the string to handle the paths.
        # set_target_properties(LiteRTLM::Local::Aggregate PROPERTIES 
        #     INTERFACE_LINK_LIBRARIES
        #         "-Wl,--allow-multiple-definition -Wl,--start-group -Wl,--whole-archive ${_local_lib_paths} ${_litert_lib_paths} ${_tflite_lib_paths} ${_sentencepiece_lib_paths} ${_re2_lib_paths} ${_flatbuffers_lib_paths} ${_protobuf_lib_paths} ${_absl_lib_paths} -lz -lrt -lpthread -ldl -Wl,--end-group"
        # )
        set_target_properties(LiteRTLM::Local::Aggregate PROPERTIES 
            INTERFACE_LINK_LIBRARIES
                "${_local_lib_paths} ${_litert_lib_paths} ${_tflite_lib_paths} ${_tokenizers_lib_path} ${_sentencepiece_lib_paths} ${_re2_lib_paths} ${_flatbuffers_lib_paths} ${_protobuf_lib_paths} ${_absl_lib_paths}"
        
        )
        set_target_properties(LiteRTLM::Local::Aggregate PROPERTIES 
            INTERFACE_LINK_LIBRARIES_CORE
                "${_tokenizers_lib_path} ${_sentencepiece_lib_paths} ${_re2_lib_paths} ${_flatbuffers_lib_paths} ${_protobuf_lib_paths} ${_absl_lib_paths}"
        )
        set_target_properties(LiteRTLM::Local::Aggregate PROPERTIES 
            INTERFACE_LINK_LIBRARIES_ODML
                "${_local_lib_paths} ${_litert_lib_paths} ${_tflite_lib_paths}"
        )

        get_property(_local_targets GLOBAL PROPERTY LITERTLM_LOCAL_TARGET_REGISTRY)
        if(NOT TARGET litertlm_local_anchor)
            add_custom_target(litertlm_local_anchor DEPENDS ${_local_targets})
        endif()
        add_dependencies(LiteRTLM::Local::Aggregate litertlm_local_anchor)

        get_target_property(_LITERTLM_PAYLOAD LiteRTLM::Local::Aggregate INTERFACE_LINK_LIBRARIES)
        get_target_property(_LITERTLM_CORE_PAYLOAD LiteRTLM::Local::Aggregate INTERFACE_LINK_LIBRARIES_CORE)
        get_target_property(_LITERTLM_ODML_PAYLOAD LiteRTLM::Local::Aggregate INTERFACE_LINK_LIBRARIES_ODML)
        
        string(REPLACE ";" " " _LITERTLM_LINK_FLAGS "${_LITERTLM_PAYLOAD}")

        

        message(STATUS "[LiteRTLM] Local Aggregate generated with ${LITERTLM_LOCAL_ARCHIVE_REGISTRY_LENGTH} targets.")
    endif()
endmacro()