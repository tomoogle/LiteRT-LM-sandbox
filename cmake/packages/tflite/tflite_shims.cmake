set(_tflite_shims_dir "${LITERTLM_PACKAGES_DIR}/tflite/shims")

include("${_tflite_shims_dir}/build_tree_shim.cmake")
include("${_tflite_shims_dir}/absl_shim.cmake")
include("${_tflite_shims_dir}/proto_shim.cmake")
include("${_tflite_shims_dir}/flatbuffers_shim.cmake")
