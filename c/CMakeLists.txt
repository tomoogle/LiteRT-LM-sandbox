set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# ==============================================================================
# 1. Engine Library
#    Bazel: cc_library(name = "engine", ...)
# ==============================================================================
add_litertlm_library(c_engine STATIC
  "${GEN_C_DIR}/engine.cc"
  "${GEN_C_DIR}/litert_lm_logging.cc"
)
add_library(LiteRTLM::C::Engine ALIAS c_engine)

target_include_directories(c_engine
  PRIVATE
    ${LITERTLM_INCLUDE_PATHS}        # Project Root & Generated Headers
    ${LITERT_INCLUDE_PATHS}          # LiteRT External Headers
    ${THIRD_PARTY_DIR}/json/include # @nlohmann_json//:json
)

target_link_libraries(c_engine
  PRIVATE
    # --- External Dependencies ---
    litert_libs       # Covers @litert//litert/c/internal:litert_logging
    proto_lib         # Covers engine_cc_proto & sampler_params_cc_proto
    LITERTLM_DEPS     # Covers absl (log, status, strings, etc.)
    
    # --- Internal Dependencies ---
    LiteRTLM::Runtime::Conversation
    LiteRTLM::Runtime::Conversation::IoTypes
    LiteRTLM::Runtime::Core::EngineImpl
    LiteRTLM::Runtime::Engine::Interface
    LiteRTLM::Runtime::Engine::Settings
    LiteRTLM::Runtime::Engine::IoTypes
    LiteRTLM::Runtime::Executor::ExecutorSettingsBase
)

# ==============================================================================
# 2. Folder Facade
# ==============================================================================
add_library(c_libs INTERFACE)
add_library(LiteRTLM::C ALIAS c_libs)

target_link_libraries(c_libs INTERFACE
  LiteRTLM::C::Engine
)