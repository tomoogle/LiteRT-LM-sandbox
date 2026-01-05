set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# ==============================================================================
# 1. Export Main Executable
#    Bazel: cc_binary(name = "litertlm_export_main" ...)
# ==============================================================================
add_litertlm_executable(schema_cc_litertlm_export_main
  litertlm_export_main.cc
)

target_include_directories(schema_cc_litertlm_export_main 
  PRIVATE
    ${GENERATED_SRC_DIR}
    # ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_cc_litertlm_export_main
  PUBLIC
    LiteRTLM::Schema::Core::Export
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Section
    LITERTLM_DEPS
)

# ==============================================================================
# 2. Peek Executable
#    Bazel: cc_binary(name = "litertlm_peek" ...)
# ==============================================================================
add_litertlm_executable(schema_cc_litertlm_peek
  litertlm_peek.cc
)

target_include_directories(schema_cc_litertlm_peek 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    # ${LITERT_INCLUDE_PATHS}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_cc_litertlm_peek
  PUBLIC
    LiteRTLM::Schema::Core::Read
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Print
    LiteRTLM::Schema::Core::Section
    litert_libs
    LITERTLM_DEPS
)

# ==============================================================================
# 3. Writer Executable
#    Bazel: cc_binary(name = "litertlm_writer" ...)
# ==============================================================================
add_litertlm_executable(schema_cc_litertlm_writer
  litertlm_writer.cc
)

target_include_directories(schema_cc_litertlm_writer 
  PRIVATE
    ${THIRD_PARTY_DIR}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_cc_litertlm_writer
  PUBLIC
    LiteRTLM::Schema::CC::WriterUtils
    LiteRTLM::Schema::Core::Export
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Section
    LITERTLM_DEPS
)

# ==============================================================================
# 4. Writer Utils
#    Bazel: cc_library(name = "litertlm_writer_utils" ...)
# ==============================================================================
add_litertlm_library(schema_cc_litertlm_writer_utils STATIC
  litertlm_writer_utils.cc
)
add_library(LiteRTLM::Schema::CC::WriterUtils ALIAS schema_cc_litertlm_writer_utils)

target_include_directories(schema_cc_litertlm_writer_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_cc_litertlm_writer_utils
  PUBLIC
    LiteRTLM::Schema::Core::Export
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Print
    LiteRTLM::Schema::Core::Section
    LiteRTLM::Schema::Core::Utils
    LITERTLM_DEPS
)

# ==============================================================================
# 5. Folder Facade
# ==============================================================================
add_library(schema_cc_libs INTERFACE)
add_library(LiteRTLM::Schema::CC ALIAS schema_cc_libs)

target_link_libraries(schema_cc_libs INTERFACE
  LiteRTLM::Schema::CC::WriterUtils
)