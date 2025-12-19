
// Generated from AntlrPythonParser.g4 by ANTLR 4.13.2

#pragma once


#include "antlr4-runtime.h"
#include "AntlrPythonParser.h"


namespace antlr_python_tool_call_parser {

/**
 * This interface defines an abstract listener for a parse tree produced by AntlrPythonParser.
 */
class  AntlrPythonParserListener : public antlr4::tree::ParseTreeListener {
public:

  virtual void enterMain(AntlrPythonParser::MainContext *ctx) = 0;
  virtual void exitMain(AntlrPythonParser::MainContext *ctx) = 0;

  virtual void enterExpr(AntlrPythonParser::ExprContext *ctx) = 0;
  virtual void exitExpr(AntlrPythonParser::ExprContext *ctx) = 0;

  virtual void enterValue(AntlrPythonParser::ValueContext *ctx) = 0;
  virtual void exitValue(AntlrPythonParser::ValueContext *ctx) = 0;

  virtual void enterList(AntlrPythonParser::ListContext *ctx) = 0;
  virtual void exitList(AntlrPythonParser::ListContext *ctx) = 0;

  virtual void enterDict(AntlrPythonParser::DictContext *ctx) = 0;
  virtual void exitDict(AntlrPythonParser::DictContext *ctx) = 0;

  virtual void enterArgVal(AntlrPythonParser::ArgValContext *ctx) = 0;
  virtual void exitArgVal(AntlrPythonParser::ArgValContext *ctx) = 0;

  virtual void enterArgValExpr(AntlrPythonParser::ArgValExprContext *ctx) = 0;
  virtual void exitArgValExpr(AntlrPythonParser::ArgValExprContext *ctx) = 0;

  virtual void enterObject(AntlrPythonParser::ObjectContext *ctx) = 0;
  virtual void exitObject(AntlrPythonParser::ObjectContext *ctx) = 0;

  virtual void enterEmptyFunctionCall(AntlrPythonParser::EmptyFunctionCallContext *ctx) = 0;
  virtual void exitEmptyFunctionCall(AntlrPythonParser::EmptyFunctionCallContext *ctx) = 0;

  virtual void enterFullFunctionCall(AntlrPythonParser::FullFunctionCallContext *ctx) = 0;
  virtual void exitFullFunctionCall(AntlrPythonParser::FullFunctionCallContext *ctx) = 0;

  virtual void enterFunctionCall(AntlrPythonParser::FunctionCallContext *ctx) = 0;
  virtual void exitFunctionCall(AntlrPythonParser::FunctionCallContext *ctx) = 0;

  virtual void enterFunctionCallList(AntlrPythonParser::FunctionCallListContext *ctx) = 0;
  virtual void exitFunctionCallList(AntlrPythonParser::FunctionCallListContext *ctx) = 0;


};

}  // namespace antlr_python_tool_call_parser
