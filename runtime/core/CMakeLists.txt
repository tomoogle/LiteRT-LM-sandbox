set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Engine Impl ---
add_litertlm_library(runtime_core_engine_impl STATIC
  engine_impl.cc
)
add_library(LiteRTLM::Runtime::Core::EngineImpl ALIAS runtime_core_engine_impl)

target_include_directories(runtime_core_engine_impl
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_core_engine_impl 
  PUBLIC
    LiteRTLM::Runtime::Components::ModelResources::Interface
    runtime_core_session_factory
    runtime_core_tasks
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_audio_executor_settings
    runtime_executor_audio_litert_compiled_model_executor
    runtime_executor_executor_settings_base
    runtime_executor_litert_compiled_model_executor_utils
    runtime_executor_llm_executor
    runtime_executor_llm_executor_settings
    runtime_executor_llm_litert_compiled_model_executor
    runtime_executor_llm_litert_npu_compiled_model_executor
    runtime_executor_magic_number_configs_helper
    runtime_executor_vision_executor
    runtime_executor_vision_executor_settings
    runtime_executor_vision_litert_compiled_model_executor
    runtime_framework_threadpool
    runtime_executor_llm_litert_compiled_model_executor_factory
    runtime_util_file_format_util
    runtime_util_litert_status_util
  PRIVATE
    proto_lib
    LITERTLM_DEPS
    litert_libs
)

# --- Engine Impl (CPU Only) ---
add_litertlm_library(runtime_core_engine_impl_cpu_only STATIC
  engine_impl.cc
)
add_library(LiteRTLM::Runtime::Core::EngineImplCPU ALIAS runtime_core_engine_impl_cpu_only)

target_include_directories(runtime_core_engine_impl_cpu_only 
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_core_engine_impl_cpu_only
  PUBLIC
    LiteRTLM::Runtime::Components::ModelResources::Interface
    runtime_core_tasks
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_audio_executor_settings
    runtime_executor_audio_litert_compiled_model_executor
    runtime_executor_executor_settings_base
    runtime_executor_litert_compiled_model_executor_utils
    runtime_executor_llm_executor
    runtime_executor_llm_executor_settings
    runtime_executor_llm_litert_compiled_model_executor
    runtime_executor_llm_litert_npu_compiled_model_executor
    runtime_executor_magic_number_configs_helper
    runtime_executor_vision_executor
    runtime_executor_vision_executor_settings
    runtime_executor_vision_litert_compiled_model_executor
    runtime_framework_threadpool
    runtime_core_session_factory
    runtime_util_file_format_util
    runtime_util_litert_status_util
  PRIVATE 
    litert_libs
    LITERTLM_DEPS
    proto_lib
)

# --- Pipeline ---
add_litertlm_library(runtime_core_pipeline STATIC
  pipeline.cc
)
add_library(LiteRTLM::Runtime::Core::Pipeline ALIAS runtime_core_pipeline)

target_include_directories(runtime_core_pipeline
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_core_pipeline
  PUBLIC
    runtime_core_tasks
    LiteRTLM::Runtime::Components::Sampler::Interface
    LiteRTLM::Runtime::Components::ScoringCpuUtil
    LiteRTLM::Runtime::Components::StopTokenDetector
    LiteRTLM::Runtime::Components::TokenIdUtil
    LiteRTLM::Runtime::Components::Tokenizer::Interface
    LiteRTLM::Runtime::Components::Sampler::TopP
    LiteRTLM::Runtime::Components::ConstrainedDecoding::Decoder
    LiteRTLM::Runtime::Components::ConstrainedDecoding::Constraint
    runtime_engine_io_types
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor
    runtime_executor_llm_executor_io_types
    runtime_executor_llm_executor_settings
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util     
    runtime_executor_llm_litert_compiled_model_executor
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# --- Session Basic ---
add_litertlm_library(runtime_core_session_basic STATIC
  session_basic.cc
)
add_library(LiteRTLM::Runtime::Core::SessionBasic ALIAS runtime_core_session_basic)

target_include_directories(runtime_core_session_basic
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_core_session_basic
  PUBLIC
    runtime_core_tasks
    runtime_core_pipeline
    LiteRTLM::Runtime::Components::Sampler::Interface
    LiteRTLM::Runtime::Components::Sampler::Factory
    LiteRTLM::Runtime::Components::StopTokenDetector
    LiteRTLM::Runtime::Components::Tokenizer::Interface
    LiteRTLM::Runtime::Components::ConstrainedDecoding::Constraint
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor
    runtime_executor_llm_executor_io_types
    runtime_executor_vision_executor
    runtime_framework_threadpool
    runtime_util_convert_tensor_buffer
    runtime_util_executor_data_util
    runtime_util_litert_status_util
    runtime_util_model_type_utils
    runtime_util_tensor_buffer_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# --- Session Factory ---
add_litertlm_library(runtime_core_session_factory STATIC
  session_factory.cc
)
add_library(LiteRTLM::Runtime::Core::SessionFactory ALIAS runtime_core_session_factory)

target_include_directories(runtime_core_session_factory
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_core_session_factory
  PUBLIC
    runtime_core_tasks
    runtime_core_session_basic
    LiteRTLM::Runtime::Components::Tokenizer::Interface
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_llm_executor
    runtime_executor_vision_executor
    runtime_framework_threadpool
    runtime_util_litert_status_util
    runtime_core_session_utils
  PRIVATE
    LITERTLM_DEPS
    litert_libs  
    proto_lib
)

# --- Session Utils ---
add_litertlm_library(runtime_core_session_utils STATIC
  session_utils.cc
)
add_library(LiteRTLM::Runtime::Core::SessionUtils ALIAS runtime_core_session_utils)

target_include_directories(runtime_core_session_utils
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_core_session_utils
  PUBLIC
    runtime_core_tasks
    runtime_core_session_basic
    LiteRTLM::Runtime::Components::Tokenizer::Interface
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_llm_executor
    runtime_executor_vision_executor
    runtime_framework_threadpool
    runtime_util_litert_status_util
  PRIVATE
    litert_libs
    proto_lib
    LITERTLM_DEPS  
)

# --- Tasks ---
add_litertlm_library(runtime_core_tasks STATIC
  tasks.cc
)
add_library(LiteRTLM::Runtime::Core::Tasks ALIAS runtime_core_tasks)

target_include_directories(runtime_core_tasks
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_core_tasks
  PUBLIC
    runtime_core_session_basic
    LiteRTLM::Runtime::Components::Tokenizer::Interface
    runtime_engine_engine_interface
    runtime_engine_engine_settings
    runtime_engine_io_types
    runtime_executor_audio_executor
    runtime_executor_llm_executor
    runtime_executor_vision_executor
    runtime_framework_threadpool
    runtime_util_litert_status_util
  PRIVATE
    litert_libs     
    proto_lib
    LITERTLM_DEPS
)

# --- Facade ---
add_library(runtime_core_libs INTERFACE)
add_library(LiteRTLM::Runtime::Core ALIAS runtime_core_libs)

target_link_libraries(runtime_core_libs INTERFACE
  LiteRTLM::Runtime::Core::EngineImpl
  LiteRTLM::Runtime::Core::EngineImplCPU
  LiteRTLM::Runtime::Core::Pipeline
  LiteRTLM::Runtime::Core::SessionBasic
  LiteRTLM::Runtime::Core::SessionFactory
  LiteRTLM::Runtime::Core::SessionUtils
  LiteRTLM::Runtime::Core::Tasks
)