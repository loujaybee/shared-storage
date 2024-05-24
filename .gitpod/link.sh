#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Example usage if needed
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <folder-name> <src-basedir> <target-basedir>"
  exit 1
fi

SHARED_FOLDER=$3
FOLDER=$1
SRC_BASEDIR=$2
SRC_DIR="${SRC_BASEDIR}/${FOLDER}"
TARGET_DIR="${SHARED_FOLDER}/${FOLDER}"

if [ -L "$SRC_DIR" ]; then
    echo "$SRC_DIR is a symlink already. Doing nothing." 
elif [ -d "$SRC_DIR" ]; then
    if [ -d "$TARGET_DIR" ]; then
        echo "deleting $SRC_DIR and replacing it with a symlink pointing to $TARGET_DIR" 
        rm -rf "$SRC_DIR"
    else
        echo "moving $SRC_DIR to $TARGET_DIR and replacing it with a symlink" 
        mv "$SRC_DIR" "$TARGET_DIR"
    fi
    ln -s "$TARGET_DIR" "$SRC_DIR"
else 
    echo "creating new symlink from $SRC_DIR to $TARGET_DIR"
    mkdir -p "$SRC_BASEDIR"
    ln -s "$TARGET_DIR" "$SRC_DIR"
fi

