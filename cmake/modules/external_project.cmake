# --- Dependency Orchestration ---
# Note: Order is preserved to satisfy inter-dependency requirements
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

foreach(recipe ${LITERTLM_DEPENDENCY_ORDER})
    load_recipe(${recipe})
endforeach()
