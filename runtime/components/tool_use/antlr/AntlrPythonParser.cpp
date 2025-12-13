
// Generated from AntlrPythonParser.g4 by ANTLR 4.13.2


#include "AntlrPythonParserListener.h"

#include "AntlrPythonParser.h"


using namespace antlrcpp;
using namespace antlr_python_tool_call_parser;

using namespace antlr4;

namespace {

struct AntlrPythonParserStaticData final {
  AntlrPythonParserStaticData(std::vector<std::string> ruleNames,
                        std::vector<std::string> literalNames,
                        std::vector<std::string> symbolicNames)
      : ruleNames(std::move(ruleNames)), literalNames(std::move(literalNames)),
        symbolicNames(std::move(symbolicNames)),
        vocabulary(this->literalNames, this->symbolicNames) {}

  AntlrPythonParserStaticData(const AntlrPythonParserStaticData&) = delete;
  AntlrPythonParserStaticData(AntlrPythonParserStaticData&&) = delete;
  AntlrPythonParserStaticData& operator=(const AntlrPythonParserStaticData&) = delete;
  AntlrPythonParserStaticData& operator=(AntlrPythonParserStaticData&&) = delete;

  std::vector<antlr4::dfa::DFA> decisionToDFA;
  antlr4::atn::PredictionContextCache sharedContextCache;
  const std::vector<std::string> ruleNames;
  const std::vector<std::string> literalNames;
  const std::vector<std::string> symbolicNames;
  const antlr4::dfa::Vocabulary vocabulary;
  antlr4::atn::SerializedATNView serializedATN;
  std::unique_ptr<antlr4::atn::ATN> atn;
};

::antlr4::internal::OnceFlag antlrpythonparserParserOnceFlag;
#if ANTLR4_USE_THREAD_LOCAL_CACHE
static thread_local
#endif
std::unique_ptr<AntlrPythonParserStaticData> antlrpythonparserParserStaticData = nullptr;

void antlrpythonparserParserInitialize() {
#if ANTLR4_USE_THREAD_LOCAL_CACHE
  if (antlrpythonparserParserStaticData != nullptr) {
    return;
  }
#else
  assert(antlrpythonparserParserStaticData == nullptr);
#endif
  auto staticData = std::make_unique<AntlrPythonParserStaticData>(
    std::vector<std::string>{
      "main", "expr", "value", "list", "dict", "argVal", "argValExpr", "object", 
      "emptyFunctionCall", "fullFunctionCall", "functionCall", "functionCallList"
    },
    std::vector<std::string>{
      "", "'='", "':'", "','", "'('", "')'", "'{'", "'}'", "'['", "']'", 
      "", "", "", "", "'None'"
    },
    std::vector<std::string>{
      "", "EQ", "COLON", "SEP", "OPEN_PAR", "CLOSE_PAR", "OPEN_BRACE", "CLOSE_BRACE", 
      "LIST_OPEN", "LIST_CLOSE", "BOOL", "INT", "FLOAT", "STRING", "NONE", 
      "NAME", "WS"
    }
  );
  static const int32_t serializedATNSegment[] = {
  	4,1,16,126,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,2,
  	7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,1,0,1,0,1,0,1,1,4,1,29,8,1,
  	11,1,12,1,30,1,1,3,1,34,8,1,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3,2,44,8,
  	2,1,3,1,3,1,3,1,3,5,3,50,8,3,10,3,12,3,53,9,3,3,3,55,8,3,1,3,1,3,1,4,
  	1,4,1,4,1,4,1,4,1,4,1,4,1,4,5,4,67,8,4,10,4,12,4,70,9,4,3,4,72,8,4,1,
  	4,1,4,1,5,1,5,1,5,1,5,1,6,1,6,1,6,5,6,83,8,6,10,6,12,6,86,9,6,1,7,1,7,
  	1,7,1,7,1,7,1,7,1,7,1,7,3,7,96,8,7,1,8,1,8,1,8,1,8,1,9,1,9,1,9,1,9,1,
  	9,1,10,1,10,3,10,109,8,10,1,11,1,11,1,11,1,11,5,11,115,8,11,10,11,12,
  	11,118,9,11,1,11,1,11,1,11,1,11,3,11,124,8,11,1,11,0,0,12,0,2,4,6,8,10,
  	12,14,16,18,20,22,0,0,131,0,24,1,0,0,0,2,33,1,0,0,0,4,43,1,0,0,0,6,45,
  	1,0,0,0,8,58,1,0,0,0,10,75,1,0,0,0,12,79,1,0,0,0,14,95,1,0,0,0,16,97,
  	1,0,0,0,18,101,1,0,0,0,20,108,1,0,0,0,22,123,1,0,0,0,24,25,3,2,1,0,25,
  	26,5,0,0,1,26,1,1,0,0,0,27,29,3,20,10,0,28,27,1,0,0,0,29,30,1,0,0,0,30,
  	28,1,0,0,0,30,31,1,0,0,0,31,34,1,0,0,0,32,34,3,22,11,0,33,28,1,0,0,0,
  	33,32,1,0,0,0,34,3,1,0,0,0,35,44,5,11,0,0,36,44,5,12,0,0,37,44,5,10,0,
  	0,38,44,5,13,0,0,39,44,5,14,0,0,40,44,3,6,3,0,41,44,3,8,4,0,42,44,3,14,
  	7,0,43,35,1,0,0,0,43,36,1,0,0,0,43,37,1,0,0,0,43,38,1,0,0,0,43,39,1,0,
  	0,0,43,40,1,0,0,0,43,41,1,0,0,0,43,42,1,0,0,0,44,5,1,0,0,0,45,54,5,8,
  	0,0,46,51,3,4,2,0,47,48,5,3,0,0,48,50,3,4,2,0,49,47,1,0,0,0,50,53,1,0,
  	0,0,51,49,1,0,0,0,51,52,1,0,0,0,52,55,1,0,0,0,53,51,1,0,0,0,54,46,1,0,
  	0,0,54,55,1,0,0,0,55,56,1,0,0,0,56,57,5,9,0,0,57,7,1,0,0,0,58,71,5,6,
  	0,0,59,60,5,13,0,0,60,61,5,2,0,0,61,68,3,4,2,0,62,63,5,3,0,0,63,64,5,
  	13,0,0,64,65,5,2,0,0,65,67,3,4,2,0,66,62,1,0,0,0,67,70,1,0,0,0,68,66,
  	1,0,0,0,68,69,1,0,0,0,69,72,1,0,0,0,70,68,1,0,0,0,71,59,1,0,0,0,71,72,
  	1,0,0,0,72,73,1,0,0,0,73,74,5,7,0,0,74,9,1,0,0,0,75,76,5,15,0,0,76,77,
  	5,1,0,0,77,78,3,4,2,0,78,11,1,0,0,0,79,84,3,10,5,0,80,81,5,3,0,0,81,83,
  	3,10,5,0,82,80,1,0,0,0,83,86,1,0,0,0,84,82,1,0,0,0,84,85,1,0,0,0,85,13,
  	1,0,0,0,86,84,1,0,0,0,87,88,5,15,0,0,88,89,5,4,0,0,89,96,5,5,0,0,90,91,
  	5,15,0,0,91,92,5,4,0,0,92,93,3,12,6,0,93,94,5,5,0,0,94,96,1,0,0,0,95,
  	87,1,0,0,0,95,90,1,0,0,0,96,15,1,0,0,0,97,98,5,15,0,0,98,99,5,4,0,0,99,
  	100,5,5,0,0,100,17,1,0,0,0,101,102,5,15,0,0,102,103,5,4,0,0,103,104,3,
  	12,6,0,104,105,5,5,0,0,105,19,1,0,0,0,106,109,3,18,9,0,107,109,3,16,8,
  	0,108,106,1,0,0,0,108,107,1,0,0,0,109,21,1,0,0,0,110,111,5,8,0,0,111,
  	116,3,20,10,0,112,113,5,3,0,0,113,115,3,20,10,0,114,112,1,0,0,0,115,118,
  	1,0,0,0,116,114,1,0,0,0,116,117,1,0,0,0,117,119,1,0,0,0,118,116,1,0,0,
  	0,119,120,5,9,0,0,120,124,1,0,0,0,121,122,5,8,0,0,122,124,5,9,0,0,123,
  	110,1,0,0,0,123,121,1,0,0,0,124,23,1,0,0,0,12,30,33,43,51,54,68,71,84,
  	95,108,116,123
  };
  staticData->serializedATN = antlr4::atn::SerializedATNView(serializedATNSegment, sizeof(serializedATNSegment) / sizeof(serializedATNSegment[0]));

  antlr4::atn::ATNDeserializer deserializer;
  staticData->atn = deserializer.deserialize(staticData->serializedATN);

  const size_t count = staticData->atn->getNumberOfDecisions();
  staticData->decisionToDFA.reserve(count);
  for (size_t i = 0; i < count; i++) { 
    staticData->decisionToDFA.emplace_back(staticData->atn->getDecisionState(i), i);
  }
  antlrpythonparserParserStaticData = std::move(staticData);
}

}

AntlrPythonParser::AntlrPythonParser(TokenStream *input) : AntlrPythonParser(input, antlr4::atn::ParserATNSimulatorOptions()) {}

AntlrPythonParser::AntlrPythonParser(TokenStream *input, const antlr4::atn::ParserATNSimulatorOptions &options) : Parser(input) {
  AntlrPythonParser::initialize();
  _interpreter = new atn::ParserATNSimulator(this, *antlrpythonparserParserStaticData->atn, antlrpythonparserParserStaticData->decisionToDFA, antlrpythonparserParserStaticData->sharedContextCache, options);
}

AntlrPythonParser::~AntlrPythonParser() {
  delete _interpreter;
}

const atn::ATN& AntlrPythonParser::getATN() const {
  return *antlrpythonparserParserStaticData->atn;
}

std::string AntlrPythonParser::getGrammarFileName() const {
  return "AntlrPythonParser.g4";
}

const std::vector<std::string>& AntlrPythonParser::getRuleNames() const {
  return antlrpythonparserParserStaticData->ruleNames;
}

const dfa::Vocabulary& AntlrPythonParser::getVocabulary() const {
  return antlrpythonparserParserStaticData->vocabulary;
}

antlr4::atn::SerializedATNView AntlrPythonParser::getSerializedATN() const {
  return antlrpythonparserParserStaticData->serializedATN;
}


//----------------- MainContext ------------------------------------------------------------------

AntlrPythonParser::MainContext::MainContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

AntlrPythonParser::ExprContext* AntlrPythonParser::MainContext::expr() {
  return getRuleContext<AntlrPythonParser::ExprContext>(0);
}

tree::TerminalNode* AntlrPythonParser::MainContext::EOF() {
  return getToken(AntlrPythonParser::EOF, 0);
}


size_t AntlrPythonParser::MainContext::getRuleIndex() const {
  return AntlrPythonParser::RuleMain;
}

void AntlrPythonParser::MainContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterMain(this);
}

void AntlrPythonParser::MainContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitMain(this);
}

AntlrPythonParser::MainContext* AntlrPythonParser::main() {
  MainContext *_localctx = _tracker.createInstance<MainContext>(_ctx, getState());
  enterRule(_localctx, 0, AntlrPythonParser::RuleMain);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(24);
    expr();
    setState(25);
    match(AntlrPythonParser::EOF);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ExprContext ------------------------------------------------------------------

AntlrPythonParser::ExprContext::ExprContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<AntlrPythonParser::FunctionCallContext *> AntlrPythonParser::ExprContext::functionCall() {
  return getRuleContexts<AntlrPythonParser::FunctionCallContext>();
}

AntlrPythonParser::FunctionCallContext* AntlrPythonParser::ExprContext::functionCall(size_t i) {
  return getRuleContext<AntlrPythonParser::FunctionCallContext>(i);
}

AntlrPythonParser::FunctionCallListContext* AntlrPythonParser::ExprContext::functionCallList() {
  return getRuleContext<AntlrPythonParser::FunctionCallListContext>(0);
}


size_t AntlrPythonParser::ExprContext::getRuleIndex() const {
  return AntlrPythonParser::RuleExpr;
}

void AntlrPythonParser::ExprContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterExpr(this);
}

void AntlrPythonParser::ExprContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitExpr(this);
}

AntlrPythonParser::ExprContext* AntlrPythonParser::expr() {
  ExprContext *_localctx = _tracker.createInstance<ExprContext>(_ctx, getState());
  enterRule(_localctx, 2, AntlrPythonParser::RuleExpr);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(33);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case AntlrPythonParser::NAME: {
        enterOuterAlt(_localctx, 1);
        setState(28); 
        _errHandler->sync(this);
        _la = _input->LA(1);
        do {
          setState(27);
          functionCall();
          setState(30); 
          _errHandler->sync(this);
          _la = _input->LA(1);
        } while (_la == AntlrPythonParser::NAME);
        break;
      }

      case AntlrPythonParser::LIST_OPEN: {
        enterOuterAlt(_localctx, 2);
        setState(32);
        functionCallList();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ValueContext ------------------------------------------------------------------

AntlrPythonParser::ValueContext::ValueContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrPythonParser::ValueContext::INT() {
  return getToken(AntlrPythonParser::INT, 0);
}

tree::TerminalNode* AntlrPythonParser::ValueContext::FLOAT() {
  return getToken(AntlrPythonParser::FLOAT, 0);
}

tree::TerminalNode* AntlrPythonParser::ValueContext::BOOL() {
  return getToken(AntlrPythonParser::BOOL, 0);
}

tree::TerminalNode* AntlrPythonParser::ValueContext::STRING() {
  return getToken(AntlrPythonParser::STRING, 0);
}

tree::TerminalNode* AntlrPythonParser::ValueContext::NONE() {
  return getToken(AntlrPythonParser::NONE, 0);
}

AntlrPythonParser::ListContext* AntlrPythonParser::ValueContext::list() {
  return getRuleContext<AntlrPythonParser::ListContext>(0);
}

AntlrPythonParser::DictContext* AntlrPythonParser::ValueContext::dict() {
  return getRuleContext<AntlrPythonParser::DictContext>(0);
}

AntlrPythonParser::ObjectContext* AntlrPythonParser::ValueContext::object() {
  return getRuleContext<AntlrPythonParser::ObjectContext>(0);
}


size_t AntlrPythonParser::ValueContext::getRuleIndex() const {
  return AntlrPythonParser::RuleValue;
}

void AntlrPythonParser::ValueContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterValue(this);
}

void AntlrPythonParser::ValueContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitValue(this);
}

AntlrPythonParser::ValueContext* AntlrPythonParser::value() {
  ValueContext *_localctx = _tracker.createInstance<ValueContext>(_ctx, getState());
  enterRule(_localctx, 4, AntlrPythonParser::RuleValue);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(43);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case AntlrPythonParser::INT: {
        enterOuterAlt(_localctx, 1);
        setState(35);
        match(AntlrPythonParser::INT);
        break;
      }

      case AntlrPythonParser::FLOAT: {
        enterOuterAlt(_localctx, 2);
        setState(36);
        match(AntlrPythonParser::FLOAT);
        break;
      }

      case AntlrPythonParser::BOOL: {
        enterOuterAlt(_localctx, 3);
        setState(37);
        match(AntlrPythonParser::BOOL);
        break;
      }

      case AntlrPythonParser::STRING: {
        enterOuterAlt(_localctx, 4);
        setState(38);
        match(AntlrPythonParser::STRING);
        break;
      }

      case AntlrPythonParser::NONE: {
        enterOuterAlt(_localctx, 5);
        setState(39);
        match(AntlrPythonParser::NONE);
        break;
      }

      case AntlrPythonParser::LIST_OPEN: {
        enterOuterAlt(_localctx, 6);
        setState(40);
        list();
        break;
      }

      case AntlrPythonParser::OPEN_BRACE: {
        enterOuterAlt(_localctx, 7);
        setState(41);
        dict();
        break;
      }

      case AntlrPythonParser::NAME: {
        enterOuterAlt(_localctx, 8);
        setState(42);
        object();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ListContext ------------------------------------------------------------------

AntlrPythonParser::ListContext::ListContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrPythonParser::ListContext::LIST_OPEN() {
  return getToken(AntlrPythonParser::LIST_OPEN, 0);
}

tree::TerminalNode* AntlrPythonParser::ListContext::LIST_CLOSE() {
  return getToken(AntlrPythonParser::LIST_CLOSE, 0);
}

std::vector<AntlrPythonParser::ValueContext *> AntlrPythonParser::ListContext::value() {
  return getRuleContexts<AntlrPythonParser::ValueContext>();
}

AntlrPythonParser::ValueContext* AntlrPythonParser::ListContext::value(size_t i) {
  return getRuleContext<AntlrPythonParser::ValueContext>(i);
}

std::vector<tree::TerminalNode *> AntlrPythonParser::ListContext::SEP() {
  return getTokens(AntlrPythonParser::SEP);
}

tree::TerminalNode* AntlrPythonParser::ListContext::SEP(size_t i) {
  return getToken(AntlrPythonParser::SEP, i);
}


size_t AntlrPythonParser::ListContext::getRuleIndex() const {
  return AntlrPythonParser::RuleList;
}

void AntlrPythonParser::ListContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterList(this);
}

void AntlrPythonParser::ListContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitList(this);
}

AntlrPythonParser::ListContext* AntlrPythonParser::list() {
  ListContext *_localctx = _tracker.createInstance<ListContext>(_ctx, getState());
  enterRule(_localctx, 6, AntlrPythonParser::RuleList);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(45);
    match(AntlrPythonParser::LIST_OPEN);
    setState(54);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & 64832) != 0)) {
      setState(46);
      value();
      setState(51);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == AntlrPythonParser::SEP) {
        setState(47);
        match(AntlrPythonParser::SEP);
        setState(48);
        value();
        setState(53);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
    }
    setState(56);
    match(AntlrPythonParser::LIST_CLOSE);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- DictContext ------------------------------------------------------------------

AntlrPythonParser::DictContext::DictContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrPythonParser::DictContext::OPEN_BRACE() {
  return getToken(AntlrPythonParser::OPEN_BRACE, 0);
}

tree::TerminalNode* AntlrPythonParser::DictContext::CLOSE_BRACE() {
  return getToken(AntlrPythonParser::CLOSE_BRACE, 0);
}

std::vector<tree::TerminalNode *> AntlrPythonParser::DictContext::STRING() {
  return getTokens(AntlrPythonParser::STRING);
}

tree::TerminalNode* AntlrPythonParser::DictContext::STRING(size_t i) {
  return getToken(AntlrPythonParser::STRING, i);
}

std::vector<tree::TerminalNode *> AntlrPythonParser::DictContext::COLON() {
  return getTokens(AntlrPythonParser::COLON);
}

tree::TerminalNode* AntlrPythonParser::DictContext::COLON(size_t i) {
  return getToken(AntlrPythonParser::COLON, i);
}

std::vector<AntlrPythonParser::ValueContext *> AntlrPythonParser::DictContext::value() {
  return getRuleContexts<AntlrPythonParser::ValueContext>();
}

AntlrPythonParser::ValueContext* AntlrPythonParser::DictContext::value(size_t i) {
  return getRuleContext<AntlrPythonParser::ValueContext>(i);
}

std::vector<tree::TerminalNode *> AntlrPythonParser::DictContext::SEP() {
  return getTokens(AntlrPythonParser::SEP);
}

tree::TerminalNode* AntlrPythonParser::DictContext::SEP(size_t i) {
  return getToken(AntlrPythonParser::SEP, i);
}


size_t AntlrPythonParser::DictContext::getRuleIndex() const {
  return AntlrPythonParser::RuleDict;
}

void AntlrPythonParser::DictContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterDict(this);
}

void AntlrPythonParser::DictContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitDict(this);
}

AntlrPythonParser::DictContext* AntlrPythonParser::dict() {
  DictContext *_localctx = _tracker.createInstance<DictContext>(_ctx, getState());
  enterRule(_localctx, 8, AntlrPythonParser::RuleDict);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(58);
    match(AntlrPythonParser::OPEN_BRACE);
    setState(71);
    _errHandler->sync(this);

    _la = _input->LA(1);
    if (_la == AntlrPythonParser::STRING) {
      setState(59);
      match(AntlrPythonParser::STRING);
      setState(60);
      match(AntlrPythonParser::COLON);
      setState(61);
      value();
      setState(68);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == AntlrPythonParser::SEP) {
        setState(62);
        match(AntlrPythonParser::SEP);
        setState(63);
        match(AntlrPythonParser::STRING);
        setState(64);
        match(AntlrPythonParser::COLON);
        setState(65);
        value();
        setState(70);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
    }
    setState(73);
    match(AntlrPythonParser::CLOSE_BRACE);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ArgValContext ------------------------------------------------------------------

AntlrPythonParser::ArgValContext::ArgValContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrPythonParser::ArgValContext::NAME() {
  return getToken(AntlrPythonParser::NAME, 0);
}

tree::TerminalNode* AntlrPythonParser::ArgValContext::EQ() {
  return getToken(AntlrPythonParser::EQ, 0);
}

AntlrPythonParser::ValueContext* AntlrPythonParser::ArgValContext::value() {
  return getRuleContext<AntlrPythonParser::ValueContext>(0);
}


size_t AntlrPythonParser::ArgValContext::getRuleIndex() const {
  return AntlrPythonParser::RuleArgVal;
}

void AntlrPythonParser::ArgValContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterArgVal(this);
}

void AntlrPythonParser::ArgValContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitArgVal(this);
}

AntlrPythonParser::ArgValContext* AntlrPythonParser::argVal() {
  ArgValContext *_localctx = _tracker.createInstance<ArgValContext>(_ctx, getState());
  enterRule(_localctx, 10, AntlrPythonParser::RuleArgVal);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(75);
    match(AntlrPythonParser::NAME);
    setState(76);
    match(AntlrPythonParser::EQ);
    setState(77);
    value();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ArgValExprContext ------------------------------------------------------------------

AntlrPythonParser::ArgValExprContext::ArgValExprContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<AntlrPythonParser::ArgValContext *> AntlrPythonParser::ArgValExprContext::argVal() {
  return getRuleContexts<AntlrPythonParser::ArgValContext>();
}

AntlrPythonParser::ArgValContext* AntlrPythonParser::ArgValExprContext::argVal(size_t i) {
  return getRuleContext<AntlrPythonParser::ArgValContext>(i);
}

std::vector<tree::TerminalNode *> AntlrPythonParser::ArgValExprContext::SEP() {
  return getTokens(AntlrPythonParser::SEP);
}

tree::TerminalNode* AntlrPythonParser::ArgValExprContext::SEP(size_t i) {
  return getToken(AntlrPythonParser::SEP, i);
}


size_t AntlrPythonParser::ArgValExprContext::getRuleIndex() const {
  return AntlrPythonParser::RuleArgValExpr;
}

void AntlrPythonParser::ArgValExprContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterArgValExpr(this);
}

void AntlrPythonParser::ArgValExprContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitArgValExpr(this);
}

AntlrPythonParser::ArgValExprContext* AntlrPythonParser::argValExpr() {
  ArgValExprContext *_localctx = _tracker.createInstance<ArgValExprContext>(_ctx, getState());
  enterRule(_localctx, 12, AntlrPythonParser::RuleArgValExpr);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(79);
    argVal();
    setState(84);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == AntlrPythonParser::SEP) {
      setState(80);
      match(AntlrPythonParser::SEP);
      setState(81);
      argVal();
      setState(86);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ObjectContext ------------------------------------------------------------------

AntlrPythonParser::ObjectContext::ObjectContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrPythonParser::ObjectContext::NAME() {
  return getToken(AntlrPythonParser::NAME, 0);
}

tree::TerminalNode* AntlrPythonParser::ObjectContext::OPEN_PAR() {
  return getToken(AntlrPythonParser::OPEN_PAR, 0);
}

tree::TerminalNode* AntlrPythonParser::ObjectContext::CLOSE_PAR() {
  return getToken(AntlrPythonParser::CLOSE_PAR, 0);
}

AntlrPythonParser::ArgValExprContext* AntlrPythonParser::ObjectContext::argValExpr() {
  return getRuleContext<AntlrPythonParser::ArgValExprContext>(0);
}


size_t AntlrPythonParser::ObjectContext::getRuleIndex() const {
  return AntlrPythonParser::RuleObject;
}

void AntlrPythonParser::ObjectContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterObject(this);
}

void AntlrPythonParser::ObjectContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitObject(this);
}

AntlrPythonParser::ObjectContext* AntlrPythonParser::object() {
  ObjectContext *_localctx = _tracker.createInstance<ObjectContext>(_ctx, getState());
  enterRule(_localctx, 14, AntlrPythonParser::RuleObject);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(95);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 8, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(87);
      match(AntlrPythonParser::NAME);
      setState(88);
      match(AntlrPythonParser::OPEN_PAR);
      setState(89);
      match(AntlrPythonParser::CLOSE_PAR);
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(90);
      match(AntlrPythonParser::NAME);
      setState(91);
      match(AntlrPythonParser::OPEN_PAR);
      setState(92);
      argValExpr();
      setState(93);
      match(AntlrPythonParser::CLOSE_PAR);
      break;
    }

    default:
      break;
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EmptyFunctionCallContext ------------------------------------------------------------------

AntlrPythonParser::EmptyFunctionCallContext::EmptyFunctionCallContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrPythonParser::EmptyFunctionCallContext::NAME() {
  return getToken(AntlrPythonParser::NAME, 0);
}

tree::TerminalNode* AntlrPythonParser::EmptyFunctionCallContext::OPEN_PAR() {
  return getToken(AntlrPythonParser::OPEN_PAR, 0);
}

tree::TerminalNode* AntlrPythonParser::EmptyFunctionCallContext::CLOSE_PAR() {
  return getToken(AntlrPythonParser::CLOSE_PAR, 0);
}


size_t AntlrPythonParser::EmptyFunctionCallContext::getRuleIndex() const {
  return AntlrPythonParser::RuleEmptyFunctionCall;
}

void AntlrPythonParser::EmptyFunctionCallContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEmptyFunctionCall(this);
}

void AntlrPythonParser::EmptyFunctionCallContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEmptyFunctionCall(this);
}

AntlrPythonParser::EmptyFunctionCallContext* AntlrPythonParser::emptyFunctionCall() {
  EmptyFunctionCallContext *_localctx = _tracker.createInstance<EmptyFunctionCallContext>(_ctx, getState());
  enterRule(_localctx, 16, AntlrPythonParser::RuleEmptyFunctionCall);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(97);
    match(AntlrPythonParser::NAME);
    setState(98);
    match(AntlrPythonParser::OPEN_PAR);
    setState(99);
    match(AntlrPythonParser::CLOSE_PAR);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FullFunctionCallContext ------------------------------------------------------------------

AntlrPythonParser::FullFunctionCallContext::FullFunctionCallContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrPythonParser::FullFunctionCallContext::NAME() {
  return getToken(AntlrPythonParser::NAME, 0);
}

tree::TerminalNode* AntlrPythonParser::FullFunctionCallContext::OPEN_PAR() {
  return getToken(AntlrPythonParser::OPEN_PAR, 0);
}

AntlrPythonParser::ArgValExprContext* AntlrPythonParser::FullFunctionCallContext::argValExpr() {
  return getRuleContext<AntlrPythonParser::ArgValExprContext>(0);
}

tree::TerminalNode* AntlrPythonParser::FullFunctionCallContext::CLOSE_PAR() {
  return getToken(AntlrPythonParser::CLOSE_PAR, 0);
}


size_t AntlrPythonParser::FullFunctionCallContext::getRuleIndex() const {
  return AntlrPythonParser::RuleFullFunctionCall;
}

void AntlrPythonParser::FullFunctionCallContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFullFunctionCall(this);
}

void AntlrPythonParser::FullFunctionCallContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFullFunctionCall(this);
}

AntlrPythonParser::FullFunctionCallContext* AntlrPythonParser::fullFunctionCall() {
  FullFunctionCallContext *_localctx = _tracker.createInstance<FullFunctionCallContext>(_ctx, getState());
  enterRule(_localctx, 18, AntlrPythonParser::RuleFullFunctionCall);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(101);
    match(AntlrPythonParser::NAME);
    setState(102);
    match(AntlrPythonParser::OPEN_PAR);
    setState(103);
    argValExpr();
    setState(104);
    match(AntlrPythonParser::CLOSE_PAR);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FunctionCallContext ------------------------------------------------------------------

AntlrPythonParser::FunctionCallContext::FunctionCallContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

AntlrPythonParser::FullFunctionCallContext* AntlrPythonParser::FunctionCallContext::fullFunctionCall() {
  return getRuleContext<AntlrPythonParser::FullFunctionCallContext>(0);
}

AntlrPythonParser::EmptyFunctionCallContext* AntlrPythonParser::FunctionCallContext::emptyFunctionCall() {
  return getRuleContext<AntlrPythonParser::EmptyFunctionCallContext>(0);
}


size_t AntlrPythonParser::FunctionCallContext::getRuleIndex() const {
  return AntlrPythonParser::RuleFunctionCall;
}

void AntlrPythonParser::FunctionCallContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionCall(this);
}

void AntlrPythonParser::FunctionCallContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionCall(this);
}

AntlrPythonParser::FunctionCallContext* AntlrPythonParser::functionCall() {
  FunctionCallContext *_localctx = _tracker.createInstance<FunctionCallContext>(_ctx, getState());
  enterRule(_localctx, 20, AntlrPythonParser::RuleFunctionCall);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(108);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 9, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(106);
      fullFunctionCall();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(107);
      emptyFunctionCall();
      break;
    }

    default:
      break;
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FunctionCallListContext ------------------------------------------------------------------

AntlrPythonParser::FunctionCallListContext::FunctionCallListContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrPythonParser::FunctionCallListContext::LIST_OPEN() {
  return getToken(AntlrPythonParser::LIST_OPEN, 0);
}

std::vector<AntlrPythonParser::FunctionCallContext *> AntlrPythonParser::FunctionCallListContext::functionCall() {
  return getRuleContexts<AntlrPythonParser::FunctionCallContext>();
}

AntlrPythonParser::FunctionCallContext* AntlrPythonParser::FunctionCallListContext::functionCall(size_t i) {
  return getRuleContext<AntlrPythonParser::FunctionCallContext>(i);
}

tree::TerminalNode* AntlrPythonParser::FunctionCallListContext::LIST_CLOSE() {
  return getToken(AntlrPythonParser::LIST_CLOSE, 0);
}

std::vector<tree::TerminalNode *> AntlrPythonParser::FunctionCallListContext::SEP() {
  return getTokens(AntlrPythonParser::SEP);
}

tree::TerminalNode* AntlrPythonParser::FunctionCallListContext::SEP(size_t i) {
  return getToken(AntlrPythonParser::SEP, i);
}


size_t AntlrPythonParser::FunctionCallListContext::getRuleIndex() const {
  return AntlrPythonParser::RuleFunctionCallList;
}

void AntlrPythonParser::FunctionCallListContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionCallList(this);
}

void AntlrPythonParser::FunctionCallListContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrPythonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionCallList(this);
}

AntlrPythonParser::FunctionCallListContext* AntlrPythonParser::functionCallList() {
  FunctionCallListContext *_localctx = _tracker.createInstance<FunctionCallListContext>(_ctx, getState());
  enterRule(_localctx, 22, AntlrPythonParser::RuleFunctionCallList);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(123);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 11, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(110);
      match(AntlrPythonParser::LIST_OPEN);
      setState(111);
      functionCall();
      setState(116);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == AntlrPythonParser::SEP) {
        setState(112);
        match(AntlrPythonParser::SEP);
        setState(113);
        functionCall();
        setState(118);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
      setState(119);
      match(AntlrPythonParser::LIST_CLOSE);
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(121);
      match(AntlrPythonParser::LIST_OPEN);
      setState(122);
      match(AntlrPythonParser::LIST_CLOSE);
      break;
    }

    default:
      break;
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

void AntlrPythonParser::initialize() {
#if ANTLR4_USE_THREAD_LOCAL_CACHE
  antlrpythonparserParserInitialize();
#else
  ::antlr4::internal::call_once(antlrpythonparserParserOnceFlag, antlrpythonparserParserInitialize);
#endif
}
