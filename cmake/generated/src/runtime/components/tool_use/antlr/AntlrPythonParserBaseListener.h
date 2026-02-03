
// Generated from AntlrPythonParser.g4 by ANTLR 4.13.2

#pragma once


#include "antlr4-runtime.h"
#include "AntlrPythonParserListener.h"


namespace antlr_python_tool_call_parser {

/**
 * This class provides an empty implementation of AntlrPythonParserListener,
 * which can be extended to create a listener which only needs to handle a subset
 * of the available methods.
 */
class  AntlrPythonParserBaseListener : public AntlrPythonParserListener {
public:

  virtual void enterMain(AntlrPythonParser::MainContext * /*ctx*/) override { }
  virtual void exitMain(AntlrPythonParser::MainContext * /*ctx*/) override { }

  virtual void enterExpr(AntlrPythonParser::ExprContext * /*ctx*/) override { }
  virtual void exitExpr(AntlrPythonParser::ExprContext * /*ctx*/) override { }

  virtual void enterValue(AntlrPythonParser::ValueContext * /*ctx*/) override { }
  virtual void exitValue(AntlrPythonParser::ValueContext * /*ctx*/) override { }

  virtual void enterList(AntlrPythonParser::ListContext * /*ctx*/) override { }
  virtual void exitList(AntlrPythonParser::ListContext * /*ctx*/) override { }

  virtual void enterDict(AntlrPythonParser::DictContext * /*ctx*/) override { }
  virtual void exitDict(AntlrPythonParser::DictContext * /*ctx*/) override { }

  virtual void enterArgVal(AntlrPythonParser::ArgValContext * /*ctx*/) override { }
  virtual void exitArgVal(AntlrPythonParser::ArgValContext * /*ctx*/) override { }

  virtual void enterArgValExpr(AntlrPythonParser::ArgValExprContext * /*ctx*/) override { }
  virtual void exitArgValExpr(AntlrPythonParser::ArgValExprContext * /*ctx*/) override { }

  virtual void enterObject(AntlrPythonParser::ObjectContext * /*ctx*/) override { }
  virtual void exitObject(AntlrPythonParser::ObjectContext * /*ctx*/) override { }

  virtual void enterEmptyFunctionCall(AntlrPythonParser::EmptyFunctionCallContext * /*ctx*/) override { }
  virtual void exitEmptyFunctionCall(AntlrPythonParser::EmptyFunctionCallContext * /*ctx*/) override { }

  virtual void enterFullFunctionCall(AntlrPythonParser::FullFunctionCallContext * /*ctx*/) override { }
  virtual void exitFullFunctionCall(AntlrPythonParser::FullFunctionCallContext * /*ctx*/) override { }

  virtual void enterFunctionCall(AntlrPythonParser::FunctionCallContext * /*ctx*/) override { }
  virtual void exitFunctionCall(AntlrPythonParser::FunctionCallContext * /*ctx*/) override { }

  virtual void enterFunctionCallList(AntlrPythonParser::FunctionCallListContext * /*ctx*/) override { }
  virtual void exitFunctionCallList(AntlrPythonParser::FunctionCallListContext * /*ctx*/) override { }


  virtual void enterEveryRule(antlr4::ParserRuleContext * /*ctx*/) override { }
  virtual void exitEveryRule(antlr4::ParserRuleContext * /*ctx*/) override { }
  virtual void visitTerminal(antlr4::tree::TerminalNode * /*node*/) override { }
  virtual void visitErrorNode(antlr4::tree::ErrorNode * /*node*/) override { }

};

}  // namespace antlr_python_tool_call_parser
