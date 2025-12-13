import os
import sys
import argparse
from collections import defaultdict

def find_duplicate_objects(build_dir):
    """Scans the build directory for object files (.o) and groups them by base filename."""
    duplicates_found = False
    
    # Key: Base filename (e.g., "utils.o")
    # Value: List of full paths where that file was found
    object_map = defaultdict(list) 

    # 1. Walk the build directory
    for root, _, files in os.walk(build_dir):
        for filename in files:
            if filename.endswith(('.o', '.obj')):
                # Use the base name as the key
                object_map[filename].append(os.path.join(root, filename))

    # 2. Analyze the map for duplicates
    for base_name, paths in object_map.items():
        if len(paths) > 1:
            print("🛑 BUILD ERROR: Structural Duplication Detected!")
            print(f"The object file '{base_name}' is compiled in multiple targets.")
            print("This violates the 'compile once' rule and must be factored out.")
            
            # Print all locations for the user to troubleshoot
            for path in paths:
                print(f"  - Found at: {path}")
            
            print("-" * 50)
            duplicates_found = True

    return duplicates_found

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Structural duplicate object file checker.")
    parser.add_argument('--build-dir', required=True, help="The path to the CMake binary build directory.")
    args = parser.parse_args()

    # Exit with code 1 if duplicates are found, causing the build to fail
    if find_duplicate_objects(args.build_dir):
        sys.exit(1)
    else:
        print("✅ Duplicate object file check passed successfully.")