set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Engine ---
add_litertlm_library(c_engine STATIC
  "${GEN_C_DIR}/engine.cc"
  "${GEN_C_DIR}/litert_lm_logging.cc"
)
add_library(LiteRTLM::C::Engine ALIAS c_engine)

target_include_directories(c_engine
  PRIVATE
    ${LITERTLM_INCLUDE_PATHS}       # Project Root & Generated Headers
    ${LITERT_INCLUDE_PATHS}         # LiteRT External Headers
    ${THIRD_PARTY_DIR}/json/include # @nlohmann_json//:json
)

target_link_libraries(c_engine
  PRIVATE
    # --- External Dependencies ---
    litert_libs       # Covers @litert//litert/c/internal:litert_logging (via liblitert_c_api/core)
    LITERTLM_DEPS     # Covers @com_google_absl//... (log, status, strings, etc.)

    # --- Internal Dependencies (Mapped from Bazel //runtime/...) ---
    # You must ensure these targets exist in runtime/CMakeLists.txt
    LiteRTLM::Runtime::Conversation                # //runtime/conversation
    LiteRTLM::Runtime::Conversation::IoTypes       # //runtime/conversation:io_types
    LiteRTLM::Runtime::Core::EngineImpl            # //runtime/core:engine_impl
    LiteRTLM::Runtime::Engine::Interface           # //runtime/engine:engine_interface
    LiteRTLM::Runtime::Engine::Settings            # //runtime/engine:engine_settings
    LiteRTLM::Runtime::Engine::IoTypes             # //runtime/engine:io_types
    LiteRTLM::Runtime::Executor::ExecutorSettingsBase # //runtime/executor:executor_settings_base

    # --- Proto Dependencies (Mapped from //runtime/proto:...) ---
    proto_lib         # Covers engine_cc_proto & sampler_params_cc_proto
)
# --- Engine Test (Commented out as per original) ---
# add_executable(c_engine_test
#   "${GEN_C_DIR}/engine_test.cc"
# )
# 
# target_link_libraries(c_engine_test 
#   PRIVATE 
#     LiteRTLM::C::Engine
#     ${LITERTLM_DEPS}
#     ${absl_libs}
# )
# 
# add_test(NAME c_engine_test COMMAND engine_test)

# --- Folder Facade ---
add_library(c_libs INTERFACE)
add_library(LiteRTLM::C ALIAS c_libs)

target_link_libraries(c_libs INTERFACE
  LiteRTLM::C::Engine
)