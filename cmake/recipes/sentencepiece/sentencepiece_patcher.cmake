# sentencepiece_patcher.cmake
message(STATUS "[LiteRTLM] Patching SentencePiece source at: ${SENTENCE_SRC_DIR}")

# 1. Nuke the stowaways
file(REMOVE_RECURSE "${SENTENCE_SRC_DIR}/third_party/abseil-cpp")
file(REMOVE_RECURSE "${SENTENCE_SRC_DIR}/third_party/absl")
file(REMOVE_RECURSE "${SENTENCE_SRC_DIR}/third_party/protobuf")
file(REMOVE_RECURSE "${SENTENCE_SRC_DIR}/third_party/protobuf-lite")

# ---- ROOT/CMakeLists
# 2. Source-level hijacks
file(READ "${SENTENCE_SRC_DIR}/CMakeLists.txt" CONTENT)

string(REPLACE 
    "option(SPM_USE_BUILTIN_PROTOBUF \"Use builtin protobuf\" ON)" 
    "option(SPM_USE_BUILTIN_PROTOBUF \"Use builtin protobuf\" OFF)" 
    CONTENT "${CONTENT}")

string(REPLACE "set(CMAKE_CXX_STANDARD 17)" "set(CMAKE_CXX_STANDARD 20)" CONTENT "${CONTENT}")

set(SHIM_INCLUDE "include(${LITERTLM_SENTENCE_SHIM_PATH})\n")
set(CONTENT ${SHIM_INCLUDE}${CONTENT})
file(WRITE "${SENTENCE_SRC_DIR}/CMakeLists.txt" ${CONTENT})


# ---- ROOT/src/CMakeLists\
file(READ "${SENTENCE_SRC_DIR}/src/CMakeLists.txt" CONTENT)

message(STATUS "[LiteRTLM] Redirecting SentencePiece internal Protobuf paths...")
string(REPLACE "\${CMAKE_CURRENT_SOURCE_DIR}/../third_party/protobuf-lite" 
               "\${PROTOBUF_SRC_FILE_PATH}" 
               CONTENT "${CONTENT}")

string(REPLACE "\${CMAKE_CURRENT_SOURCE_DIR}/../third_party/absl/flags/flag.cc" 
               "\${ABSL_SRC_FILE_PATH}/flags/internal/flag.cc" 
               CONTENT "${CONTENT}")


string(REPLACE 
    "include_directories(\${CMAKE_CURRENT_SOURCE_DIR}/../third_party)" 
    "include_directories(\${CMAKE_CURRENT_SOURCE_DIR}/../third_party)\ninclude_directories(\${ABSL_INLUDE_FILE_PATH})\ninclude_directories(\${PROTOBUF_INCLUDE_DIR})" 
    CONTENT "${CONTENT}")

string(REPLACE 
    "set(libprotobuf_lite \"\")"
    "set(libprotobuf_lite LiteRTLM::protobuf::libprotobuf)"
    CONTENT "${CONTENT}")



set(CONTENT ${SHIM_INCLUDE}${CONTENT})
file(WRITE "${SENTENCE_SRC_DIR}/src/CMakeLists.txt" ${CONTENT})


# ------------------------------------------------------------------------------
# THE CARPET BOMB: Recursive Header Normalization
# ------------------------------------------------------------------------------
message(STATUS "[LiteRTLM] Starting recursive header normalization in ${SENTENCE_SRC_DIR}...")

# 1. Collect every source and header file in the project
file(GLOB_RECURSE ALL_FILES 
    "${SENTENCE_SRC_DIR}/*.h"
    "${SENTENCE_SRC_DIR}/*.cc"
    "${SENTENCE_SRC_DIR}/*.cpp"
)

# 2. Iterate and Replace
foreach(FILE_PATH ${ALL_FILES})
    file(READ "${FILE_PATH}" FILE_CONTENT)
    
    set(MODIFIED FALSE)

    # Hijack Abseil includes
    if(FILE_CONTENT MATCHES "third_party/absl/")
        string(REPLACE "third_party/absl/" "absl/" FILE_CONTENT "${FILE_CONTENT}")
        set(MODIFIED TRUE)
    endif()

    # Hijack Protobuf includes (the Lite variant)
    if(FILE_CONTENT MATCHES "third_party/protobuf-lite/")
        string(REPLACE "third_party/protobuf-lite/" "google/protobuf/" FILE_CONTENT "${FILE_CONTENT}")
        set(MODIFIED TRUE)
    endif()

    # 3. Only write back if we actually changed something (saves disk I/O)
    if(MODIFIED)
        file(WRITE "${FILE_PATH}" "${FILE_CONTENT}")
    endif()
endforeach()

message(STATUS "[LiteRTLM] Normalized ${SENTENCE_SRC_DIR} successfully.")



# ==============================================================================
# CARPET BOMB: SharedBitGen -> BitGen
# ==============================================================================
message(STATUS "[LiteRTLM] Running Carpet Bomb: SharedBitGen -> BitGen in SentencePiece")

# Define the list of files to hit (or glob the whole src directory)
file(GLOB_RECURSE SP_SOURCES 
    "${SENTENCE_SRC_DIR}/src/*.cc" 
    "${SENTENCE_SRC_DIR}/src/*.h"
)

foreach(FILE_PATH ${SP_SOURCES})
    file(READ "${FILE_PATH}" CONTENT)
    
    # Check if the file contains SharedBitGen before processing
    if(CONTENT MATCHES "SharedBitGen")
        # 1. Swap the class name
        string(REPLACE "absl::SharedBitGen" "absl::BitGen" CONTENT "${CONTENT}")
        
        # 2. Ensure random.h is included if we swapped a name
        if(NOT CONTENT MATCHES "#include \"absl/random/random.h\"")
            # Inject it after strings/string_view.h or any other absl header
            string(REPLACE "#include \"absl/strings/string_view.h\"" 
                           "#include \"absl/strings/string_view.h\"\n#include \"absl/random/random.h\"" 
                           CONTENT "${CONTENT}")
        endif()
        
        file(WRITE "${FILE_PATH}" "${CONTENT}")
        message(STATUS "  - Patched: ${FILE_PATH}")
    endif()
endforeach()



file(READ "${SENTENCE_SRC_DIR}/src/CMakeLists.txt" CONTENT)

# Force every target that links sentencepiece to also link our Abseil Omnibus
# This is a broad-spectrum fix for all the spm_* executables
string(REPLACE "target_link_libraries(\${SPM_EXE} sentencepiece" 
               "target_link_libraries(\${SPM_EXE} sentencepiece LiteRTLM::absl::absl" 
               CONTENT "${CONTENT}")

# Some SP versions use a different variable or direct names
string(REPLACE "target_link_libraries(spm_export_vocab sentencepiece" 
               "target_link_libraries(spm_export_vocab sentencepiece LiteRTLM::absl::absl" 
               CONTENT "${CONTENT}")

string(REPLACE 
    "absl::strings"
    "LiteRTLM::absl::absl" 
    CONTENT "${CONTENT}")


string(REPLACE 
    "absl::flags_parse"
    "LiteRTLM::absl::absl" 
    CONTENT "${CONTENT}")

string(REPLACE 
    "absl::flags"
    "LiteRTLM::absl::absl" 
    CONTENT "${CONTENT}")





file(WRITE "${SENTENCE_SRC_DIR}/src/CMakeLists.txt" "${CONTENT}")