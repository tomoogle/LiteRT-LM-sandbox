import os
import re
import sys

def audit_cmake_sources(directory):
    """
    Checks for discrepancies between .cc files on disk and files listed
    in the CMakeLists.txt's add_library or add_executable calls.
    """
    cmake_file = os.path.join(directory, "CMakeLists.txt")
    
    if not os.path.isdir(directory):
        print(f"Error: Directory not found: {directory}")
        sys.exit(1)
    
    if not os.path.exists(cmake_file):
        print(f"Error: CMakeLists.txt not found in {directory}")
        sys.exit(1)

    # 1. Gather .cc files from the filesystem
    fs_files = set()
    for item in os.listdir(directory):
        if item.endswith(".cc"):
            fs_files.add(item)
    
    if not fs_files:
        print(f"No .cc files found in directory: {directory}")
        return

    # 2. Gather .cc files listed in CMakeLists.txt
    cmake_files = set()
    
    # Regex to capture filenames in add_library or add_executable calls
    # It handles multiple lines and semicolons.
    # Note: This regex is simplified and assumes filenames are not variables.
    source_regex = re.compile(
        r'(add_litert_library|add_library|add_litert_executable|add_executable)\s*\(.*?\s*STATIC|SHARED|INTERFACE|\s*\n?(.*?)\)', 
        re.DOTALL | re.IGNORECASE
    )
    
    with open(cmake_file, 'r') as f:
        content = f.read()

        # Simple pattern to catch common source list formats
        # Handles files listed directly without being inside a 'set' variable
        # We look for lines containing '.cc' after an add_* call
        
        # A more direct approach: extract all words that end in .cc
        # This is a safe, liberal search.
        for word in re.findall(r'[\w\/\.\-]+\.cc', content):
            # Clean up the word by removing paths if necessary
            base_name = os.path.basename(word)
            cmake_files.add(base_name)

    # 3. Compare the sets
    
    # Files on disk but MISSING from CMakeLists.txt
    missing_in_cmake = fs_files - cmake_files
    
    # Files in CMakeLists.txt but NOT found on disk (likely typos or deleted files)
    missing_on_disk = cmake_files - fs_files

    print("-" * 50)
    print(f"AUDIT RESULTS for: {directory}")
    print("-" * 50)
    
    if not missing_in_cmake and not missing_on_disk:
        print("✅ SUCCESS: All .cc files on disk are accounted for in CMakeLists.txt.")
        print("-" * 50)
        return

    # --- Report Discrepancies ---
    
    if missing_in_cmake:
        print("🔴 ERROR: The following .cc files exist on disk but are MISSING from CMakeLists.txt:")
        for file in sorted(list(missing_in_cmake)):
            print(f"  - {file}")
        print("\nThese files are likely the cause of 'undefined reference' errors.")

    if missing_on_disk:
        print("\n🟡 WARNING: The following .cc files are listed in CMakeLists.txt but were NOT found on disk:")
        for file in sorted(list(missing_on_disk)):
            print(f"  - {file}")
        print("\nThese are likely typos in CMakeLists.txt or files that were deleted without updating CMake.")
        
    print("-" * 50)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python check_cmake_sources.py <directory_path>")
        sys.exit(1)
        
    target_directory = sys.argv[1]
    audit_cmake_sources(target_directory)
