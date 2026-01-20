# protobuf_shim.cmake

# if(NOT TARGET LiteRTLM::absl::absl)
#     add_library(LiteRTLM::absl::absl INTERFACE IMPORTED GLOBAL)
#     set_target_properties(LiteRTLM::absl::absl PROPERTIES 
#         INTERFACE_LINK_LIBRARIES "-Wl,--start-group;${LITERTLM_ABSL_LIBS_FLAT};-Wl,--end-group"
#         INTERFACE_INCLUDE_DIRECTORIES "${LITERTLM_ABSL_INCLUDE_DIRS}"
#     )
# endif()


if(NOT TARGET LiteRTLM::absl::absl)
    add_library(LiteRTLM::absl::absl INTERFACE IMPORTED GLOBAL)
    set_target_properties(LiteRTLM::absl::absl PROPERTIES 
        INTERFACE_LINK_LIBRARIES 
            "-Wl,--whole-archive;${LITERTLM_ABSL_LIBS_FLAT};-Wl,--no-whole-archive;pthread;dl"
        INTERFACE_INCLUDE_DIRECTORIES "${LITERTLM_ABSL_INCLUDE_DIRS}"
    )
endif()

set(protobuf_ABSL_USED_TARGETS "LiteRTLM::absl::absl" CACHE INTERNAL "" FORCE)
set(protobuf_ABSL_USED_TEST_TARGETS "LiteRTLM::absl::absl" CACHE INTERNAL "" FORCE)