set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Convert Tensor Buffer ---
add_litertlm_library(runtime_util_convert_tensor_buffer INTERFACE)
add_library(LiteRT::Components::Util::ConvertTensorBuffer ALIAS runtime_util_convert_tensor_buffer)

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
add_library(LiteRT::Components::Util::ExecutorDataUtil ALIAS runtime_util_executor_data_util)

target_include_directories(runtime_util_executor_data_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_executor_data_util
  PUBLIC
    LiteRT::Components::Util::ConvertTensorBuffer
    LiteRT::Components::Util::TensorBufferUtil # (Defined below)
    LiteRTLM::Executor::LLM::IoTypes
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

# --- File Format Util ---
add_litertlm_library(runtime_util_file_format_util STATIC
  file_format_util.cc
)
add_library(LiteRT::Components::Util::FileFormatUtil ALIAS runtime_util_file_format_util)

target_include_directories(runtime_util_file_format_util 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_file_format_util
  PUBLIC
    runtime_executor_executor_settings_base
    LiteRT::Components::Util::StatusUtil # (Defined below)
    LiteRT::Components::Util::MemoryMappedFile # (Defined below)
    LiteRT::Components::Util::ScopedFile # (Defined below)
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- File Util ---
add_litertlm_library(runtime_util_file_util STATIC
  file_util.cc
)
add_library(LiteRT::Components::Util::FileUtil ALIAS runtime_util_file_util)

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
add_library(LiteRT::Components::Util::LMLoader ALIAS runtime_util_litert_lm_loader)

target_include_directories(runtime_util_litert_lm_loader
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_litert_lm_loader 
  PUBLIC
    LiteRT::Components::Util::StatusUtil
    LiteRT::Components::Util::MemoryMappedFile
    LiteRT::Components::Util::ScopedFile
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- LiteRT Status Util ---
add_litertlm_library(runtime_util_litert_status_util INTERFACE)
add_library(LiteRT::Components::Util::StatusUtil ALIAS runtime_util_litert_status_util)

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
add_library(LiteRT::Components::Util::Logging ALIAS runtime_util_logging)

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
add_library(LiteRT::Components::Util::LoggingTensorBuffer ALIAS runtime_util_logging_tensor_buffer)

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
add_library(LiteRT::Components::Util::LoRAData ALIAS runtime_util_lora_data)

target_include_directories(runtime_util_lora_data
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_lora_data
  PUBLIC
    LiteRT::Components::Util::StatusUtil
    LiteRT::Components::Util::LoRAUtil # (Defined below)
    LiteRT::Components::Util::ScopedFile
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- LoRA Util ---
add_litertlm_library(runtime_util_lora_util STATIC
  lora_util.cc
)
add_library(LiteRT::Components::Util::LoRAUtil ALIAS runtime_util_lora_util)

target_include_directories(runtime_util_lora_util
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}/re2
)

target_link_libraries(runtime_util_lora_util
  PUBLIC
    LiteRT::Components::Util::StatusUtil
    LiteRT::Components::Util::MemoryMappedFile
    LiteRT::Components::Util::ScopedFile
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
add_library(LiteRT::Components::Util::MemoryMappedFile ALIAS runtime_util_memory_mapped_file)

target_include_directories(runtime_util_memory_mapped_file
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_memory_mapped_file 
  PUBLIC
    LiteRT::Components::Util::StatusUtil
    LiteRT::Components::Util::ScopedFile
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- Metadata Util ---
add_litertlm_library(runtime_util_metadata_util STATIC
  metadata_util.cc
)
add_library(LiteRT::Components::Util::MetadataUtil ALIAS runtime_util_metadata_util)

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
add_library(LiteRT::Components::Util::ModelAssetBundleResources ALIAS runtime_util_model_asset_bundle_resources)

target_include_directories(runtime_util_model_asset_bundle_resources 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_model_asset_bundle_resources
  PUBLIC
    LiteRT::Components::Util::StatusUtil
    LiteRT::Components::Util::MemoryMappedFile
    LiteRT::Components::Util::ScopedFile
    LiteRT::Components::Util::ZipUtils # (Defined below)
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- Model Type Utils ---
add_litertlm_library(runtime_util_model_type_utils STATIC
  model_type_utils.cc
)
add_library(LiteRT::Components::Util::ModelTypeUtils ALIAS runtime_util_model_type_utils)

target_include_directories(runtime_util_model_type_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_model_type_utils 
  PUBLIC
    LiteRT::Components::Util::StatusUtil
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
add_library(LiteRT::Components::Util::ScopedFile ALIAS runtime_util_scoped_file)

target_include_directories(runtime_util_scoped_file
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_util_scoped_file
  PUBLIC
    LiteRT::Components::Util::StatusUtil 
  PRIVATE
    litert_libs
    LITERTLM_DEPS
)

# --- Tensor Buffer Util ---
add_litertlm_library(runtime_util_tensor_buffer_util STATIC
  tensor_buffer_util.cc
)
add_library(LiteRT::Components::Util::TensorBufferUtil ALIAS runtime_util_tensor_buffer_util)

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
add_library(LiteRT::Components::Util::TestUtils ALIAS runtime_util_test_utils)

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
add_library(LiteRT::Components::Util::ZipReadonlyMemFile ALIAS runtime_util_zip_readonly_mem_file)

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
add_library(LiteRT::Components::Util::ZipUtils ALIAS runtime_util_zip_utils)

target_include_directories(runtime_util_zip_utils
  PRIVATE
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR} # Often needed for minizip headers
)

target_link_libraries(runtime_util_zip_utils
  PUBLIC
    LiteRT::Components::Util::StatusUtil
    LiteRT::Components::Util::ZipReadonlyMemFile
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# --- Folder Facade ---
add_library(runtime_util_libs INTERFACE)
add_library(LiteRT::Components::Util ALIAS runtime_util_libs)

target_link_libraries(runtime_util_libs INTERFACE
  LiteRT::Components::Util::ConvertTensorBuffer
  LiteRT::Components::Util::ExecutorDataUtil
  LiteRT::Components::Util::FileFormatUtil
  LiteRT::Components::Util::FileUtil
  LiteRT::Components::Util::LMLoader
  LiteRT::Components::Util::LoggingTensorBuffer
  LiteRT::Components::Util::LoRAData
  LiteRT::Components::Util::LoRAUtil
  LiteRT::Components::Util::MemoryMappedFile
  LiteRT::Components::Util::MetadataUtil
  LiteRT::Components::Util::ModelAssetBundleResources
  LiteRT::Components::Util::ModelTypeUtils
  LiteRT::Components::Util::ScopedFile
  LiteRT::Components::Util::TensorBufferUtil
  LiteRT::Components::Util::ZipReadonlyMemFile
  LiteRT::Components::Util::ZipUtils
)