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
  lora_data.