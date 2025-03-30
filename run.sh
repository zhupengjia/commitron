#!/bin/bash

# Build the project
echo "Building commitron..."
go build -o bin/commitron ./cmd/commitron

# Check if build was successful
if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

# Make the binary executable
chmod +x bin/commitron

echo "Build successful! Running commitron..."
echo "-------------------------------------"

# Run the tool with any provided arguments
./bin/commitron "$@"