#!/bin/bash

# Define the target directory from the first script argument, default to current directory if not provided
TARGET_DIR="${1:-.}"

# Fetch Processing JAR
bash -c "./fetch_processing_jar.sh $TARGET_DIR"

# Change to the target directory
cd $TARGET_DIR

echo "Searching for the location of libgluegen-rt.so..."
find / -name libgluegen-rt.so 2>/dev/null

# Run the build command with xvfb-run
echo "Running in a headless environment. Building with xvfb..."
xvfb-run python generator.py build --all --images