set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# ==============================================================================
# 1. Engine Interface
#    Bazel: cc_library(name = "engine_interface" ...)
# ==============================================================================
add_litertlm_library(runtime_engine_engine_interface INTERFACE)
add_library(LiteRTLM::Runtime::Engine::Interface ALIAS runtime_engine_engine_interface)

target_include_directories(runtime_engine_engine_interface
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_engine_engine_interface
  INTERFACE
    LiteRTLM::Runtime::Engine::Settings
    LiteRTLM::Runtime::Engine::IoTypes
    LiteRTLM::Runtime::Components::Tokenizer::Interface
    LITERTLM_DEPS
)

# ==============================================================================
# 2. Engine Settings
#    Bazel: cc_library(name = "engine_settings" ...)
# ==============================================================================
add_litertlm_library(runtime_engine_engine_settings STATIC
  engine_settings.cc
)
add_library(LiteRTLM::Runtime::Engine::Settings ALIAS runtime_engine_engine_settings)

target_include_directories(runtime_engine_engine_settings 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_engine_engine_settings
  PUBLIC
    LiteRTLM::Runtime::Components::Tokenizer::Interface
    runtime_executor_audio_executor_settings
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_settings
    runtime_executor_vision_executor_settings
    runtime_util_litert_status_util
    runtime_util_model_type_utils
    proto_lib
  PRIVATE
    litert_libs
    LITERTLM_DEPS 
)

# ==============================================================================
# 3. IO Types
#    Bazel: cc_library(name = "io_types" ...)
# ==============================================================================
add_litertlm_library(runtime_engine_io_types STATIC
  io_types.cc
)
add_library(LiteRTLM::Runtime::Engine::IoTypes ALIAS runtime_engine_io_types)

target_include_directories(runtime_engine_io_types
  PRIVATE 
    ${CMAKE_BINARY_DIR}
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}
)

target_link_libraries(runtime_engine_io_types
  PUBLIC
    LiteRTLM::Runtime::Components::ConstrainedDecoding::Constraint
    runtime_util_litert_status_util
    proto_lib
  PRIVATE
    litert_libs
    LITERTLM_DEPS 
)

# ==============================================================================
# 4. Engine Lib (The Core Logic)
#    Bazel: cc_library(name = "litert_lm_lib" ...)
# ==============================================================================
add_litertlm_library(runtime_engine_litert_lm_lib STATIC
  litert_lm_lib.cc
)
add_library(LiteRTLM::Runtime::Engine::Lib ALIAS runtime_engine_litert_lm_lib)

target_include_directories(runtime_engine_litert_lm_lib
  PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}/json/include
)

target_link_libraries(runtime_engine_litert_lm_lib
  PUBLIC
    # Internal Modules (Bazel deps)
    LiteRTLM::Runtime::Conversation
    LiteRTLM::Runtime::Conversation::IoTypes
    LiteRTLM::Runtime::Core::EngineImpl
    LiteRTLM::Runtime::Engine::Interface
    LiteRTLM::Runtime::Engine::Settings
    LiteRTLM::Runtime::Engine::IoTypes
    
    runtime_executor_executor_settings_base
    runtime_executor_llm_executor_settings
    runtime_util_litert_status_util

  PRIVATE
    # External Dependencies (Bazel deps)
    litert_libs # Includes MemoryInfo and MemoryUsageMonitor
    LITERTLM_DEPS
    
    # Specific libs required by this file
    json_lib        # @nlohmann_json//:json
    re2_libs        # @com_googlesource_code_re2//:re2
    stb_lib         # @stb//:stb_image
)

# ==============================================================================
# 5. Shared Flags
#    Bazel: cc_library(name = "shared_flags" ...)
# ==============================================================================
add_litertlm_library(runtime_engine_shared_flags STATIC
  shared_flags.cc
)
add_library(LiteRTLM::Runtime::Engine::SharedFlags ALIAS runtime_engine_shared_flags)

target_include_directories(runtime_engine_shared_flags
  PUBLIC
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_engine_shared_flags
  PRIVATE
    litert_libs
    LITERTLM_DEPS 
)

# ==============================================================================
# 6. Advanced Main Executable
#    Bazel: cc_binary(name = "litert_lm_advanced_main" ...)
# ==============================================================================
add_litertlm_executable(runtime_engine_litert_lm_advanced_main
  litert_lm_advanced_main.cc
)

# [CRITICAL] Linker flags for symbol export (Same as litert_lm_main)
target_link_options(runtime_engine_litert_lm_advanced_main PRIVATE
  "LINKER:--export-dynamic-symbol=LiteRt*"
)

target_link_libraries(runtime_engine_litert_lm_advanced_main
  PRIVATE
    # [CRITICAL] Start the Linker Group
    $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--start-group>
      LiteRTLM::Runtime::Engine::IoTypes
      LiteRTLM::Runtime::Engine::Lib
      LiteRTLM::Runtime::Engine::SharedFlags
      
      # Core/Util Dependencies
      runtime_util_litert_status_util
      
      # External
      litert_libs
      LITERTLM_DEPS
    $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--end-group>
)

# ==============================================================================
# 7. Main Executable (The Target We Care About)
#    Bazel: cc_binary(name = "litert_lm_main" ...)
# ==============================================================================
add_litertlm_executable(litert_lm_main
  litert_lm_main.cc
)

# [CRITICAL] Export LiteRt symbols so the runtime can find them
target_link_options(litert_lm_main PRIVATE
  "LINKER:--export-dynamic-symbol=LiteRt*"
)

target_include_directories(litert_lm_main PRIVATE
  ${LITERTLM_INCLUDE_PATHS}
  ${LITERT_INCLUDE_PATHS}
  ${THIRD_PARTY_DIR}/json/include
)

target_link_libraries(litert_lm_main
  PRIVATE
    # [CRITICAL] Start the Linker Group (Solves Circular Deps)
    $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--start-group>
      
      # 1. Internal Components (Mapped from Bazel deps)
      LiteRTLM::Runtime::Engine::Interface
      LiteRTLM::Runtime::Engine::Settings
      LiteRTLM::Runtime::Engine::IoTypes
      
      LiteRTLM::Runtime::Conversation
      LiteRTLM::Runtime::Conversation::IoTypes
      LiteRTLM::Runtime::Core::EngineImpl
      
      runtime_executor_executor_settings_base
      runtime_executor_llm_executor_settings
      runtime_util_litert_status_util

      # 2. External Dependencies
      litert_libs       
      LITERTLM_DEPS     
      proto_lib
      json_lib          
      
    # [CRITICAL] End the Linker Group
    $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--end-group>
)

# Android Specifics
if(ANDROID)
  target_link_libraries(litert_lm_main PRIVATE EGL GLESv3)
endif()

# ==============================================================================
# 8. Folder Facade
# ==============================================================================
add_library(runtime_engine_libs INTERFACE)
add_library(LiteRTLM::Runtime::Engine ALIAS runtime_engine_libs)

target_link_libraries(runtime_engine_libs INTERFACE
  LiteRTLM::Runtime::Engine::Interface
  LiteRTLM::Runtime::Engine::Settings
  LiteRTLM::Runtime::Engine::IoTypes
  LiteRTLM::Runtime::Engine::Lib
  LiteRTLM::Runtime::Engine::SharedFlags
)