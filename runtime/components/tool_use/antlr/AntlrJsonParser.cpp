
// Generated from AntlrJsonParser.g4 by ANTLR 4.13.2


#include "AntlrJsonParserListener.h"

#include "AntlrJsonParser.h"


using namespace antlrcpp;
using namespace antlr_json_tool_call_parser;

using namespace antlr4;

namespace {

struct AntlrJsonParserStaticData final {
  AntlrJsonParserStaticData(std::vector<std::string> ruleNames,
                        std::vector<std::string> literalNames,
                        std::vector<std::string> symbolicNames)
      : ruleNames(std::move(ruleNames)), literalNames(std::move(literalNames)),
        symbolicNames(std::move(symbolicNames)),
        vocabulary(this->literalNames, this->symbolicNames) {}

  AntlrJsonParserStaticData(const AntlrJsonParserStaticData&) = delete;
  AntlrJsonParserStaticData(AntlrJsonParserStaticData&&) = delete;
  AntlrJsonParserStaticData& operator=(const AntlrJsonParserStaticData&) = delete;
  AntlrJsonParserStaticData& operator=(AntlrJsonParserStaticData&&) = delete;

  std::vector<antlr4::dfa::DFA> decisionToDFA;
  antlr4::atn::PredictionContextCache sharedContextCache;
  const std::vector<std::string> ruleNames;
  const std::vector<std::string> literalNames;
  const std::vector<std::string> symbolicNames;
  const antlr4::dfa::Vocabulary vocabulary;
  antlr4::atn::SerializedATNView serializedATN;
  std::unique_ptr<antlr4::atn::ATN> atn;
};

::antlr4::internal::OnceFlag antlrjsonparserParserOnceFlag;
#if ANTLR4_USE_THREAD_LOCAL_CACHE
static thread_local
#endif
std::unique_ptr<AntlrJsonParserStaticData> antlrjsonparserParserStaticData = nullptr;

void antlrjsonparserParserInitialize() {
#if ANTLR4_USE_THREAD_LOCAL_CACHE
  if (antlrjsonparserParserStaticData != nullptr) {
    return;
  }
#else
  assert(antlrjsonparserParserStaticData == nullptr);
#endif
  auto staticData = std::make_unique<AntlrJsonParserStaticData>(
    std::vector<std::string>{
      "json", "value", "object", "pair", "array", "functionNamePair", "functionArgsPair", 
      "emptyFunctionCall", "fullFunctionCall", "functionCall", "functionCallList"
    },
    std::vector<std::string>{
      "", "'{'", "'}'", "'['", "']'", "','", "':'", "", "'null'"
    },
    std::vector<std::string>{
      "", "OPEN_BRACE", "CLOSE_BRACE", "OPEN_BRACKET", "CLOSE_BRACKET", 
      "COMMA", "COLON", "BOOLEAN", "NONE", "FUNCTION_NAME", "FUNCTION_ARGUMENTS", 
      "STRING", "NUMBER", "WS"
    }
  );
  static const int32_t serializedATNSegment[] = {
  	4,1,13,105,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,2,
  	7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,1,0,1,0,3,0,25,8,0,1,1,1,1,1,1,1,1,1,
  	1,1,1,3,1,33,8,1,1,2,1,2,1,2,1,2,5,2,39,8,2,10,2,12,2,42,9,2,1,2,1,2,
  	1,2,1,2,3,2,48,8,2,1,3,1,3,1,3,1,3,1,4,1,4,1,4,1,4,5,4,58,8,4,10,4,12,
  	4,61,9,4,1,4,1,4,1,4,1,4,3,4,67,8,4,1,5,1,5,1,5,1,5,1,6,1,6,1,6,1,6,1,
  	7,1,7,1,7,1,8,1,8,1,8,1,8,1,8,1,8,1,9,1,9,3,9,88,8,9,1,10,1,10,1,10,1,
  	10,5,10,94,8,10,10,10,12,10,97,9,10,1,10,1,10,1,10,1,10,3,10,103,8,10,
  	1,10,0,0,11,0,2,4,6,8,10,12,14,16,18,20,0,0,106,0,24,1,0,0,0,2,32,1,0,
  	0,0,4,47,1,0,0,0,6,49,1,0,0,0,8,66,1,0,0,0,10,68,1,0,0,0,12,72,1,0,0,
  	0,14,76,1,0,0,0,16,79,1,0,0,0,18,87,1,0,0,0,20,102,1,0,0,0,22,25,3,18,
  	9,0,23,25,3,20,10,0,24,22,1,0,0,0,24,23,1,0,0,0,25,1,1,0,0,0,26,33,5,
  	11,0,0,27,33,5,12,0,0,28,33,3,4,2,0,29,33,3,8,4,0,30,33,5,7,0,0,31,33,
  	5,8,0,0,32,26,1,0,0,0,32,27,1,0,0,0,32,28,1,0,0,0,32,29,1,0,0,0,32,30,
  	1,0,0,0,32,31,1,0,0,0,33,3,1,0,0,0,34,35,5,1,0,0,35,40,3,6,3,0,36,37,
  	5,5,0,0,37,39,3,6,3,0,38,36,1,0,0,0,39,42,1,0,0,0,40,38,1,0,0,0,40,41,
  	1,0,0,0,41,43,1,0,0,0,42,40,1,0,0,0,43,44,5,2,0,0,44,48,1,0,0,0,45,46,
  	5,1,0,0,46,48,5,2,0,0,47,34,1,0,0,0,47,45,1,0,0,0,48,5,1,0,0,0,49,50,
  	5,11,0,0,50,51,5,6,0,0,51,52,3,2,1,0,52,7,1,0,0,0,53,54,5,3,0,0,54,59,
  	3,2,1,0,55,56,5,5,0,0,56,58,3,2,1,0,57,55,1,0,0,0,58,61,1,0,0,0,59,57,
  	1,0,0,0,59,60,1,0,0,0,60,62,1,0,0,0,61,59,1,0,0,0,62,63,5,4,0,0,63,67,
  	1,0,0,0,64,65,5,3,0,0,65,67,5,4,0,0,66,53,1,0,0,0,66,64,1,0,0,0,67,9,
  	1,0,0,0,68,69,5,9,0,0,69,70,5,6,0,0,70,71,5,11,0,0,71,11,1,0,0,0,72,73,
  	5,10,0,0,73,74,5,6,0,0,74,75,3,4,2,0,75,13,1,0,0,0,76,77,5,1,0,0,77,78,
  	5,2,0,0,78,15,1,0,0,0,79,80,5,1,0,0,80,81,3,10,5,0,81,82,5,5,0,0,82,83,
  	3,12,6,0,83,84,5,2,0,0,84,17,1,0,0,0,85,88,3,16,8,0,86,88,3,14,7,0,87,
  	85,1,0,0,0,87,86,1,0,0,0,88,19,1,0,0,0,89,90,5,3,0,0,90,95,3,18,9,0,91,
  	92,5,5,0,0,92,94,3,18,9,0,93,91,1,0,0,0,94,97,1,0,0,0,95,93,1,0,0,0,95,
  	96,1,0,0,0,96,98,1,0,0,0,97,95,1,0,0,0,98,99,5,4,0,0,99,103,1,0,0,0,100,
  	101,5,3,0,0,101,103,5,4,0,0,102,89,1,0,0,0,102,100,1,0,0,0,103,21,1,0,
  	0,0,9,24,32,40,47,59,66,87,95,102
  };
  staticData->serializedATN = antlr4::atn::SerializedATNView(serializedATNSegment, sizeof(serializedATNSegment) / sizeof(serializedATNSegment[0]));

  antlr4::atn::ATNDeserializer deserializer;
  staticData->atn = deserializer.deserialize(staticData->serializedATN);

  const size_t count = staticData->atn->getNumberOfDecisions();
  staticData->decisionToDFA.reserve(count);
  for (size_t i = 0; i < count; i++) { 
    staticData->decisionToDFA.emplace_back(staticData->atn->getDecisionState(i), i);
  }
  antlrjsonparserParserStaticData = std::move(staticData);
}

}

AntlrJsonParser::AntlrJsonParser(TokenStream *input) : AntlrJsonParser(input, antlr4::atn::ParserATNSimulatorOptions()) {}

AntlrJsonParser::AntlrJsonParser(TokenStream *input, const antlr4::atn::ParserATNSimulatorOptions &options) : Parser(input) {
  AntlrJsonParser::initialize();
  _interpreter = new atn::ParserATNSimulator(this, *antlrjsonparserParserStaticData->atn, antlrjsonparserParserStaticData->decisionToDFA, antlrjsonparserParserStaticData->sharedContextCache, options);
}

AntlrJsonParser::~AntlrJsonParser() {
  delete _interpreter;
}

const atn::ATN& AntlrJsonParser::getATN() const {
  return *antlrjsonparserParserStaticData->atn;
}

std::string AntlrJsonParser::getGrammarFileName() const {
  return "AntlrJsonParser.g4";
}

const std::vector<std::string>& AntlrJsonParser::getRuleNames() const {
  return antlrjsonparserParserStaticData->ruleNames;
}

const dfa::Vocabulary& AntlrJsonParser::getVocabulary() const {
  return antlrjsonparserParserStaticData->vocabulary;
}

antlr4::atn::SerializedATNView AntlrJsonParser::getSerializedATN() const {
  return antlrjsonparserParserStaticData->serializedATN;
}


//----------------- JsonContext ------------------------------------------------------------------

AntlrJsonParser::JsonContext::JsonContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

AntlrJsonParser::FunctionCallContext* AntlrJsonParser::JsonContext::functionCall() {
  return getRuleContext<AntlrJsonParser::FunctionCallContext>(0);
}

AntlrJsonParser::FunctionCallListContext* AntlrJsonParser::JsonContext::functionCallList() {
  return getRuleContext<AntlrJsonParser::FunctionCallListContext>(0);
}


size_t AntlrJsonParser::JsonContext::getRuleIndex() const {
  return AntlrJsonParser::RuleJson;
}

void AntlrJsonParser::JsonContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterJson(this);
}

void AntlrJsonParser::JsonContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitJson(this);
}

AntlrJsonParser::JsonContext* AntlrJsonParser::json() {
  JsonContext *_localctx = _tracker.createInstance<JsonContext>(_ctx, getState());
  enterRule(_localctx, 0, AntlrJsonParser::RuleJson);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(24);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case AntlrJsonParser::OPEN_BRACE: {
        enterOuterAlt(_localctx, 1);
        setState(22);
        functionCall();
        break;
      }

      case AntlrJsonParser::OPEN_BRACKET: {
        enterOuterAlt(_localctx, 2);
        setState(23);
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

AntlrJsonParser::ValueContext::ValueContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrJsonParser::ValueContext::STRING() {
  return getToken(AntlrJsonParser::STRING, 0);
}

tree::TerminalNode* AntlrJsonParser::ValueContext::NUMBER() {
  return getToken(AntlrJsonParser::NUMBER, 0);
}

AntlrJsonParser::ObjectContext* AntlrJsonParser::ValueContext::object() {
  return getRuleContext<AntlrJsonParser::ObjectContext>(0);
}

AntlrJsonParser::ArrayContext* AntlrJsonParser::ValueContext::array() {
  return getRuleContext<AntlrJsonParser::ArrayContext>(0);
}

tree::TerminalNode* AntlrJsonParser::ValueContext::BOOLEAN() {
  return getToken(AntlrJsonParser::BOOLEAN, 0);
}

tree::TerminalNode* AntlrJsonParser::ValueContext::NONE() {
  return getToken(AntlrJsonParser::NONE, 0);
}


size_t AntlrJsonParser::ValueContext::getRuleIndex() const {
  return AntlrJsonParser::RuleValue;
}

void AntlrJsonParser::ValueContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterValue(this);
}

void AntlrJsonParser::ValueContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitValue(this);
}

AntlrJsonParser::ValueContext* AntlrJsonParser::value() {
  ValueContext *_localctx = _tracker.createInstance<ValueContext>(_ctx, getState());
  enterRule(_localctx, 2, AntlrJsonParser::RuleValue);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(32);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case AntlrJsonParser::STRING: {
        enterOuterAlt(_localctx, 1);
        setState(26);
        match(AntlrJsonParser::STRING);
        break;
      }

      case AntlrJsonParser::NUMBER: {
        enterOuterAlt(_localctx, 2);
        setState(27);
        match(AntlrJsonParser::NUMBER);
        break;
      }

      case AntlrJsonParser::OPEN_BRACE: {
        enterOuterAlt(_localctx, 3);
        setState(28);
        object();
        break;
      }

      case AntlrJsonParser::OPEN_BRACKET: {
        enterOuterAlt(_localctx, 4);
        setState(29);
        array();
        break;
      }

      case AntlrJsonParser::BOOLEAN: {
        enterOuterAlt(_localctx, 5);
        setState(30);
        match(AntlrJsonParser::BOOLEAN);
        break;
      }

      case AntlrJsonParser::NONE: {
        enterOuterAlt(_localctx, 6);
        setState(31);
        match(AntlrJsonParser::NONE);
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

//----------------- ObjectContext ------------------------------------------------------------------

AntlrJsonParser::ObjectContext::ObjectContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrJsonParser::ObjectContext::OPEN_BRACE() {
  return getToken(AntlrJsonParser::OPEN_BRACE, 0);
}

std::vector<AntlrJsonParser::PairContext *> AntlrJsonParser::ObjectContext::pair() {
  return getRuleContexts<AntlrJsonParser::PairContext>();
}

AntlrJsonParser::PairContext* AntlrJsonParser::ObjectContext::pair(size_t i) {
  return getRuleContext<AntlrJsonParser::PairContext>(i);
}

tree::TerminalNode* AntlrJsonParser::ObjectContext::CLOSE_BRACE() {
  return getToken(AntlrJsonParser::CLOSE_BRACE, 0);
}

std::vector<tree::TerminalNode *> AntlrJsonParser::ObjectContext::COMMA() {
  return getTokens(AntlrJsonParser::COMMA);
}

tree::TerminalNode* AntlrJsonParser::ObjectContext::COMMA(size_t i) {
  return getToken(AntlrJsonParser::COMMA, i);
}


size_t AntlrJsonParser::ObjectContext::getRuleIndex() const {
  return AntlrJsonParser::RuleObject;
}

void AntlrJsonParser::ObjectContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterObject(this);
}

void AntlrJsonParser::ObjectContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitObject(this);
}

AntlrJsonParser::ObjectContext* AntlrJsonParser::object() {
  ObjectContext *_localctx = _tracker.createInstance<ObjectContext>(_ctx, getState());
  enterRule(_localctx, 4, AntlrJsonParser::RuleObject);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(47);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 3, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(34);
      match(AntlrJsonParser::OPEN_BRACE);
      setState(35);
      pair();
      setState(40);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == AntlrJsonParser::COMMA) {
        setState(36);
        match(AntlrJsonParser::COMMA);
        setState(37);
        pair();
        setState(42);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
      setState(43);
      match(AntlrJsonParser::CLOSE_BRACE);
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(45);
      match(AntlrJsonParser::OPEN_BRACE);
      setState(46);
      match(AntlrJsonParser::CLOSE_BRACE);
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

//----------------- PairContext ------------------------------------------------------------------

AntlrJsonParser::PairContext::PairContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrJsonParser::PairContext::STRING() {
  return getToken(AntlrJsonParser::STRING, 0);
}

tree::TerminalNode* AntlrJsonParser::PairContext::COLON() {
  return getToken(AntlrJsonParser::COLON, 0);
}

AntlrJsonParser::ValueContext* AntlrJsonParser::PairContext::value() {
  return getRuleContext<AntlrJsonParser::ValueContext>(0);
}


size_t AntlrJsonParser::PairContext::getRuleIndex() const {
  return AntlrJsonParser::RulePair;
}

void AntlrJsonParser::PairContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterPair(this);
}

void AntlrJsonParser::PairContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitPair(this);
}

AntlrJsonParser::PairContext* AntlrJsonParser::pair() {
  PairContext *_localctx = _tracker.createInstance<PairContext>(_ctx, getState());
  enterRule(_localctx, 6, AntlrJsonParser::RulePair);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(49);
    match(AntlrJsonParser::STRING);
    setState(50);
    match(AntlrJsonParser::COLON);
    setState(51);
    value();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ArrayContext ------------------------------------------------------------------

AntlrJsonParser::ArrayContext::ArrayContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrJsonParser::ArrayContext::OPEN_BRACKET() {
  return getToken(AntlrJsonParser::OPEN_BRACKET, 0);
}

std::vector<AntlrJsonParser::ValueContext *> AntlrJsonParser::ArrayContext::value() {
  return getRuleContexts<AntlrJsonParser::ValueContext>();
}

AntlrJsonParser::ValueContext* AntlrJsonParser::ArrayContext::value(size_t i) {
  return getRuleContext<AntlrJsonParser::ValueContext>(i);
}

tree::TerminalNode* AntlrJsonParser::ArrayContext::CLOSE_BRACKET() {
  return getToken(AntlrJsonParser::CLOSE_BRACKET, 0);
}

std::vector<tree::TerminalNode *> AntlrJsonParser::ArrayContext::COMMA() {
  return getTokens(AntlrJsonParser::COMMA);
}

tree::TerminalNode* AntlrJsonParser::ArrayContext::COMMA(size_t i) {
  return getToken(AntlrJsonParser::COMMA, i);
}


size_t AntlrJsonParser::ArrayContext::getRuleIndex() const {
  return AntlrJsonParser::RuleArray;
}

void AntlrJsonParser::ArrayContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterArray(this);
}

void AntlrJsonParser::ArrayContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitArray(this);
}

AntlrJsonParser::ArrayContext* AntlrJsonParser::array() {
  ArrayContext *_localctx = _tracker.createInstance<ArrayContext>(_ctx, getState());
  enterRule(_localctx, 8, AntlrJsonParser::RuleArray);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(66);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 5, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(53);
      match(AntlrJsonParser::OPEN_BRACKET);
      setState(54);
      value();
      setState(59);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == AntlrJsonParser::COMMA) {
        setState(55);
        match(AntlrJsonParser::COMMA);
        setState(56);
        value();
        setState(61);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
      setState(62);
      match(AntlrJsonParser::CLOSE_BRACKET);
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(64);
      match(AntlrJsonParser::OPEN_BRACKET);
      setState(65);
      match(AntlrJsonParser::CLOSE_BRACKET);
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

//----------------- FunctionNamePairContext ------------------------------------------------------------------

AntlrJsonParser::FunctionNamePairContext::FunctionNamePairContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrJsonParser::FunctionNamePairContext::FUNCTION_NAME() {
  return getToken(AntlrJsonParser::FUNCTION_NAME, 0);
}

tree::TerminalNode* AntlrJsonParser::FunctionNamePairContext::COLON() {
  return getToken(AntlrJsonParser::COLON, 0);
}

tree::TerminalNode* AntlrJsonParser::FunctionNamePairContext::STRING() {
  return getToken(AntlrJsonParser::STRING, 0);
}


size_t AntlrJsonParser::FunctionNamePairContext::getRuleIndex() const {
  return AntlrJsonParser::RuleFunctionNamePair;
}

void AntlrJsonParser::FunctionNamePairContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionNamePair(this);
}

void AntlrJsonParser::FunctionNamePairContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionNamePair(this);
}

AntlrJsonParser::FunctionNamePairContext* AntlrJsonParser::functionNamePair() {
  FunctionNamePairContext *_localctx = _tracker.createInstance<FunctionNamePairContext>(_ctx, getState());
  enterRule(_localctx, 10, AntlrJsonParser::RuleFunctionNamePair);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(68);
    match(AntlrJsonParser::FUNCTION_NAME);
    setState(69);
    match(AntlrJsonParser::COLON);
    setState(70);
    match(AntlrJsonParser::STRING);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FunctionArgsPairContext ------------------------------------------------------------------

AntlrJsonParser::FunctionArgsPairContext::FunctionArgsPairContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrJsonParser::FunctionArgsPairContext::FUNCTION_ARGUMENTS() {
  return getToken(AntlrJsonParser::FUNCTION_ARGUMENTS, 0);
}

tree::TerminalNode* AntlrJsonParser::FunctionArgsPairContext::COLON() {
  return getToken(AntlrJsonParser::COLON, 0);
}

AntlrJsonParser::ObjectContext* AntlrJsonParser::FunctionArgsPairContext::object() {
  return getRuleContext<AntlrJsonParser::ObjectContext>(0);
}


size_t AntlrJsonParser::FunctionArgsPairContext::getRuleIndex() const {
  return AntlrJsonParser::RuleFunctionArgsPair;
}

void AntlrJsonParser::FunctionArgsPairContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionArgsPair(this);
}

void AntlrJsonParser::FunctionArgsPairContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionArgsPair(this);
}

AntlrJsonParser::FunctionArgsPairContext* AntlrJsonParser::functionArgsPair() {
  FunctionArgsPairContext *_localctx = _tracker.createInstance<FunctionArgsPairContext>(_ctx, getState());
  enterRule(_localctx, 12, AntlrJsonParser::RuleFunctionArgsPair);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(72);
    match(AntlrJsonParser::FUNCTION_ARGUMENTS);
    setState(73);
    match(AntlrJsonParser::COLON);
    setState(74);
    object();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- EmptyFunctionCallContext ------------------------------------------------------------------

AntlrJsonParser::EmptyFunctionCallContext::EmptyFunctionCallContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrJsonParser::EmptyFunctionCallContext::OPEN_BRACE() {
  return getToken(AntlrJsonParser::OPEN_BRACE, 0);
}

tree::TerminalNode* AntlrJsonParser::EmptyFunctionCallContext::CLOSE_BRACE() {
  return getToken(AntlrJsonParser::CLOSE_BRACE, 0);
}


size_t AntlrJsonParser::EmptyFunctionCallContext::getRuleIndex() const {
  return AntlrJsonParser::RuleEmptyFunctionCall;
}

void AntlrJsonParser::EmptyFunctionCallContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterEmptyFunctionCall(this);
}

void AntlrJsonParser::EmptyFunctionCallContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitEmptyFunctionCall(this);
}

AntlrJsonParser::EmptyFunctionCallContext* AntlrJsonParser::emptyFunctionCall() {
  EmptyFunctionCallContext *_localctx = _tracker.createInstance<EmptyFunctionCallContext>(_ctx, getState());
  enterRule(_localctx, 14, AntlrJsonParser::RuleEmptyFunctionCall);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(76);
    match(AntlrJsonParser::OPEN_BRACE);
    setState(77);
    match(AntlrJsonParser::CLOSE_BRACE);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FullFunctionCallContext ------------------------------------------------------------------

AntlrJsonParser::FullFunctionCallContext::FullFunctionCallContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrJsonParser::FullFunctionCallContext::OPEN_BRACE() {
  return getToken(AntlrJsonParser::OPEN_BRACE, 0);
}

AntlrJsonParser::FunctionNamePairContext* AntlrJsonParser::FullFunctionCallContext::functionNamePair() {
  return getRuleContext<AntlrJsonParser::FunctionNamePairContext>(0);
}

tree::TerminalNode* AntlrJsonParser::FullFunctionCallContext::COMMA() {
  return getToken(AntlrJsonParser::COMMA, 0);
}

AntlrJsonParser::FunctionArgsPairContext* AntlrJsonParser::FullFunctionCallContext::functionArgsPair() {
  return getRuleContext<AntlrJsonParser::FunctionArgsPairContext>(0);
}

tree::TerminalNode* AntlrJsonParser::FullFunctionCallContext::CLOSE_BRACE() {
  return getToken(AntlrJsonParser::CLOSE_BRACE, 0);
}


size_t AntlrJsonParser::FullFunctionCallContext::getRuleIndex() const {
  return AntlrJsonParser::RuleFullFunctionCall;
}

void AntlrJsonParser::FullFunctionCallContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFullFunctionCall(this);
}

void AntlrJsonParser::FullFunctionCallContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFullFunctionCall(this);
}

AntlrJsonParser::FullFunctionCallContext* AntlrJsonParser::fullFunctionCall() {
  FullFunctionCallContext *_localctx = _tracker.createInstance<FullFunctionCallContext>(_ctx, getState());
  enterRule(_localctx, 16, AntlrJsonParser::RuleFullFunctionCall);

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
    match(AntlrJsonParser::OPEN_BRACE);
    setState(80);
    functionNamePair();
    setState(81);
    match(AntlrJsonParser::COMMA);
    setState(82);
    functionArgsPair();
    setState(83);
    match(AntlrJsonParser::CLOSE_BRACE);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FunctionCallContext ------------------------------------------------------------------

AntlrJsonParser::FunctionCallContext::FunctionCallContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

AntlrJsonParser::FullFunctionCallContext* AntlrJsonParser::FunctionCallContext::fullFunctionCall() {
  return getRuleContext<AntlrJsonParser::FullFunctionCallContext>(0);
}

AntlrJsonParser::EmptyFunctionCallContext* AntlrJsonParser::FunctionCallContext::emptyFunctionCall() {
  return getRuleContext<AntlrJsonParser::EmptyFunctionCallContext>(0);
}


size_t AntlrJsonParser::FunctionCallContext::getRuleIndex() const {
  return AntlrJsonParser::RuleFunctionCall;
}

void AntlrJsonParser::FunctionCallContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionCall(this);
}

void AntlrJsonParser::FunctionCallContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionCall(this);
}

AntlrJsonParser::FunctionCallContext* AntlrJsonParser::functionCall() {
  FunctionCallContext *_localctx = _tracker.createInstance<FunctionCallContext>(_ctx, getState());
  enterRule(_localctx, 18, AntlrJsonParser::RuleFunctionCall);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(87);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 6, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(85);
      fullFunctionCall();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(86);
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

AntlrJsonParser::FunctionCallListContext::FunctionCallListContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* AntlrJsonParser::FunctionCallListContext::OPEN_BRACKET() {
  return getToken(AntlrJsonParser::OPEN_BRACKET, 0);
}

std::vector<AntlrJsonParser::FunctionCallContext *> AntlrJsonParser::FunctionCallListContext::functionCall() {
  return getRuleContexts<AntlrJsonParser::FunctionCallContext>();
}

AntlrJsonParser::FunctionCallContext* AntlrJsonParser::FunctionCallListContext::functionCall(size_t i) {
  return getRuleContext<AntlrJsonParser::FunctionCallContext>(i);
}

tree::TerminalNode* AntlrJsonParser::FunctionCallListContext::CLOSE_BRACKET() {
  return getToken(AntlrJsonParser::CLOSE_BRACKET, 0);
}

std::vector<tree::TerminalNode *> AntlrJsonParser::FunctionCallListContext::COMMA() {
  return getTokens(AntlrJsonParser::COMMA);
}

tree::TerminalNode* AntlrJsonParser::FunctionCallListContext::COMMA(size_t i) {
  return getToken(AntlrJsonParser::COMMA, i);
}


size_t AntlrJsonParser::FunctionCallListContext::getRuleIndex() const {
  return AntlrJsonParser::RuleFunctionCallList;
}

void AntlrJsonParser::FunctionCallListContext::enterRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->enterFunctionCallList(this);
}

void AntlrJsonParser::FunctionCallListContext::exitRule(tree::ParseTreeListener *listener) {
  auto parserListener = dynamic_cast<AntlrJsonParserListener *>(listener);
  if (parserListener != nullptr)
    parserListener->exitFunctionCallList(this);
}

AntlrJsonParser::FunctionCallListContext* AntlrJsonParser::functionCallList() {
  FunctionCallListContext *_localctx = _tracker.createInstance<FunctionCallListContext>(_ctx, getState());
  enterRule(_localctx, 20, AntlrJsonParser::RuleFunctionCallList);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(102);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 8, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(89);
      match(AntlrJsonParser::OPEN_BRACKET);
      setState(90);
      functionCall();
      setState(95);
      _errHandler->sync(this);
      _la = _input->LA(1);
      while (_la == AntlrJsonParser::COMMA) {
        setState(91);
        match(AntlrJsonParser::COMMA);
        setState(92);
        functionCall();
        setState(97);
        _errHandler->sync(this);
        _la = _input->LA(1);
      }
      setState(98);
      match(AntlrJsonParser::CLOSE_BRACKET);
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(100);
      match(AntlrJsonParser::OPEN_BRACKET);
      setState(101);
      match(AntlrJsonParser::CLOSE_BRACKET);
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

void AntlrJsonParser::initialize() {
#if ANTLR4_USE_THREAD_LOCAL_CACHE
  antlrjsonparserParserInitialize();
#else
  ::antlr4::internal::call_once(antlrjsonparserParserOnceFlag, antlrjsonparserParserInitialize);
#endif
}
