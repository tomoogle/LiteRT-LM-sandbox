set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Export Main Executable ---
add_litertlm_executable(schema_cc_litertlm_export_main
  litertlm_export_main.cc
)

target_include_directories(schema_cc_litertlm_export_main 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
    ${THIRD_PARTY_DIR}
)

target_link_libraries(schema_cc_litertlm_export_main
  PUBLIC
    LiteRTLM::Schema::Core::Export
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Section
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# --- Peek Executable ---
add_litertlm_executable(schema_cc_litertlm_peek
  litertlm_peek.cc
)

target_include_directories(schema_cc_litertlm_peek 
  PRIVATE
    ${THIRD_PARTY_DIR}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
    ${LITERT_INCLUDE_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_cc_litertlm_peek
  PUBLIC
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Print
    LiteRTLM::Schema::Core::Read
    LiteRTLM::Schema::Core::Section
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Writer Executable ---
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
    LiteRTLM::Schema::CC::WriterUtils # (Defined below)
    LiteRTLM::Schema::Core::Export
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Section
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# --- Writer Utils ---
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
  PRIVATE
    LITERTLM_DEPS
    proto_lib
    litert_libs
)

# --- Folder Facade ---
add_library(schema_cc_libs INTERFACE)
add_library(LiteRTLM::Schema::CC ALIAS schema_cc_libs)

target_link_libraries(schema_cc_libs INTERFACE
  LiteRTLM::Schema::CC::WriterUtils
)