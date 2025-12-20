set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# Important: Build the ANTLR dependency first
add_subdirectory(antlr)

# --- JSON Parser Utils ---
add_litertlm_library(runtime_components_tool_use_json_parser_utils STATIC
  json_parser_utils.cc
)
add_library(LiteRTLM::ToolUse::JsonUtils ALIAS runtime_components_tool_use_json_parser_utils)

target_include_directories(runtime_components_tool_use_json_parser_utils 
  PRIVATE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
)

target_link_libraries(runtime_components_tool_use_json_parser_utils
  PUBLIC
    LiteRTLM::ToolUse::ParserCommon # (Defined below)
    LiteRTLM::ToolUse::Antlr::Json  # Inherits generated headers path automatically
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Parser Common ---
add_litertlm_library(runtime_components_tool_use_parser_common STATIC
  parser_common.cc
)
add_library(LiteRTLM::ToolUse::ParserCommon ALIAS runtime_components_tool_use_parser_common)

target_include_directories(runtime_components_tool_use_parser_common
  PRIVATE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
)

target_link_libraries(runtime_components_tool_use_parser_common
  PUBLIC
    LiteRTLM::ToolUse::Antlr::Json
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Parser Utils ---
add_litertlm_library(runtime_components_tool_use_parser_utils STATIC
  parser_utils.cc
)
add_library(LiteRTLM::ToolUse::ParserUtils ALIAS runtime_components_tool_use_parser_utils)

target_include_directories(runtime_components_tool_use_parser_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_tool_use_parser_utils
  PUBLIC
    LiteRTLM::ToolUse::Antlr::Json
    LiteRTLM::ToolUse::Antlr::Python
    LiteRTLM::ToolUse::JsonUtils
    LiteRTLM::ToolUse::PythonUtils # (Defined below)
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Python Parser Utils ---
add_litertlm_library(runtime_components_tool_use_python_parser_utils STATIC
  python_parser_utils.cc
)
add_library(LiteRTLM::ToolUse::PythonUtils ALIAS runtime_components_tool_use_python_parser_utils)

target_include_directories(runtime_components_tool_use_python_parser_utils 
  PRIVATE 
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_tool_use_python_parser_utils
  PUBLIC
    LiteRTLM::ToolUse::ParserCommon
    LiteRTLM::ToolUse::Antlr::Python
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Python Tool Format Utils ---
add_litertlm_library(runtime_components_tool_use_python_tool_format_utils STATIC
  python_tool_format_utils.cc
)
add_library(LiteRTLM::ToolUse::PythonFormatUtils ALIAS runtime_components_tool_use_python_tool_format_utils)

target_include_directories(runtime_components_tool_use_python_tool_format_utils
  PRIVATE
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_components_tool_use_python_tool_format_utils
  PUBLIC
    runtime_util_litert_status_util
    LiteRTLM::ToolUse::Antlr::Json
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Folder Facade ---
add_library(runtime_components_tool_use_libs INTERFACE)
add_library(LiteRTLM::ToolUse ALIAS runtime_components_tool_use_libs)

target_link_libraries(runtime_components_tool_use_libs INTERFACE
  LiteRTLM::ToolUse::Antlr::Json
  LiteRTLM::ToolUse::Antlr::Python
  LiteRTLM::ToolUse::JsonUtils
  LiteRTLM::ToolUse::ParserCommon
  LiteRTLM::ToolUse::ParserUtils
  LiteRTLM::ToolUse::PythonUtils
  LiteRTLM::ToolUse::PythonFormatUtils
)