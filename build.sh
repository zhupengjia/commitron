#!/bin/bash
set -e

# Function to output section headers
section() {
  echo "======================================"
  echo "= $1"
  echo "======================================"
}

# Check Go installation
section "Checking Go installation"
if ! command -v go &> /dev/null; then
  echo "Go is not installed or not in PATH"
  exit 1
fi
go version

# Get dependencies
section "Getting dependencies"
go mod tidy

# Run tests
section "Running tests"
go test -v ./...

# Build for different platforms
section "Building binaries"

PLATFORMS=("darwin/amd64" "darwin/arm64" "linux/amd64" "windows/amd64")
OUTPUT_DIR="./dist"

# Clean output directory
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

for PLATFORM in "${PLATFORMS[@]}"; do
  GOOS=${PLATFORM%/*}
  GOARCH=${PLATFORM#*/}

  OUTPUT_NAME="commitron"
  if [ "$GOOS" = "windows" ]; then
    OUTPUT_NAME="commitron.exe"
  fi

  OUTPUT_PATH="$OUTPUT_DIR/commitron-$GOOS-$GOARCH"
  if [ "$GOOS" = "windows" ]; then
    OUTPUT_PATH="$OUTPUT_PATH.exe"
  fi

  echo "Building for $GOOS/$GOARCH..."
  GOOS=$GOOS GOARCH=$GOARCH go build -o "$OUTPUT_PATH" ./cmd/commitron

  if [ $? -ne 0 ]; then
    echo "Build failed for $GOOS/$GOARCH"
    exit 1
  fi
done

section "Build completed successfully!"
ls -la "$OUTPUT_DIR"