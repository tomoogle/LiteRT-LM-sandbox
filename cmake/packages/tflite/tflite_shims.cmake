include(${LITERTLM_MODULES_DIR}/utils.cmake)

set(_tflite_shims_dir "${LITERTLM_PACKAGES_DIR}/tflite/shims")
include("${_tflite_shims_dir}/build_tree_shim.cmake")
include("${_tflite_shims_dir}/proto_shim.cmake")
include("${_tflite_shims_dir}/flatbuffers_shim.cmake")

include_directories(${ABSL_INCLUDE_DIR})

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

set(STATS_CALC_SRC "${TENSORFLOW_SOURCE_DIR}/third_party/xla/xla/tsl/util/stats_calculator.cc")

if(EXISTS "${STATS_CALC_SRC}")
    message(STATUS "[LiteRTLM] Found stats_calculator at: ${STATS_CALC_SRC}")
    list(APPEND PROFILING_SRCS "${STATS_CALC_SRC}")
else()
    # Fallback: Just in case it moves back to core, check one more spot before failing
    set(STATS_CALC_FALLBACK "${TENSORFLOW_SOURCE_DIR}/tensorflow/core/util/stats_calculator.cc")
    if(EXISTS "${STATS_CALC_FALLBACK}")
         list(APPEND PROFILING_SRCS "${STATS_CALC_FALLBACK}")
    else()
         message(FATAL_ERROR "[LiteRT-LM] CRITICAL: Could not find stats_calculator.cc in XLA or Core paths.\nChecked:\n  ${STATS_CALC_SRC}\n  ${STATS_CALC_FALLBACK}")
    endif()
endif()

set(PROTO_FILES 
    "${TENSORFLOW_SOURCE_DIR}/tensorflow/lite/profiling/proto/profiling_info.proto"
    "${TENSORFLOW_SOURCE_DIR}/tensorflow/lite/profiling/proto/model_runtime_info.proto"
)

add_library(tflite_profiling STATIC ${PROFILING_SRCS})
generate_protobuf(tflite_profiling ${TENSORFLOW_SOURCE_DIR})

target_link_libraries(tflite_profiling PRIVATE 
    LiteRTLM::absl::absl
    LiteRTLM::protobuf::libprotobuf
)

target_include_directories(tflite_profiling PUBLIC 
    ${CMAKE_BINARY_DIR}
    ${TENSORFLOW_SOURCE_DIR}
    ${ABSL_INCLUDE_DIRS}}
    ${PROTOBUF_INCLUDE_DIRS}
)


install(TARGETS tflite_profiling
    ARCHIVE DESTINATION lib
)