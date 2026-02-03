
// Generated from AntlrPythonLexer.g4 by ANTLR 4.13.2

#pragma once


#include "antlr4-runtime.h"


namespace antlr_python_tool_call_parser {


class  AntlrPythonLexer : public antlr4::Lexer {
public:
  enum {
    EQ = 1, COLON = 2, SEP = 3, OPEN_PAR = 4, CLOSE_PAR = 5, OPEN_BRACE = 6, 
    CLOSE_BRACE = 7, LIST_OPEN = 8, LIST_CLOSE = 9, BOOL = 10, INT = 11, 
    FLOAT = 12, STRING = 13, NONE = 14, NAME = 15, WS = 16
  };

  explicit AntlrPythonLexer(antlr4::CharStream *input);

  ~AntlrPythonLexer() override;


  std::string getGrammarFileName() const override;

  const std::vector<std::string>& getRuleNames() const override;

  const std::vector<std::string>& getChannelNames() const override;

  const std::vector<std::string>& getModeNames() const override;

  const antlr4::dfa::Vocabulary& getVocabulary() const override;

  antlr4::atn::SerializedATNView getSerializedATN() const override;

  const antlr4::atn::ATN& getATN() const override;

  // By default the static state used to implement the lexer is lazily initialized during the first
  // call to the constructor. You can call this function if you wish to initialize the static state
  // ahead of time.
  static void initialize();

private:

  // Individual action functions triggered by action() above.

  // Individual semantic predicate functions triggered by sempred() above.

};

}  // namespace antlr_python_tool_call_parser
