set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Export ---
add_litertlm_library(schema_core_litertlm_export STATIC
  litertlm_export.cc
)
add_library(LiteRTLM::Schema::Core::Export ALIAS schema_core_litertlm_export)

target_include_directories(schema_core_litertlm_export
  PRIVATE 
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_core_litertlm_export 
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    proto_lib
    # flatbuffers (Covered by litert_libs typically, but add if specific version needed)
)

# --- Header ---
add_litertlm_library(schema_core_litertlm_header INTERFACE)
add_library(LiteRTLM::Schema::Core::Header ALIAS schema_core_litertlm_header)

target_include_directories(schema_core_litertlm_header
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Header Schema ---
add_litertlm_library(schema_core_litertlm_header_schema INTERFACE)
add_library(LiteRTLM::Schema::Core::HeaderSchema ALIAS schema_core_litertlm_header_schema)

target_include_directories(schema_core_litertlm_header_schema 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Print ---
add_litertlm_library(schema_core_litertlm_print STATIC
  litertlm_print.cc
)
add_library(LiteRTLM::Schema::Core::Print ALIAS schema_core_litertlm_print)

target_include_directories(schema_core_litertlm_print
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_core_litertlm_print
  PUBLIC
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Read   # (Defined below)
    LiteRTLM::Schema::Core::Utils  # (Defined below)
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

# --- Read ---
add_litertlm_library(schema_core_litertlm_read STATIC
  litertlm_read.cc
)
add_library(LiteRTLM::Schema::Core::Read ALIAS schema_core_litertlm_read)

target_include_directories(schema_core_litertlm_read
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_core_litertlm_read
  PUBLIC
    LiteRTLM::Util::StatusUtil
    LiteRTLM::Util::MemoryMappedFile
    LiteRTLM::Util::ScopedFile
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Utils # (Defined below)
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
    proto_lib
)

# --- Section ---
add_litertlm_library(schema_core_litertlm_section INTERFACE)
add_library(LiteRTLM::Schema::Core::Section ALIAS schema_core_litertlm_section)

target_include_directories(schema_core_litertlm_section 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Utils ---
add_litertlm_library(schema_core_litertlm_utils STATIC
  litertlm_utils.cc
)
add_library(LiteRTLM::Schema::Core::Utils ALIAS schema_core_litertlm_utils)

target_include_directories(schema_core_litertlm_utils 
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_core_litertlm_utils 
  PUBLIC
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Folder Facade ---
add_library(schema_core_libs INTERFACE)
add_library(LiteRTLM::Schema::Core ALIAS schema_core_libs)

target_link_libraries(schema_core_libs INTERFACE
  LiteRTLM::Schema::Core::Export
  LiteRTLM::Schema::Core::Header
  LiteRTLM::Schema::Core::HeaderSchema
  LiteRTLM::Schema::Core::Print
  LiteRTLM::Schema::Core::Read
  LiteRTLM::Schema::Core::Section
  LiteRTLM::Schema::Core::Utils
)