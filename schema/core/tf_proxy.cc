#undef TFLITE_MMAP_DISABLED 

#include "tensorflow/compiler/mlir/lite/allocation.cc"
#include "tensorflow/compiler/mlir/lite/mmap_allocation.cc"
#include "tensorflow/compiler/mlir/lite/core/model_builder_base.cc"
#include "tensorflow/compiler/mlir/lite/core/api/error_reporter.cc"
#include "tensorflow/compiler/mlir/lite/core/api/flatbuffer_conversions.cc"