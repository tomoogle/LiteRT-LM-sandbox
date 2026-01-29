# protobuf_shim.cmake
include_guard(GLOBAL)

include("${LITERTLM_MODULES_DIR}/utils.cmake")
include("${ABSL_PACKAGE_DIR}/absl_aggregate.cmake")

add_definitions(-D_GLIBCXX_USE_CXX11_ABI=1)

generate_absl_aggregate()

set(protobuf_ABSL_PROVIDER "package" CACHE INTERNAL "" FORCE)
set(protobuf_ABSL_USED_TARGETS "LiteRTLM::absl::absl" CACHE INTERNAL "" FORCE)
set(protobuf_ABSL_USED_TEST_TARGETS "LiteRTLM::absl::absl" CACHE INTERNAL "" FORCE)


set(CMAKE_CXX_STANDARD_LIBRARIES 
    "${CMAKE_CXX_STANDARD_LIBRARIES} ${_ABSL_LINK_FLAGS}" 
    CACHE STRING "Forced Abseil aggregate for Protobuf internal linking" FORCE
)

add_definitions(-DABSL_LTS_GROUP_EXPORT)
add_definitions(-DABSL_20250814_LTS)