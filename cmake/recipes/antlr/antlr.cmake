# include(FetchContent)


# FetchContent_Declare(
#     antlr4_tool
#     URL "https://www.antlr.org/download/antlr-4.13.1-complete.jar"
# )
# FetchContent_MakeAvailable(antlr4_tool)

# set(ANTLR_TOOL_JAR 
#     "${antlr4_tool_SOURCE_DIR}/antlr-4.13.1-complete.jar"
# # )
# # Path to the .g4 file you found
# set(ANTLR_G4_FILES 
#     ${CMAKE_CURRENT_SOURCE_DIR}/*.g4)
# # Directory where the generated .cc and .h files will land
# set(ANTLR_GENERATED_DIR ${CMAKE_CURRENT_BINARY_DIR}/antlr_generated)
# # Ensure the output directory exists
# file(MAKE_DIRECTORY ${ANTLR_GENERATED_DIR})

# Define the command to run ANTLR
# add_custom_command(
#     OUTPUT antlr4_tool   
#     # OUTPUT  ${ANTLR_GENERATED_DIR}/AntlrJsonLexer.h
#     #         ${ANTLR_GENERATED_DIR}/AntlrJsonLexer.cc
#     #         # Add other generated files if needed (e.g., Listener, Visitor)

#     # COMMAND runs the ANTLR jar to generate C++ code (-Dlanguage=Cpp)
#     COMMAND java -jar ${ANTLR_TOOL_JAR}
#             -Dlanguage=Cpp
#             -o ${ANTLR_GENERATED_DIR}
#             ${ANTLR_G4_FILES}
            
#     # DEPENDS ${ANTLR_G4_FILE}
#     WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/runtime/components/tool_use/antlr
#     COMMENT "Running ANTLR to generate C++ parser code..."
# )

