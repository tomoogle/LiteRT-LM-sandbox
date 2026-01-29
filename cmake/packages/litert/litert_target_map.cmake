# cmake/packages/litert/litert_target_map.cmake

set(LITERT_TARGET_MAP
    "litert::cc_api=${LITERT_BUILD_DIR}/cc/liblitert_cc_api.a"
    "litert::cc_options=${LITERT_BUILD_DIR}/cc/options/liblitert_cc_options.a"
    "litert::c_api=${LITERT_BUILD_DIR}/c/liblitert_c_api.a"
    "litert::c_options=${LITERT_BUILD_DIR}/c/options/liblitert_c_options.a"
    "litert::logging=${LITERT_BUILD_DIR}/c/liblitert_logging.a"
    "litert::runtime=${LITERT_BUILD_DIR}/runtime/liblitert_runtime.a"
    "litert::compiler_plugin=${LITERT_BUILD_DIR}/compiler/liblitert_compiler_plugin.a"
    "litert::core=${LITERT_BUILD_DIR}/core/liblitert_core.a"
    "litert::core_cache=${LITERT_BUILD_DIR}/core/cache/liblitert_core_cache.a"
    "litert::core_model=${LITERT_BUILD_DIR}/core/model/liblitert_core_model.a"
    "litert::qnn_manager=${LITERT_BUILD_DIR}/vendors/qualcomm/libqnn_manager.a"
    "litert::qnn_context_binary_info=${LITERT_BUILD_DIR}/vendors/qualcomm/libqnn_context_binary_info.a"
    "litert::qnn_backends=${LITERT_BUILD_DIR}/vendors/qualcomm/core/backends/libqnn_backends.a"
    "litert::qnn_dump=${LITERT_BUILD_DIR}/vendors/qualcomm/core/dump/libqnn_dump.a"
    "litert::qnn_transformation=${LITERT_BUILD_DIR}/vendors/qualcomm/core/transformation/libqnn_transformation.a"
    "litert::qnn_wrappers=${LITERT_BUILD_DIR}/vendors/qualcomm/core/wrappers/libqnn_wrappers.a"
    "litert::qnn_builders=${LITERT_BUILD_DIR}/vendors/qualcomm/core/builders/libqnn_builders.a"
    "litert::qnn_core=${LITERT_BUILD_DIR}/vendors/qualcomm/core/libqnn_core.a"
)

# Core targets that should likely be WHOLE_ARCHIVE to ensure 
# delegate and plugin registration.
set(_litert_exhaustive_targets
    "litert::runtime"
    "litert::c_api"
    "litert::cc_api"
    "litert::compiler_plugin"
    "litert::qnn_manager"
)