# ==============================================================================
# LITERTLM SHIMS HUB
# Purpose: Virtualize dependencies and neutralize internal discovery logic.
# ==============================================================================

# --- 1. UTILITIES & MACROS ---
include("${TFLITE_PACKAGE_DIR}/tflite_aggregate.cmake")

set(VENDOR_SHIM_PATH "${LITERT_PACKAGE_DIR}/shims/vendor_shim.cmake")



message(STATUS "[LITERTLM-SHIM] Initializing Dependency Virtualization...")

# --- 2. ABSEIL VIRTUALIZATION ---
if(NOT TARGET LiteRTLM::absl::absl)
    # FIX: Convert the "Wall of Abseil" string back into a real list for the linker
    separate_arguments(_ABSL_LIST NATIVE_COMMAND "${ABSL_LIBS_FLAT}")

    add_library(LiteRTLM::absl::absl INTERFACE IMPORTED GLOBAL)
    set_target_properties(LiteRTLM::absl::absl PROPERTIES 
        # Pass the list directly (no quotes around the list variable)
        INTERFACE_LINK_LIBRARIES "-Wl,--start-group;${_ABSL_LIST};-Wl,--end-group"
        INTERFACE_INCLUDE_DIRECTORIES "${ABSL_INCLUDE_DIR}"
    )
    
    # Optional: Alias standard Abseil targets to our sink to catch stragglers
    if(NOT TARGET absl::strings)
        add_library(absl::strings ALIAS LiteRTLM::absl::absl)
    endif()
endif()

# --- 3. JSON VIRTUALIZATION ---
if(NOT TARGET nlohmann_json::nlohmann_json)
    add_library(nlohmann_json::nlohmann_json INTERFACE IMPORTED GLOBAL)
    set_target_properties(nlohmann_json::nlohmann_json PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${JSON_INCLUDE_DIR}/include"
    )
    message(STATUS "[LITERTLM-SHIM] Virtualized nlohmann_json::nlohmann_json")
endif()

# --- 4. FLATBUFFERS REMEDIATION ---
if(NOT TARGET LiteRTLM::flatbuffers::flatbuffers)
    add_library(LiteRTLM::flatbuffers::flatbuffers STATIC IMPORTED GLOBAL)
    set_target_properties(LiteRTLM::flatbuffers::flatbuffers PROPERTIES
        IMPORTED_LOCATION "${FLATBUFFERS_LIB_DIR}/libflatbuffers.a"
        INTERFACE_INCLUDE_DIRECTORIES "${FLATBUFFERS_INCLUDE_DIR}"
    )
    
    # Force-feed the "Found" variables so internal FindFlatbuffers.cmake doesn't run
    set(FlatBuffers_FOUND TRUE CACHE INTERNAL "Forced by LiteRTLM" FORCE)
    set(flatbuffers_FOUND TRUE CACHE INTERNAL "Forced by LiteRTLM" FORCE)
endif()

if(NOT TARGET flatbuffers::flatbuffers)
    add_library(flatbuffers::flatbuffers ALIAS LiteRTLM::flatbuffers::flatbuffers)
endif()

# Mock the flatc executable target
if(NOT TARGET flatc)
    add_executable(flatc IMPORTED GLOBAL)
    set_target_properties(flatc PROPERTIES IMPORTED_LOCATION "${FLATC_EXECUTABLE}")
endif()

# --- 5. TFLITE "KITCHEN SINK" CONFIGURATION ---

# Re-hydrate the flattened path strings passed from the Super-Build
set(_TFLITE_FORCE_LOAD_PATHS "${TFLITE_FORCE_LOAD_PATHS_FLAT}")
set(_TFLITE_STANDARD_PATHS   "${TFLITE_STANDARD_PATHS_FLAT}")

# Convert back to CMake Lists
separate_arguments(TFLITE_FORCE_LOAD_TARGETS NATIVE_COMMAND "${_TFLITE_FORCE_LOAD_PATHS}")
separate_arguments(TFLITE_STANDARD_TARGETS   NATIVE_COMMAND "${_TFLITE_STANDARD_PATHS}")

# Call the Macro (Loaded from LiteRTLM_TFLiteLinker.cmake)
generate_tflite_aggregate(
    "${TFLITE_FORCE_LOAD_TARGETS}" 
    "${TFLITE_STANDARD_TARGETS}"
    "${TFLITE_INCLUDE_DIR}"
    "${TFLITE_BUILD_DIR}"
)

# Redirect the canonical target to our Kitchen Sink
if(NOT TARGET tensorflow-lite)
    add_library(tensorflow-lite ALIAS tflite_libs)
endif()

# --- 6. GLOBAL LINKAGE ENFORCEMENT ---
# Use the re-generated list from section 2
link_libraries("-Wl,--start-group" ${_ABSL_LIST} "-Wl,--end-group")
include_directories(SYSTEM "${ABSL_INCLUDE_DIR}")
