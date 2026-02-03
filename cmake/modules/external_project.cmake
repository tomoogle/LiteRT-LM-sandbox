# --- Dependency Orchestration ---
# Note: Order is preserved to satisfy inter-dependency requirements
message(STATUS "[DEBUG] LITERTLM_PACKAGES_DIR: ${LITERTLM_PACKAGES_DIR}")

set(LITERTLM_DEPENDENCY_ORDER
    opencl
    absl
    gtest
    protobuf
    flatbuffers
    sentencepiece
    tokenizers
    re2
    tflite
    litert
)

foreach(package ${LITERTLM_DEPENDENCY_ORDER})
    load_package(${package}) # macros.cmake
endforeach()
