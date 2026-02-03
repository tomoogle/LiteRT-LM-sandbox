
// Generated from AntlrJsonParser.g4 by ANTLR 4.13.2

#pragma once


#include "antlr4-runtime.h"


namespace antlr_json_tool_call_parser {


class  AntlrJsonParser : public antlr4::Parser {
public:
  enum {
    OPEN_BRACE = 1, CLOSE_BRACE = 2, OPEN_BRACKET = 3, CLOSE_BRACKET = 4, 
    COMMA = 5, COLON = 6, BOOLEAN = 7, NONE = 8, FUNCTION_NAME = 9, FUNCTION_ARGUMENTS = 10, 
    STRING = 11, NUMBER = 12, WS = 13
  };

  enum {
    RuleJson = 0, RuleValue = 1, RuleObject = 2, RulePair = 3, RuleArray = 4, 
    RuleFunctionNamePair = 5, RuleFunctionArgsPair = 6, RuleEmptyFunctionCall = 7, 
    RuleFullFunctionCall = 8, RuleFunctionCall = 9, RuleFunctionCallList = 10
  };

  explicit AntlrJsonParser(antlr4::TokenStream *input);

  AntlrJsonParser(antlr4::TokenStream *input, const antlr4::atn::ParserATNSimulatorOptions &options);

  ~AntlrJsonParser() override;

  std::string getGrammarFileName() const override;

  const antlr4::atn::ATN& getATN() const override;

  const std::vector<std::string>& getRuleNames() const override;

  const antlr4::dfa::Vocabulary& getVocabulary() const override;

  antlr4::atn::SerializedATNView getSerializedATN() const override;


  class JsonContext;
  class ValueContext;
  class ObjectContext;
  class PairContext;
  class ArrayContext;
  class FunctionNamePairContext;
  class FunctionArgsPairContext;
  class EmptyFunctionCallContext;
  class FullFunctionCallContext;
  class FunctionCallContext;
  class FunctionCallListContext; 

  class  JsonContext : public antlr4::ParserRuleContext {
  public:
    JsonContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    FunctionCallContext *functionCall();
    FunctionCallListContext *functionCallList();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  JsonContext* json();

  class  ValueContext : public antlr4::ParserRuleContext {
  public:
    ValueContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *STRING();
    antlr4::tree::TerminalNode *NUMBER();
    ObjectContext *object();
    ArrayContext *array();
    antlr4::tree::TerminalNode *BOOLEAN();
    antlr4::tree::TerminalNode *NONE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  ValueContext* value();

  class  ObjectContext : public antlr4::ParserRuleContext {
  public:
    ObjectContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OPEN_BRACE();
    std::vector<PairContext *> pair();
    PairContext* pair(size_t i);
    antlr4::tree::TerminalNode *CLOSE_BRACE();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  ObjectContext* object();

  class  PairContext : public antlr4::ParserRuleContext {
  public:
    PairContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *STRING();
    antlr4::tree::TerminalNode *COLON();
    ValueContext *value();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  PairContext* pair();

  class  ArrayContext : public antlr4::ParserRuleContext {
  public:
    ArrayContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OPEN_BRACKET();
    std::vector<ValueContext *> value();
    ValueContext* value(size_t i);
    antlr4::tree::TerminalNode *CLOSE_BRACKET();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  ArrayContext* array();

  class  FunctionNamePairContext : public antlr4::ParserRuleContext {
  public:
    FunctionNamePairContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *FUNCTION_NAME();
    antlr4::tree::TerminalNode *COLON();
    antlr4::tree::TerminalNode *STRING();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  FunctionNamePairContext* functionNamePair();

  class  FunctionArgsPairContext : public antlr4::ParserRuleContext {
  public:
    FunctionArgsPairContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *FUNCTION_ARGUMENTS();
    antlr4::tree::TerminalNode *COLON();
    ObjectContext *object();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  FunctionArgsPairContext* functionArgsPair();

  class  EmptyFunctionCallContext : public antlr4::ParserRuleContext {
  public:
    EmptyFunctionCallContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OPEN_BRACE();
    antlr4::tree::TerminalNode *CLOSE_BRACE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  EmptyFunctionCallContext* emptyFunctionCall();

  class  FullFunctionCallContext : public antlr4::ParserRuleContext {
  public:
    FullFunctionCallContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OPEN_BRACE();
    FunctionNamePairContext *functionNamePair();
    antlr4::tree::TerminalNode *COMMA();
    FunctionArgsPairContext *functionArgsPair();
    antlr4::tree::TerminalNode *CLOSE_BRACE();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  FullFunctionCallContext* fullFunctionCall();

  class  FunctionCallContext : public antlr4::ParserRuleContext {
  public:
    FunctionCallContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    FullFunctionCallContext *fullFunctionCall();
    EmptyFunctionCallContext *emptyFunctionCall();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  FunctionCallContext* functionCall();

  class  FunctionCallListContext : public antlr4::ParserRuleContext {
  public:
    FunctionCallListContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OPEN_BRACKET();
    std::vector<FunctionCallContext *> functionCall();
    FunctionCallContext* functionCall(size_t i);
    antlr4::tree::TerminalNode *CLOSE_BRACKET();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  FunctionCallListContext* functionCallList();


  // By default the static state used to implement the parser is lazily initialized during the first
  // call to the constructor. You can call this function if you wish to initialize the static state
  // ahead of time.
  static void initialize();

private:
};

}  // namespace antlr_json_tool_call_parser
