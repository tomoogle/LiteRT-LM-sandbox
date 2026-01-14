# litert_patcher.cmake
message(STATUS "[LITERTLM] Starting LiteRT Surgical Patching...")

# --- 1. The Global Abseil Hammer ---
# We use regex to catch any absl:: target and point it to our sink
file(GLOB_RECURSE ALL_CMAKELISTS "${LITERT_SOURCE_DIR}/litert/*.cmake" "${LITERT_SOURCE_DIR}/litert/CMakeLists.txt")

foreach(C_FILE ${ALL_CMAKELISTS})
    file(READ "${C_FILE}" CONTENT)
    # Redirect modular absl targets
    string(REGEX REPLACE "absl::[a-zA-Z0-9_]+" "LiteRTLM::absl::absl" CONTENT "${CONTENT}")
    file(WRITE "${C_FILE}" "${CONTENT}")
endforeach()

# --- 2. Source Code Fixes ---
# Fix return type mismatch in compiled_model.cc
set(MODEL_CC "${LITERT_SOURCE_DIR}/litert/runtime/compiled_model.cc")
if(EXISTS "${MODEL_CC}")
    execute_process(COMMAND sed -i "s/ return litert_cpu_buffer_requirements/return litert::Expected<const LiteRtTensorBufferRequirementsT*>(litert_cpu_buffer_requirements)/" "${MODEL_CC}")
endif()

# Fix layout constexpr issue
set(LAYOUT_H "${LITERT_SOURCE_DIR}/litert/cc/litert_layout.h")
if(EXISTS "${LAYOUT_H}")
    execute_process(COMMAND sed -i "s/constexpr \\(.*\\)Layout(/ \\1Layout(/g" "${LAYOUT_H}")
endif()

# --- 3. Root Injection ---
set(ROOT_LIST "${LITERT_SOURCE_DIR}/litert/CMakeLists.txt")
if(EXISTS "${ROOT_LIST}")
    set(INJECTION "include(\"${LITERTLM_RECIPES_DIR}/litert/litert_shims.cmake\")\n")
    file(READ "${ROOT_LIST}" CONTENT)
    file(WRITE "${ROOT_LIST}" "${INJECTION}${CONTENT}")
endif()

message(STATUS "[LITERTLM] LiteRT Patching Complete.")
