set(PROJECT_ROOT "${CMAKE_CURRENT_SOURCE_DIR}")
include(${LITERTLM_MODULES_DIR}/utils.cmake)

set(_tflite_shims_dir "${LITERTLM_PACKAGES_DIR}/tflite/shims")
include("${_tflite_shims_dir}/build_tree_shim.cmake")
include("${_tflite_shims_dir}/proto_shim.cmake")
include("${_tflite_shims_dir}/flatbuffers_shim.cmake")


include(${ABSL_PACKAGE_DIR}/absl_aggregate.cmake)
generate_absl_aggregate()

include(${PROTOBUF_PACKAGE_DIR}/protobuf_aggregate.cmake)
generate_protobuf_aggregate()

if(NOT TARGET protobuf::protoc)
    add_executable(protobuf::protoc IMPORTED GLOBAL)
    set_target_properties(protobuf::protoc PROPERTIES 
        IMPORTED_LOCATION "${PROTO_PROTOC_EXECUTABLE}"
    )
endif()


message(STATUS "[LiteRTLM] Injecting missing CMakeLists into profiling/...")

file(GLOB PROFILING_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/profiling/*.cc")
list(FILTER PROFILING_SRCS EXCLUDE REGEX "_test\\.cc$")

set(PROTO_FILES 
    "${PROJECT_ROOT}/tensorflow/lite/profiling/proto/profiling_info.proto"
    "${PROJECT_ROOT}/tensorflow/lite/profiling/proto/model_runtime_info.proto"
)

add_library(tflite_profiling STATIC ${PROFILING_SRCS})
generate_protobuf(tflite_profiling)

target_link_libraries(tflite_profiling PRIVATE 
    LiteRTLM::absl::absl
    LiteRTLM::protobuf::libprotobuf
)

target_include_directories(tflite_profiling PUBLIC 
    ${CMAKE_BINARY_DIR}
    ${TENSORFLOW_SOURCE_DIR}
    ${LITERTLM_ABSL_INCLUDE_DIRS}
    ${LITERTLM_PROTOBUF_INCLUDE_DIRS}
)


install(TARGETS tflite_profiling
    ARCHIVE DESTINATION lib
)