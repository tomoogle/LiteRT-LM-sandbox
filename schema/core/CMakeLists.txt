set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# ==============================================================================
# 1. Header Schema (Consuming the pre-generated FlatBuffer)
#    Bazel: flatbuffer_cc_library(name = "litertlm_header_schema", ...)
# ==============================================================================
# Note: The generation of 'litertlm_header_schema_generated.h' is handled 
# globally by 'flatbuffers.cmake' using 'compile_flatbuffer_files'.

add_litertlm_library(schema_core_litertlm_header_schema INTERFACE)
add_library(LiteRTLM::Schema::Core::HeaderSchema ALIAS schema_core_litertlm_header_schema)

# We need to ensure the generation happens before this target is used.
# Since 'flatbuffers.cmake' added the custom command but didn't create a target 
# we can depend on directly, we rely on CMake finding the generated source 
# if we add it to a target, OR we rely on the implicit file dependency.
#
# However, for an INTERFACE library, we can't list sources easily. 
# We ensure the include directories point to where the generator put the file.

target_include_directories(schema_core_litertlm_header_schema 
  INTERFACE
    ${GENERATED_SRC_DIR} # This allows #include "schema/core/litertlm_header_schema_generated.h"
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_core_litertlm_header_schema
  INTERFACE
    flatbuffers_libs # [FIX] Required for the generated headers
)

# ==============================================================================
# 2. Header
#    Bazel: cc_library(name = "litertlm_header", ...)
# ==============================================================================
add_litertlm_library(schema_core_litertlm_header INTERFACE)
add_library(LiteRTLM::Schema::Core::Header ALIAS schema_core_litertlm_header)

target_include_directories(schema_core_litertlm_header
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_core_litertlm_header
  INTERFACE
    LiteRTLM::Schema::Core::HeaderSchema
    flatbuffers_libs
    LITERTLM_DEPS
)

# ==============================================================================
# 3. Utils
#    Bazel: cc_library(name = "litertlm_utils", ...)
# ==============================================================================
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
    flatbuffers_libs # [FIX] Explicit dep
)

# ==============================================================================
# 4. Read
#    Bazel: cc_library(name = "litertlm_read", ...)
# ==============================================================================
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
    LiteRTLM::Runtime::Util::LiteRtStatusUtil
    LiteRTLM::Runtime::Util::MemoryMappedFile
    LiteRTLM::Runtime::Util::ScopedFile
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Utils
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
    proto_lib
    sentencepiece_libs # [FIX] Explicit dep
    zlib_lib           # [FIX] Explicit dep
)

# ==============================================================================
# 5. Section
#    Bazel: cc_library(name = "litertlm_section", ...)
# ==============================================================================
add_litertlm_library(schema_core_litertlm_section INTERFACE)
add_library(LiteRTLM::Schema::Core::Section ALIAS schema_core_litertlm_section)

target_include_directories(schema_core_litertlm_section 
  INTERFACE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(schema_core_litertlm_section
  INTERFACE
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Runtime::Util::LiteRtStatusUtil
    flatbuffers_libs # [FIX] Explicit dep
    zlib_lib         # [FIX] Explicit dep
    LITERTLM_DEPS
)

# ==============================================================================
# 6. Export
#    Bazel: cc_library(name = "litertlm_export", ...)
# ==============================================================================
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
    LiteRTLM::Schema::Core::Header
    LiteRTLM::Schema::Core::HeaderSchema
    LiteRTLM::Schema::Core::Section
    LiteRTLM::Schema::Core::Utils # [FIX] Added missing link
    LITERTLM_DEPS
    litert_libs
    proto_lib
    flatbuffers_libs # [FIX] Explicit dep
)

# ==============================================================================
# 7. Print
#    Bazel: cc_library(name = "litertlm_print", ...)
# ==============================================================================
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
    LiteRTLM::Schema::Core::Read   
    LiteRTLM::Schema::Core::Utils  
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

# ==============================================================================
# 8. Folder Facade
# ==============================================================================
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