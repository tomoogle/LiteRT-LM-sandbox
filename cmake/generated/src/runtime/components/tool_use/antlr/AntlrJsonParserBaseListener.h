
// Generated from AntlrJsonParser.g4 by ANTLR 4.13.2

#pragma once


#include "antlr4-runtime.h"
#include "AntlrJsonParserListener.h"


namespace antlr_json_tool_call_parser {

/**
 * This class provides an empty implementation of AntlrJsonParserListener,
 * which can be extended to create a listener which only needs to handle a subset
 * of the available methods.
 */
class  AntlrJsonParserBaseListener : public AntlrJsonParserListener {
public:

  virtual void enterJson(AntlrJsonParser::JsonContext * /*ctx*/) override { }
  virtual void exitJson(AntlrJsonParser::JsonContext * /*ctx*/) override { }

  virtual void enterValue(AntlrJsonParser::ValueContext * /*ctx*/) override { }
  virtual void exitValue(AntlrJsonParser::ValueContext * /*ctx*/) override { }

  virtual void enterObject(AntlrJsonParser::ObjectContext * /*ctx*/) override { }
  virtual void exitObject(AntlrJsonParser::ObjectContext * /*ctx*/) override { }

  virtual void enterPair(AntlrJsonParser::PairContext * /*ctx*/) override { }
  virtual void exitPair(AntlrJsonParser::PairContext * /*ctx*/) override { }

  virtual void enterArray(AntlrJsonParser::ArrayContext * /*ctx*/) override { }
  virtual void exitArray(AntlrJsonParser::ArrayContext * /*ctx*/) override { }

  virtual void enterFunctionNamePair(AntlrJsonParser::FunctionNamePairContext * /*ctx*/) override { }
  virtual void exitFunctionNamePair(AntlrJsonParser::FunctionNamePairContext * /*ctx*/) override { }

  virtual void enterFunctionArgsPair(AntlrJsonParser::FunctionArgsPairContext * /*ctx*/) override { }
  virtual void exitFunctionArgsPair(AntlrJsonParser::FunctionArgsPairContext * /*ctx*/) override { }

  virtual void enterEmptyFunctionCall(AntlrJsonParser::EmptyFunctionCallContext * /*ctx*/) override { }
  virtual void exitEmptyFunctionCall(AntlrJsonParser::EmptyFunctionCallContext * /*ctx*/) override { }

  virtual void enterFullFunctionCall(AntlrJsonParser::FullFunctionCallContext * /*ctx*/) override { }
  virtual void exitFullFunctionCall(AntlrJsonParser::FullFunctionCallContext * /*ctx*/) override { }

  virtual void enterFunctionCall(AntlrJsonParser::FunctionCallContext * /*ctx*/) override { }
  virtual void exitFunctionCall(AntlrJsonParser::FunctionCallContext * /*ctx*/) override { }

  virtual void enterFunctionCallList(AntlrJsonParser::FunctionCallListContext * /*ctx*/) override { }
  virtual void exitFunctionCallList(AntlrJsonParser::FunctionCallListContext * /*ctx*/) override { }


  virtual void enterEveryRule(antlr4::ParserRuleContext * /*ctx*/) override { }
  virtual void exitEveryRule(antlr4::ParserRuleContext * /*ctx*/) override { }
  virtual void visitTerminal(antlr4::tree::TerminalNode * /*node*/) override { }
  virtual void visitErrorNode(antlr4::tree::ErrorNode * /*node*/) override { }

};

}  // namespace antlr_json_tool_call_parser
