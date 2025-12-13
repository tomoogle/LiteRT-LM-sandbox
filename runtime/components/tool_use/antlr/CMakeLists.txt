set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR}) 
set(ANTLR_TOOL_JAR "${PROJECT_ROOT}/antlr-4.13.2-complete.jar")

# Ensure the output directory exists
set(ANTLR_GENERATED_DIR ${CMAKE_CURRENT_BINARY_DIR}/antlr_generated)
file(MAKE_DIRECTORY ${ANTLR_GENERATED_DIR})


add_custom_command(
    OUTPUT
        ${PKG_ROOT}/AntlrJsonLexer.h
        ${PKG_ROOT}/AntlrJsonParser.h
        ${PKG_ROOT}/AntlrJsonLexer.cc
        ${PKG_ROOT}/AntlrJsonParser.cc
        ${PKG_ROOT}/AntlrJsonParserBaseListener.h
        ${PKG_ROOT}/AntlrJsonParserListener.h
        
    COMMAND java -jar ${ANTLR_TOOL_JAR}
            -Dlanguage=Cpp
            -listener -visitor # Replicates Bazel's listener=True
            -o ${PKG_ROOT}
            -package antlr_json_tool_call_parser
            ${PKG_ROOT}/AntlrJsonLexer.g4 
            ${PKG_ROOT}/AntlrJsonParser.g4
            
    DEPENDS ${PKG_ROOT}/AntlrJsonLexer.g4 ${PKG_ROOT}/AntlrJsonParser.g4
    COMMENT "Generating JSON Parser C++ code..."
)

add_library(antlr_json_tool_call_parser STATIC 
    ${PKG_ROOT}/AntlrJsonLexer.cpp
    ${PKG_ROOT}/AntlrJsonParser.cpp
)

# Set the interface for consumers (must be PUBLIC)
target_include_directories(antlr_json_tool_call_parser
    PUBLIC
    ${PKG_ROOT}
)

# Link to the ANTLR C++ runtime library
target_link_libraries(antlr_json_tool_call_parser
    PUBLIC
    antlr4_static
)

add_custom_command(
    OUTPUT
        ${PKG_ROOT}/AntlrPythonLexer.h
        ${PKG_ROOT}/AntlrPythonParser.h
        ${PKG_ROOT}/AntlrPythonLexer.cc
        ${PKG_ROOT}/AntlrPythonParser.cc
        ${PKG_ROOT}/AntlrPythonParserBaseListener.h
        ${PKG_ROOT}/AntlrPythonParserListener.h
        
    COMMAND java -jar ${ANTLR_TOOL_JAR}
            -Dlanguage=Cpp
            -listener -visitor 
            -o ${ANTLR_GENERATED_DIR}
            -package antlr_python_tool_call_parser
            ${PKG_ROOT}/AntlrPythonLexer.g4 
            ${PKG_ROOT}/AntlrPythonParser.g4
            
    DEPENDS ${PKG_ROOT}/AntlrPythonLexer.g4 ${PKG_ROOT}/AntlrPythonParser.g4
    COMMENT "Generating Python Parser C++ code..."
)

add_library(antlr_python_tool_call_parser STATIC 
    ${PKG_ROOT}/AntlrPythonLexer.cpp
    ${PKG_ROOT}/AntlrPythonParser.cpp
)

target_include_directories(antlr_python_tool_call_parser
    PUBLIC
    ${PKG_ROOT}
)

target_link_libraries(antlr_python_tool_call_parser
    PUBLIC
    antlr4_static
)