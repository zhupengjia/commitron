# Variables
BINARY_NAME=commitron
BUILD_DIR=bin
DIST_DIR=dist
PLATFORMS=darwin/amd64 darwin/arm64 linux/amd64 windows/amd64

# Default target
.DEFAULT_GOAL := help

# Help target
help: ## Show this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

# Check if Go is installed
check-go: ## Check if Go is installed
	@if ! command -v go &> /dev/null; then \
		echo "Go is not installed or not in PATH"; \
		exit 1; \
	fi
	@go version

# Get dependencies
deps: ## Get Go dependencies
	go mod tidy

# Run tests
test: ## Run Go tests
	go test -v ./...

# Build for current platform
build: check-go deps ## Build for current platform
	@echo "Building $(BINARY_NAME)..."
	@go build -o $(BUILD_DIR)/$(BINARY_NAME) ./cmd/$(BINARY_NAME)
	@chmod +x $(BUILD_DIR)/$(BINARY_NAME)
	@echo "Build successful!"

# Build for all platforms
build-all: check-go deps ## Build for all supported platforms
	@echo "Building binaries for all platforms..."
	@rm -rf $(DIST_DIR)
	@mkdir -p $(DIST_DIR)
	@for platform in $(PLATFORMS); do \
		GOOS=$${platform%/*}; \
		GOARCH=$${platform#*/}; \
		output_name="$(BINARY_NAME)"; \
		if [ "$$GOOS" = "windows" ]; then \
			output_name="$(BINARY_NAME).exe"; \
		fi; \
		output_path="$(DIST_DIR)/$(BINARY_NAME)-$$GOOS-$$GOARCH"; \
		if [ "$$GOOS" = "windows" ]; then \
			output_path="$$output_path.exe"; \
		fi; \
		echo "Building for $$GOOS/$$GOARCH..."; \
		GOOS=$$GOOS GOARCH=$$GOARCH go build -o "$$output_path" ./cmd/$(BINARY_NAME); \
	done
	@echo "Build completed successfully!"
	@ls -la $(DIST_DIR)

# Run the binary
run: build ## Run the binary with provided arguments
	@echo "Running $(BINARY_NAME)..."
	@echo "-------------------------------------"
	@./$(BUILD_DIR)/$(BINARY_NAME) $(ARGS)

# Clean build artifacts
clean: ## Clean build artifacts
	@rm -rf $(BUILD_DIR) $(DIST_DIR)

.PHONY: help check-go deps test build build-all run clean