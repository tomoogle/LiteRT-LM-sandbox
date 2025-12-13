
// Generated from AntlrJsonLexer.g4 by ANTLR 4.13.2


#include "AntlrJsonLexer.h"


using namespace antlr4;

using namespace antlr_json_tool_call_parser;


using namespace antlr4;

namespace {

struct AntlrJsonLexerStaticData final {
  AntlrJsonLexerStaticData(std::vector<std::string> ruleNames,
                          std::vector<std::string> channelNames,
                          std::vector<std::string> modeNames,
                          std::vector<std::string> literalNames,
                          std::vector<std::string> symbolicNames)
      : ruleNames(std::move(ruleNames)), channelNames(std::move(channelNames)),
        modeNames(std::move(modeNames)), literalNames(std::move(literalNames)),
        symbolicNames(std::move(symbolicNames)),
        vocabulary(this->literalNames, this->symbolicNames) {}

  AntlrJsonLexerStaticData(const AntlrJsonLexerStaticData&) = delete;
  AntlrJsonLexerStaticData(AntlrJsonLexerStaticData&&) = delete;
  AntlrJsonLexerStaticData& operator=(const AntlrJsonLexerStaticData&) = delete;
  AntlrJsonLexerStaticData& operator=(AntlrJsonLexerStaticData&&) = delete;

  std::vector<antlr4::dfa::DFA> decisionToDFA;
  antlr4::atn::PredictionContextCache sharedContextCache;
  const std::vector<std::string> ruleNames;
  const std::vector<std::string> channelNames;
  const std::vector<std::string> modeNames;
  const std::vector<std::string> literalNames;
  const std::vector<std::string> symbolicNames;
  const antlr4::dfa::Vocabulary vocabulary;
  antlr4::atn::SerializedATNView serializedATN;
  std::unique_ptr<antlr4::atn::ATN> atn;
};

::antlr4::internal::OnceFlag antlrjsonlexerLexerOnceFlag;
#if ANTLR4_USE_THREAD_LOCAL_CACHE
static thread_local
#endif
std::unique_ptr<AntlrJsonLexerStaticData> antlrjsonlexerLexerStaticData = nullptr;

void antlrjsonlexerLexerInitialize() {
#if ANTLR4_USE_THREAD_LOCAL_CACHE
  if (antlrjsonlexerLexerStaticData != nullptr) {
    return;
  }
#else
  assert(antlrjsonlexerLexerStaticData == nullptr);
#endif
  auto staticData = std::make_unique<AntlrJsonLexerStaticData>(
    std::vector<std::string>{
      "OPEN_BRACE", "CLOSE_BRACE", "OPEN_BRACKET", "CLOSE_BRACKET", "COMMA", 
      "COLON", "BOOLEAN", "NONE", "FUNCTION_NAME", "FUNCTION_ARGUMENTS", 
      "STRING", "ESC", "UNICODE", "HEX", "NUMBER", "INT", "FRAC", "EXP", 
      "WS"
    },
    std::vector<std::string>{
      "DEFAULT_TOKEN_CHANNEL", "HIDDEN"
    },
    std::vector<std::string>{
      "DEFAULT_MODE"
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
  	4,0,13,166,6,-1,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,
  	6,2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,14,
  	7,14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,1,0,1,0,1,1,1,1,1,2,1,2,
  	1,3,1,3,1,4,1,4,1,5,1,5,1,6,1,6,1,6,1,6,1,6,1,6,1,6,1,6,1,6,3,6,61,8,
  	6,1,7,1,7,1,7,1,7,1,7,1,8,1,8,1,8,1,8,1,8,1,8,1,8,1,8,1,9,1,9,1,9,1,9,
  	1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,3,9,90,8,9,1,9,1,9,1,10,1,10,
  	1,10,5,10,97,8,10,10,10,12,10,100,9,10,1,10,1,10,1,11,1,11,1,11,3,11,
  	107,8,11,1,12,1,12,1,12,1,12,1,12,1,12,1,13,1,13,1,14,3,14,118,8,14,1,
  	14,1,14,1,14,3,14,123,8,14,1,14,3,14,126,8,14,1,14,1,14,3,14,130,8,14,
  	1,14,3,14,133,8,14,1,15,1,15,1,15,5,15,138,8,15,10,15,12,15,141,9,15,
  	3,15,143,8,15,1,16,1,16,4,16,147,8,16,11,16,12,16,148,1,17,1,17,3,17,
  	153,8,17,1,17,4,17,156,8,17,11,17,12,17,157,1,18,4,18,161,8,18,11,18,
  	12,18,162,1,18,1,18,0,0,19,1,1,3,2,5,3,7,4,9,5,11,6,13,7,15,8,17,9,19,
  	10,21,11,23,0,25,0,27,0,29,12,31,0,33,0,35,0,37,13,1,0,8,2,0,34,34,92,
  	92,8,0,34,34,47,47,92,92,98,98,102,102,110,110,114,114,116,116,3,0,48,
  	57,65,70,97,102,1,0,49,57,1,0,48,57,2,0,69,69,101,101,2,0,43,43,45,45,
  	3,0,9,10,13,13,32,32,177,0,1,1,0,0,0,0,3,1,0,0,0,0,5,1,0,0,0,0,7,1,0,
  	0,0,0,9,1,0,0,0,0,11,1,0,0,0,0,13,1,0,0,0,0,15,1,0,0,0,0,17,1,0,0,0,0,
  	19,1,0,0,0,0,21,1,0,0,0,0,29,1,0,0,0,0,37,1,0,0,0,1,39,1,0,0,0,3,41,1,
  	0,0,0,5,43,1,0,0,0,7,45,1,0,0,0,9,47,1,0,0,0,11,49,1,0,0,0,13,60,1,0,
  	0,0,15,62,1,0,0,0,17,67,1,0,0,0,19,75,1,0,0,0,21,93,1,0,0,0,23,103,1,
  	0,0,0,25,108,1,0,0,0,27,114,1,0,0,0,29,132,1,0,0,0,31,142,1,0,0,0,33,
  	144,1,0,0,0,35,150,1,0,0,0,37,160,1,0,0,0,39,40,5,123,0,0,40,2,1,0,0,
  	0,41,42,5,125,0,0,42,4,1,0,0,0,43,44,5,91,0,0,44,6,1,0,0,0,45,46,5,93,
  	0,0,46,8,1,0,0,0,47,48,5,44,0,0,48,10,1,0,0,0,49,50,5,58,0,0,50,12,1,
  	0,0,0,51,52,5,116,0,0,52,53,5,114,0,0,53,54,5,117,0,0,54,61,5,101,0,0,
  	55,56,5,102,0,0,56,57,5,97,0,0,57,58,5,108,0,0,58,59,5,115,0,0,59,61,
  	5,101,0,0,60,51,1,0,0,0,60,55,1,0,0,0,61,14,1,0,0,0,62,63,5,110,0,0,63,
  	64,5,117,0,0,64,65,5,108,0,0,65,66,5,108,0,0,66,16,1,0,0,0,67,68,5,34,
  	0,0,68,69,5,110,0,0,69,70,5,97,0,0,70,71,5,109,0,0,71,72,5,101,0,0,72,
  	73,1,0,0,0,73,74,5,34,0,0,74,18,1,0,0,0,75,89,5,34,0,0,76,77,5,97,0,0,
  	77,78,5,114,0,0,78,79,5,103,0,0,79,90,5,115,0,0,80,81,5,97,0,0,81,82,
  	5,114,0,0,82,83,5,103,0,0,83,84,5,117,0,0,84,85,5,109,0,0,85,86,5,101,
  	0,0,86,87,5,110,0,0,87,88,5,116,0,0,88,90,5,115,0,0,89,76,1,0,0,0,89,
  	80,1,0,0,0,90,91,1,0,0,0,91,92,5,34,0,0,92,20,1,0,0,0,93,98,5,34,0,0,
  	94,97,3,23,11,0,95,97,8,0,0,0,96,94,1,0,0,0,96,95,1,0,0,0,97,100,1,0,
  	0,0,98,96,1,0,0,0,98,99,1,0,0,0,99,101,1,0,0,0,100,98,1,0,0,0,101,102,
  	5,34,0,0,102,22,1,0,0,0,103,106,5,92,0,0,104,107,7,1,0,0,105,107,3,25,
  	12,0,106,104,1,0,0,0,106,105,1,0,0,0,107,24,1,0,0,0,108,109,5,117,0,0,
  	109,110,3,27,13,0,110,111,3,27,13,0,111,112,3,27,13,0,112,113,3,27,13,
  	0,113,26,1,0,0,0,114,115,7,2,0,0,115,28,1,0,0,0,116,118,5,45,0,0,117,
  	116,1,0,0,0,117,118,1,0,0,0,118,119,1,0,0,0,119,122,3,31,15,0,120,123,
  	3,33,16,0,121,123,3,35,17,0,122,120,1,0,0,0,122,121,1,0,0,0,122,123,1,
  	0,0,0,123,133,1,0,0,0,124,126,5,45,0,0,125,124,1,0,0,0,125,126,1,0,0,
  	0,126,127,1,0,0,0,127,133,3,33,16,0,128,130,5,45,0,0,129,128,1,0,0,0,
  	129,130,1,0,0,0,130,131,1,0,0,0,131,133,3,35,17,0,132,117,1,0,0,0,132,
  	125,1,0,0,0,132,129,1,0,0,0,133,30,1,0,0,0,134,143,5,48,0,0,135,139,7,
  	3,0,0,136,138,7,4,0,0,137,136,1,0,0,0,138,141,1,0,0,0,139,137,1,0,0,0,
  	139,140,1,0,0,0,140,143,1,0,0,0,141,139,1,0,0,0,142,134,1,0,0,0,142,135,
  	1,0,0,0,143,32,1,0,0,0,144,146,5,46,0,0,145,147,7,4,0,0,146,145,1,0,0,
  	0,147,148,1,0,0,0,148,146,1,0,0,0,148,149,1,0,0,0,149,34,1,0,0,0,150,
  	152,7,5,0,0,151,153,7,6,0,0,152,151,1,0,0,0,152,153,1,0,0,0,153,155,1,
  	0,0,0,154,156,7,4,0,0,155,154,1,0,0,0,156,157,1,0,0,0,157,155,1,0,0,0,
  	157,158,1,0,0,0,158,36,1,0,0,0,159,161,7,7,0,0,160,159,1,0,0,0,161,162,
  	1,0,0,0,162,160,1,0,0,0,162,163,1,0,0,0,163,164,1,0,0,0,164,165,6,18,
  	0,0,165,38,1,0,0,0,17,0,60,89,96,98,106,117,122,125,129,132,139,142,148,
  	152,157,162,1,6,0,0
  };
  staticData->serializedATN = antlr4::atn::SerializedATNView(serializedATNSegment, sizeof(serializedATNSegment) / sizeof(serializedATNSegment[0]));

  antlr4::atn::ATNDeserializer deserializer;
  staticData->atn = deserializer.deserialize(staticData->serializedATN);

  const size_t count = staticData->atn->getNumberOfDecisions();
  staticData->decisionToDFA.reserve(count);
  for (size_t i = 0; i < count; i++) { 
    staticData->decisionToDFA.emplace_back(staticData->atn->getDecisionState(i), i);
  }
  antlrjsonlexerLexerStaticData = std::move(staticData);
}

}

AntlrJsonLexer::AntlrJsonLexer(CharStream *input) : Lexer(input) {
  AntlrJsonLexer::initialize();
  _interpreter = new atn::LexerATNSimulator(this, *antlrjsonlexerLexerStaticData->atn, antlrjsonlexerLexerStaticData->decisionToDFA, antlrjsonlexerLexerStaticData->sharedContextCache);
}

AntlrJsonLexer::~AntlrJsonLexer() {
  delete _interpreter;
}

std::string AntlrJsonLexer::getGrammarFileName() const {
  return "AntlrJsonLexer.g4";
}

const std::vector<std::string>& AntlrJsonLexer::getRuleNames() const {
  return antlrjsonlexerLexerStaticData->ruleNames;
}

const std::vector<std::string>& AntlrJsonLexer::getChannelNames() const {
  return antlrjsonlexerLexerStaticData->channelNames;
}

const std::vector<std::string>& AntlrJsonLexer::getModeNames() const {
  return antlrjsonlexerLexerStaticData->modeNames;
}

const dfa::Vocabulary& AntlrJsonLexer::getVocabulary() const {
  return antlrjsonlexerLexerStaticData->vocabulary;
}

antlr4::atn::SerializedATNView AntlrJsonLexer::getSerializedATN() const {
  return antlrjsonlexerLexerStaticData->serializedATN;
}

const atn::ATN& AntlrJsonLexer::getATN() const {
  return *antlrjsonlexerLexerStaticData->atn;
}




void AntlrJsonLexer::initialize() {
#if ANTLR4_USE_THREAD_LOCAL_CACHE
  antlrjsonlexerLexerInitialize();
#else
  ::antlr4::internal::call_once(antlrjsonlexerLexerOnceFlag, antlrjsonlexerLexerInitialize);
#endif
}
