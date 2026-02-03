import os
import pathlib

# --- CONFIGURATION ---
# Point these to your actual install prefixes
LIB_PATHS = {
    "absl": "/usr/local/code/github/LiteRT-LM/cmake/build/external/abseil-cpp/install/lib",
    "tflite": "/usr/local/code/github/LiteRT-LM/cmake/build/external/tensorflow/install/lib",
    "flatbuffers": "/usr/local/code/github/LiteRT-LM/cmake/build/external/flatbuffers/install/lib",
    "gtest": "/usr/local/code/github/LiteRT-LM/cmake/build/external/googletest/install/lib",
    "litert": "/usr/local/code/github/LiteRT-LM/cmake/build/external/litert/install/lib",
    "re2": "/usr/local/code/github/LiteRT-LM/cmake/build/external/re2/install/lib",
    "sentencepiece": "/usr/local/code/github/LiteRT-LM/cmake/build/external/sentencepiece/install/lib",
    "tokenizers": "/usr/local/code/github/LiteRT-LM/cmake/build/external/tokenizers-cpp/install/lib"
}

def generate_cmake_imports(prefix, search_path):
    p = pathlib.Path(search_path)
    if not p.exists():
        return f"# Path not found: {search_path}"

    static_libs = sorted(list(p.glob("*.a")))
    
    output = [f"\n# --- {prefix.upper()} AUTO-GENERATED IMPORTS ---"]
    target_names = []

    for lib in static_libs:
        # e.g., libabsl_strings.a -> absl_strings
        clean_name = lib.stem[3:] if lib.stem.startswith("lib") else lib.stem
        import_name = f"imp_{clean_name}"
        
        # Create the import line
        # Use a variable for the path so the CMake remains portable
        output.append(f'import_static_lib({import_name:30} "${{{prefix.upper()}_LIB_DIR}}/{lib.name}")')
        target_names.append(import_name)

    # Create the "Big Pot" Interface
    output.append(f"\nadd_library({prefix}_libs INTERFACE GLOBAL)")
    output.append(f"target_link_libraries({prefix}_libs INTERFACE")
    for t in target_names:
        output.append(f"    {t}")
    output.append(")")
    
    return "\n".join(output)

if __name__ == "__main__":
    for prefix, path in LIB_PATHS.items():
        print(generate_cmake_imports(prefix, path))