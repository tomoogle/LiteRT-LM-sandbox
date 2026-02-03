# ==============================================================================
# LITERTLM SHIMS HUB
# Purpose: Virtualize dependencies and neutralize internal discovery logic.
# ==============================================================================

# --- 1. UTILITIES & MACROS ---
include_guard(GLOBAL)
include("${LITERTLM_MODULES_DIR}/utils.cmake")
include("${LITERTLM_PACKAGES_DIR}/packages.cmake")
include("${ABSL_PACKAGE_DIR}/absl_aggregate.cmake")
include("${PROTOBUF_PACKAGE_DIR}/protobuf_aggregate.cmake")
include("${FLATBUFFERS_PACKAGE_DIR}/flatbuffers_aggregate.cmake")
include("${TFLITE_PACKAGE_DIR}/tflite_aggregate.cmake")



add_link_options("-Wl,--allow-multiple-definition")

generate_absl_aggregate()

generate_protobuf_aggregate()

generate_flatbuffers_aggregate()
generate_flatc_aggregate()
generate_tflite_aggregate()




set(VENDOR_SHIM_PATH "${LITERT_PACKAGE_DIR}/shims/vendor_shim.cmake")



message(STATUS "[LITERTLM-SHIM] Initializing Dependency Virtualization...")


# --- 3. JSON VIRTUALIZATION ---
if(NOT TARGET nlohmann_json::nlohmann_json)
    add_library(nlohmann_json::nlohmann_json INTERFACE IMPORTED GLOBAL)
    set_target_properties(nlohmann_json::nlohmann_json PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${JSON_INCLUDE_DIR}/include"
    )
    message(STATUS "[LITERTLM-SHIM] Virtualized nlohmann_json::nlohmann_json")
endif()

# Mock the flatc executable target
if(NOT TARGET flatc)
    add_executable(flatc IMPORTED GLOBAL)
    set_target_properties(flatc PROPERTIES IMPORTED_LOCATION "${FLATC_EXECUTABLE}")
endif()



# Redirect the canonical target to our Kitchen Sink


# # --- 6. GLOBAL LINKAGE ENFORCEMENT ---
# # Use the re-generated list from section 2
# link_libraries("-Wl,--start-group" ${_ABSL_LIST} "-Wl,--end-group")
# include_directories(SYSTEM "${ABSL_INCLUDE_DIR}")
