# protobuf_shim.cmake
include_guard(GLOBAL)

include("${LITERTLM_MODULES_DIR}/utils.cmake")
include("${ABSL_RECIPE_DIR}/absl_omnibus.cmake")

generate_absl_omnibus()
message(STATUS "DEBUG: [PROTOBUF]ABSL_TARGET_MAP IS: '${ABSL_TARGET_MAP}'")

set(protobuf_ABSL_PROVIDER "package" CACHE INTERNAL "" FORCE)
set(protobuf_ABSL_USED_TARGETS "LiteRTLM::absl::absl" CACHE INTERNAL "" FORCE)
set(protobuf_ABSL_USED_TEST_TARGETS "LiteRTLM::absl::absl" CACHE INTERNAL "" FORCE)

message(STATUS "DEBUG: [PROTOBUF]ABSL_TARGET_MAP IS: '${_ABSL_LINK_FLAGS}'")


set(CMAKE_CXX_STANDARD_LIBRARIES 
    "${CMAKE_CXX_STANDARD_LIBRARIES} -Wl,--start-group -Wl,--whole-archive ${_ABSL_LINK_FLAGS} -Wl,--no-whole-archive -Wl,--end-group" 
    CACHE STRING "Forced Abseil Omnibus for Protobuf internal linking" FORCE
)

add_definitions(-DABSL_LTS_GROUP_EXPORT)
add_definitions(-DABSL_20250814_LTS)