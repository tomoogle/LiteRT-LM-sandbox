#!/bin/bash
SOURCE_DIR=$(pwd)
DEST_DIR="$1"

if [ -z "$DEST_DIR" ]; then
    echo "Usage: ./copy_cmake_only.sh <destination>"
    exit 1
fi

echo "📂 Copying ONLY build files to: $DEST_DIR"

rsync -avm \
    --include='*/' \
    --include='CMakeLists.txt' \
    --include='*.cmake' \
    --exclude='*' \
    "$SOURCE_DIR/" "$DEST_DIR/"

echo "✅ Done."
