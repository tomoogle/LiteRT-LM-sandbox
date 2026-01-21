# tflite_build_tree_shim.cmake

# 1. Create the base 'tflite' stutter directory
file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/tflite")

# 2. Create the deep nests for the Protos we know are problematic
file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/tflite/profiling/proto")
file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/tflite/tools/benchmark/proto")

# 3. Add any other 'stutter' paths here as you find them
# file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/tflite/delegates/etc")

message(STATUS "LiteRTLM: TFLite Build Tree Shim - Directories Prepared")