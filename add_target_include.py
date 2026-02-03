import os
import re
from pathlib import Path
import sys

# --- Configuration Constants ---
# Use spaces for indentation, as seen in your preferred style
NEW_INCLUDE_ARG = '    ${LITERTLM_INCLUDE_PATHS}' 
# We'll prepend a space and a newline to the NEW_INCLUDE_ARG inside the replacer for cleaner insertion

# Regex pattern to find target_include_directories blocks.
# We use a non-greedy pattern with re.DOTALL to capture content across multiple lines.
# This pattern captures the entire block: target_include_directories(...)
TID_PATTERN = re.compile(
    r'target_include_directories\s*\(.*?\)', 
    re.DOTALL
)

# The list of directories to search (relative to PROJECT_ROOT)
SEARCH_DIRS = ['c', 'runtime', 'schema']

# Path to the project root (The directory where this script will be executed from)
PROJECT_ROOT = Path(os.getcwd())

# ----------------------------------------------------------------------
# Core Logic: Function to insert the argument
# ----------------------------------------------------------------------

def insert_include_before_closing_paren(filepath: Path, new_arg: str) -> bool:
    """
    Reads a CMakeLists.txt file, finds all target_include_directories blocks,
    and inserts the new include argument before the final closing parenthesis.
    """
    try:
        content = filepath.read_text(encoding='utf-8')
    except Exception as e:
        print(f"Error reading {filepath}: {e}", file=sys.stderr)
        return False

    # Track if any modification was made
    modified = False

    def replacer(match):
        nonlocal modified
        full_block = match.group(0)
        
        # 1. Check if the path is already present to prevent infinite re-insertion
        # We check for the raw variable name without surrounding quotes/braces
        if '${LITERTLM_INCLUDE_PATH}' in full_block:
            return full_block  # Return block unchanged

        modified = True
        
        # 2. Find the final ')' in the captured block. 
        # rfind() is necessary because the block might contain nested calls or newlines.
        last_paren_index = full_block.rfind(')')
        
        # 3. Reconstruct the string: 
        # [Content before ')'] + [Newline + New Arg + Indentation] + [')']
        
        # We need to insert a newline and appropriate indentation before the new argument.
        # Use simple space padding here, assuming the final ')' is preceded by a newline/space.
        
        # The insertion string includes a leading space to ensure it's not run into the previous arg
        insertion_string = f'\n{new_arg}' 

        return (
            full_block[:last_paren_index] +  # Content up to the last ')'
            insertion_string + 
            full_block[last_paren_index:]    # The final ')'
        )

    # Apply the substitution to the entire file content
    new_content = TID_PATTERN.sub(replacer, content)

    if modified:
        try:
            filepath.write_text(new_content, encoding='utf-8')
            print(f"SUCCESS: {filepath} modified.")
            return True
        except Exception as e:
            print(f"Error writing to {filepath}: {e}", file=sys.stderr)
            return False
    
    return False

# ----------------------------------------------------------------------
# Main Execution Loop
# ----------------------------------------------------------------------

def main():
    modified_count = 0
    print(f"Starting refactoring from root: {PROJECT_ROOT}")

    for search_dir in SEARCH_DIRS:
        full_path = PROJECT_ROOT / search_dir
        
        # Use os.walk for reliable recursive file system traversal
        for root, dirs, files in os.walk(full_path):
            for file in files:
                if file == 'CMakeLists.txt':
                    file_path = Path(root) / file
                    
                    # Perform the refactoring
                    result = insert_include_before_closing_paren(file_path, NEW_INCLUDE_ARG)
                    if result:
                        modified_count += 1
                        
    print(f"\nRefactoring complete. Total files modified: {modified_count}")


if __name__ == "__main__":
    main()