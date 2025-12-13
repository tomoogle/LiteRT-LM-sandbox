
// Generated from AntlrJsonParser.g4 by ANTLR 4.13.2

#pragma once


#include "antlr4-runtime.h"
#include "AntlrJsonParser.h"


namespace antlr_json_tool_call_parser {

/**
 * This interface defines an abstract listener for a parse tree produced by AntlrJsonParser.
 */
class  AntlrJsonParserListener : public antlr4::tree::ParseTreeListener {
public:

  virtual void enterJson(AntlrJsonParser::JsonContext *ctx) = 0;
  virtual void exitJson(AntlrJsonParser::JsonContext *ctx) = 0;

  virtual void enterValue(AntlrJsonParser::ValueContext *ctx) = 0;
  virtual void exitValue(AntlrJsonParser::ValueContext *ctx) = 0;

  virtual void enterObject(AntlrJsonParser::ObjectContext *ctx) = 0;
  virtual void exitObject(AntlrJsonParser::ObjectContext *ctx) = 0;

  virtual void enterPair(AntlrJsonParser::PairContext *ctx) = 0;
  virtual void exitPair(AntlrJsonParser::PairContext *ctx) = 0;

  virtual void enterArray(AntlrJsonParser::ArrayContext *ctx) = 0;
  virtual void exitArray(AntlrJsonParser::ArrayContext *ctx) = 0;

  virtual void enterFunctionNamePair(AntlrJsonParser::FunctionNamePairContext *ctx) = 0;
  virtual void exitFunctionNamePair(AntlrJsonParser::FunctionNamePairContext *ctx) = 0;

  virtual void enterFunctionArgsPair(AntlrJsonParser::FunctionArgsPairContext *ctx) = 0;
  virtual void exitFunctionArgsPair(AntlrJsonParser::FunctionArgsPairContext *ctx) = 0;

  virtual void enterEmptyFunctionCall(AntlrJsonParser::EmptyFunctionCallContext *ctx) = 0;
  virtual void exitEmptyFunctionCall(AntlrJsonParser::EmptyFunctionCallContext *ctx) = 0;

  virtual void enterFullFunctionCall(AntlrJsonParser::FullFunctionCallContext *ctx) = 0;
  virtual void exitFullFunctionCall(AntlrJsonParser::FullFunctionCallContext *ctx) = 0;

  virtual void enterFunctionCall(AntlrJsonParser::FunctionCallContext *ctx) = 0;
  virtual void exitFunctionCall(AntlrJsonParser::FunctionCallContext *ctx) = 0;

  virtual void enterFunctionCallList(AntlrJsonParser::FunctionCallListContext *ctx) = 0;
  virtual void exitFunctionCallList(AntlrJsonParser::FunctionCallListContext *ctx) = 0;


};

}  // namespace antlr_json_tool_call_parser
