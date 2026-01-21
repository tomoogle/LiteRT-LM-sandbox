# ==============================================================================
# LITERTLM VENDOR SHIM
# Purpose: Handle proprietary vendor build logic (MediaTek, Qualcomm) using
#          hermetic global tools (flatc) instead of internal submodules.
# ==============================================================================

if(VENDOR STREQUAL "MediaTek")
    message(STATUS "[LITERTLM] MediaTek Shim: Generating Schemas with Global Toolchain...")

    # Force resolution to our Global Imported Target
    set(FLATC_EXECUTABLE flatc)

    set(_mtk_gen_dir "${CMAKE_CURRENT_BINARY_DIR}/generated/include/litert/vendors/mediatek/schema")
    set(_mtk_schema "${CMAKE_CURRENT_SOURCE_DIR}/mediatek/schema/neuron_schema.fbs")
    set(_mtk_gen_hdr "${_mtk_gen_dir}/neuron_schema_generated.h")

    file(MAKE_DIRECTORY "${_mtk_gen_dir}")

    add_custom_command(
        OUTPUT "${_mtk_gen_hdr}"
        COMMAND flatc --cpp -o "${_mtk_gen_dir}" "${_mtk_schema}"
        DEPENDS "${_mtk_schema}"
        COMMENT "[LITERTLM] Generating MediaTek schema: ${_mtk_gen_hdr}"
        VERBATIM
    )

    add_custom_target(mediatek_schema_gen DEPENDS "${_mtk_gen_hdr}")
    list(APPEND DISPATCH_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/mediatek/neuron_adapter_api.cc")
endif()