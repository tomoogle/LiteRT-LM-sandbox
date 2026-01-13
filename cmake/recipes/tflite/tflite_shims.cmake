set(_litert_tflite_shims_dir "${LITERTLM_RECIPES_DIR}/tflite/shims")

include("${_litert_tflite_shims_dir}/build_tree_shim.cmake")
include("${_litert_tflite_shims_dir}/absl_shim.cmake")
include("${_litert_tflite_shims_dir}/proto_shim.cmake")
include("${_litert_tflite_shims_dir}/flatbuffers_shim.cmake")
