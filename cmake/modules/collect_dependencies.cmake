add_library(LITERTLM_DEPS INTERFACE)
target_link_libraries(LITERTLM_DEPS INTERFACE
  $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--start-group>
    absl_libs
    antlr_lib
    libpng_lib
    kissfft_lib
    miniaudio_lib
    minizip_lib
    minja_lib
    json_lib
    zlib_lib
    re2_libs
    sentencepiece_libs
    tflite_libs
    proto_lib
  $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--end-group>
)



# set(LITERT_BUILD_ROOT "${EXTERNAL_PROJECT_BINARY_DIR}/litert/src/litert_external-build")
# set(ABSL_BUILD_ROOT   "${EXTERNAL_PROJECT_BINARY_DIR}/abseil-cpp/src/absl_external-build")
# set(FLATBUFFERS_BUILD_ROOT "${EXTERNAL_PROJECT_BINARY_DIR}/flatbuffers/src/flatbuffers_external-build")

# add_library(litert_libs INTERFACE)

# target_link_libraries(litert_libs INTERFACE
#     $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--start-group>
    
#     # LiteRT Core
#     imp_tflite
#     imp_litert_runtime
#     imp_litert_c_api
#     imp_litert_core
#     imp_litert_logging
    
#     # Abseil
#     imp_absl_base
#     imp_absl_status
#     imp_absl_statusor
#     imp_absl_strings
#     imp_absl_str_int
#     imp_absl_sync
#     imp_absl_time
#     imp_absl_flags
    
#     # Dependencies
#     dl
#     pthread
    
#     $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--end-group>
# )

# target_include_directories(litert_libs INTERFACE
#     ${LITERTLM_INCLUDE_PATHS}
# )

# add_dependencies(litert_libs litert_external)