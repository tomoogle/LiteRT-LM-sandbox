set(_litert_shims_dir "${LITERTLM_RECIPES_DIR}/litert/shims")

include(${_litert_shims_dir}/absl_shim.cmake)



if(NOT TARGET nlohmann_json::nlohmann_json)
    add_library(nlohmann_json::nlohmann_json INTERFACE IMPORTED GLOBAL)
    set_target_properties(nlohmann_json::nlohmann_json PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${JSON_INCLUDE_DIR}"
    )
endif()