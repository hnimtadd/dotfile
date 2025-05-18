# Variables
HOSTNAME := $(shell scutil --get ComputerName)
USERNAME := $(shell whoami)
ARCH := $(shell uname -m)
SYSTEM := $(if $(filter arm64,$(ARCH)),aarch64-darwin,$(if $(filter x86_64,$(ARCH)),x86_64-darwin,$(error Unsupported architecture: $(ARCH))))

# Colors
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

.PHONY: all build switch check clean update help

# Default target
all: check build switch

# Show help
help:
	@echo "Available targets:"
	@echo "  ${GREEN}all${NC}     - Check, build and switch configuration (default)"
	@echo "  ${GREEN}build${NC}   - Build the configuration"
	@echo "  ${GREEN}switch${NC}  - Build and switch to the configuration"
	@echo "  ${GREEN}check${NC}   - Check the configuration"
	@echo "  ${GREEN}clean${NC}   - Clean build artifacts"
	@echo "  ${GREEN}update${NC}  - Update flake inputs"
	@echo ""
	@echo "Current configuration:"
	@echo "  Hostname: ${YELLOW}$(HOSTNAME)${NC}"
	@echo "  Username: ${YELLOW}$(USERNAME)${NC}"
	@echo "  System: ${YELLOW}$(SYSTEM)${NC}"

# Check configuration
check:
	@echo "${GREEN}Checking configuration...${NC}"
	@nix flake check

# Build configuration
build:
	@echo "${GREEN}Building configuration...${NC}"
	@nix build .#darwinConfigurations.$(HOSTNAME).system

# Switch to configuration
switch: build
	@echo "${GREEN}Switching to new configuration...${NC}"
	@./result/sw/bin/darwin-rebuild switch --flake .#$(HOSTNAME)
	@echo "${GREEN}Cleaning up...${NC}"
	@rm -rf ./result

# Clean build artifacts
clean:
	@echo "${GREEN}Cleaning build artifacts...${NC}"
	@rm -rf ./result
	@nix store gc

# Update flake inputs
update:
	@echo "${GREEN}Updating flake inputs...${NC}"
	@nix flake update

# Format nix files
fmt:
	@echo "${GREEN}Formatting nix files...${NC}"
	@nix fmt

# Show current configuration
config:
	@echo "${GREEN}Current configuration:${NC}"
	@echo "Hostname: ${YELLOW}$(HOSTNAME)${NC}"
	@echo "Username: ${YELLOW}$(USERNAME)${NC}"
	@echo "System: ${YELLOW}$(SYSTEM)${NC}"
	@echo "Architecture: ${YELLOW}$(ARCH)${NC}"
