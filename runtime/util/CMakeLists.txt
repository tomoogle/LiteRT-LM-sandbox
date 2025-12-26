set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Convert Tensor Buffer ---
add_litertlm_library(runtime_util_convert_tensor_buffer INTERFACE)
add_library(LiteRTLM::Util::ConvertTensorBuffer ALIAS runtime_util_convert_tensor_buffer)

target_include_directories(runtime_util_convert_tensor_buffer 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_convert_tensor_buffer 
  INTERFACE
    litert_libs
)

# --- Executor Data Util ---
add_litertlm_library(runtime_util_executor_data_util STATIC
  executor_data_util.cc
)
add_library(LiteRTLM::Util::ExecutorDataUtil ALIAS runtime_util_executor_data_util)

target_include_directories(runtime_util_executor_data_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_executor_data_util
  PUBLIC
    LiteRTLM::Util::ConvertTensorBuffer
    LiteRTLM::Util::TensorBufferUtil # (Defined below)
    LiteRTLM::Executor::LLM::IoTypes
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

# --- File Format Util ---
add_litertlm_library(runtime_util_file_format_util STATIC
  file_format_util.cc
)
add_library(LiteRTLM::Util::FileFormatUtil ALIAS runtime_util_file_format_util)

target_include_directories(runtime_util_file_format_util 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_file_format_util
  PUBLIC
    runtime_executor_executor_settings_base
    LiteRTLM::Util::StatusUtil # (Defined below)
    LiteRTLM::Util::MemoryMappedFile # (Defined below)
    LiteRTLM::Util::ScopedFile # (Defined below)
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- File Util ---
add_litertlm_library(runtime_util_file_util STATIC
  file_util.cc
)
add_library(LiteRTLM::Util::FileUtil ALIAS runtime_util_file_util)

target_include_directories(runtime_util_file_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_file_util 
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- LiteRT LM Loader ---
add_litertlm_library(runtime_util_litert_lm_loader STATIC
  litert_lm_loader.cc
)
add_library(LiteRTLM::Util::LMLoader ALIAS runtime_util_litert_lm_loader)

target_include_directories(runtime_util_litert_lm_loader
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_litert_lm_loader 
  PUBLIC
    LiteRTLM::Util::StatusUtil
    LiteRTLM::Util::MemoryMappedFile
    LiteRTLM::Util::ScopedFile
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- LiteRT Status Util ---
add_litertlm_library(runtime_util_litert_status_util INTERFACE)
add_library(LiteRTLM::Util::StatusUtil ALIAS runtime_util_litert_status_util)

target_include_directories(runtime_util_litert_status_util 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_litert_status_util 
  INTERFACE
    litert_libs
)

# --- Logging ---
add_litertlm_library(runtime_util_logging INTERFACE)
add_library(LiteRTLM::Util::Logging ALIAS runtime_util_logging)

target_include_directories(runtime_util_logging
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_logging 
  INTERFACE
    litert_libs
)

# --- Logging Tensor Buffer ---
add_litertlm_library(runtime_util_logging_tensor_buffer STATIC
  logging_tensor_buffer.cc
)
add_library(LiteRTLM::Util::LoggingTensorBuffer ALIAS runtime_util_logging_tensor_buffer)

target_include_directories(runtime_util_logging_tensor_buffer 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_logging_tensor_buffer 
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- LoRA Data ---
add_litertlm_library(runtime_util_lora_data STATIC
  lora_data.cc
)
add_library(LiteRTLM::Util::LoRAData ALIAS runtime_util_lora_data)

target_include_directories(runtime_util_lora_data
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_lora_data
  PUBLIC
    LiteRTLM::Util::StatusUtil
    LiteRTLM::Util::LoRAUtil # (Defined below)
    LiteRTLM::Util::ScopedFile
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- LoRA Util ---
add_litertlm_library(runtime_util_lora_util STATIC
  lora_util.cc
)
add_library(LiteRTLM::Util::LoRAUtil ALIAS runtime_util_lora_util)

target_include_directories(runtime_util_lora_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}/re2
)

target_link_libraries(runtime_util_lora_util
  PUBLIC
    LiteRTLM::Util::StatusUtil
    LiteRTLM::Util::MemoryMappedFile
    LiteRTLM::Util::ScopedFile
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- Memory Mapped File ---
if(WIN32)
  set(runtime_util_memory_mapped_file_src memory_mapped_file_win.cc)
elseif(UNIX)
  set(runtime_util_memory_mapped_file_src memory_mapped_file_posix.cc)
endif()

add_litertlm_library(runtime_util_memory_mapped_file STATIC
  ${runtime_util_memory_mapped_file_src}
)
add_library(LiteRTLM::Util::MemoryMappedFile ALIAS runtime_util_memory_mapped_file)

target_include_directories(runtime_util_memory_mapped_file
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_memory_mapped_file 
  PUBLIC
    LiteRTLM::Util::StatusUtil
    LiteRTLM::Util::ScopedFile
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- Metadata Util ---
add_litertlm_library(runtime_util_metadata_util STATIC
  metadata_util.cc
)
add_library(LiteRTLM::Util::MetadataUtil ALIAS runtime_util_metadata_util)

target_include_directories(runtime_util_metadata_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_metadata_util
  PRIVATE
    proto_lib
    litert_libs
    LITERTLM_DEPS
)

# --- Model Asset Bundle Resources ---
add_litertlm_library(runtime_util_model_asset_bundle_resources STATIC
  model_asset_bundle_resources.cc
)
add_library(LiteRTLM::Util::ModelAssetBundleResources ALIAS runtime_util_model_asset_bundle_resources)

target_include_directories(runtime_util_model_asset_bundle_resources 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_model_asset_bundle_resources
  PUBLIC
    LiteRTLM::Util::StatusUtil
    LiteRTLM::Util::MemoryMappedFile
    LiteRTLM::Util::ScopedFile
    LiteRTLM::Util::ZipUtils # (Defined below)
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- Model Type Utils ---
add_litertlm_library(runtime_util_model_type_utils STATIC
  model_type_utils.cc
)
add_library(LiteRTLM::Util::ModelTypeUtils ALIAS runtime_util_model_type_utils)

target_include_directories(runtime_util_model_type_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_model_type_utils 
  PUBLIC
    LiteRTLM::Util::StatusUtil
  PRIVATE
    proto_lib
    litert_libs
    LITERTLM_DEPS
)

# --- Scoped File ---
if(WIN32)
  set(runtime_util_scoped_file_src scoped_file.cc scoped_file_win.cc)
elseif(UNIX)
  set(runtime_util_scoped_file_src scoped_file.cc scoped_file_posix.cc)
endif()

add_litertlm_library(runtime_util_scoped_file STATIC
  ${runtime_util_scoped_file_src}
)
add_library(LiteRTLM::Util::ScopedFile ALIAS runtime_util_scoped_file)

target_include_directories(runtime_util_scoped_file
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_scoped_file
  PUBLIC
    LiteRTLM::Util::StatusUtil 
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- Tensor Buffer Util ---
add_litertlm_library(runtime_util_tensor_buffer_util STATIC
  tensor_buffer_util.cc
)
add_library(LiteRTLM::Util::TensorBufferUtil ALIAS runtime_util_tensor_buffer_util)

target_include_directories(runtime_util_tensor_buffer_util
  PRIVATE
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_tensor_buffer_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Test Utils ---
add_litertlm_library(runtime_util_test_utils INTERFACE)
add_library(LiteRTLM::Util::TestUtils ALIAS runtime_util_test_utils)

target_include_directories(runtime_util_test_utils 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_test_utils
  INTERFACE
    litert_libs
)

# --- Zip Readonly Mem File ---
add_litertlm_library(runtime_util_zip_readonly_mem_file STATIC
  zip_readonly_mem_file.cc
)
add_library(LiteRTLM::Util::ZipReadonlyMemFile ALIAS runtime_util_zip_readonly_mem_file)

target_include_directories(runtime_util_zip_readonly_mem_file
  PRIVATE
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}/minizip
)

target_link_libraries(runtime_util_zip_readonly_mem_file 
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# --- Zip Utils ---
add_litertlm_library(runtime_util_zip_utils STATIC
  zip_utils.cc
)
add_library(LiteRTLM::Util::ZipUtils ALIAS runtime_util_zip_utils)

target_include_directories(runtime_util_zip_utils
  PRIVATE
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR} # Often needed for minizip headers
)

target_link_libraries(runtime_util_zip_utils
  PUBLIC
    LiteRTLM::Util::StatusUtil
    LiteRTLM::Util::ZipReadonlyMemFile
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# --- Folder Facade ---
add_library(runtime_util_libs INTERFACE)
add_library(LiteRTLM::Util ALIAS runtime_util_libs)

target_link_libraries(runtime_util_libs INTERFACE
  LiteRTLM::Util::ConvertTensorBuffer
  LiteRTLM::Util::ExecutorDataUtil
  LiteRTLM::Util::FileFormatUtil
  LiteRTLM::Util::FileUtil
  LiteRTLM::Util::LMLoader
  LiteRTLM::Util::LoggingTensorBuffer
  LiteRTLM::Util::LoRAData
  LiteRTLM::Util::LoRAUtil
  LiteRTLM::Util::MemoryMappedFile
  LiteRTLM::Util::MetadataUtil
  LiteRTLM::Util::ModelAssetBundleResources
  LiteRTLM::Util::ModelTypeUtils
  LiteRTLM::Util::ScopedFile
  LiteRTLM::Util::TensorBufferUtil
  LiteRTLM::Util::ZipReadonlyMemFile
  LiteRTLM::Util::ZipUtils
)