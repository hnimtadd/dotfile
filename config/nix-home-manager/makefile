# Variables
USERNAME := $(shell whoami)
ARCH := $(shell uname -m)
SYSTEM := $(if $(filter arm64,$(ARCH)),aarch64-darwin,$(if $(filter x86_64,$(ARCH)),x86_64-darwin,$(error Unsupported architecture: $(ARCH))))

# Colors
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

.PHONY: all switch check clean update help fetch-claude-hashes

# Default target
all: check switch


config:
	@echo "${GREEN}Current configuration:${NC}"
	@echo "Username: ${YELLOW}$(USERNAME)${NC}"
	@echo "System: ${YELLOW}$(SYSTEM)${NC}"
	@echo "Architecture: ${YELLOW}$(ARCH)${NC}"
	@echo ""

# Show help
help:
	@echo "Available targets:"
	@echo "  ${GREEN}all${NC}     - Check, build and switch configuration (default)"
	@echo "  ${GREEN}switch${NC}  - Build and switch to the configuration"
	@echo "  ${GREEN}check${NC}   - Check the configuration"
	@echo "  ${GREEN}fmt${NC}     - Format nix files"
	@echo "  ${GREEN}sha${NC}     - Generate sha256 hash for a given URL"
	@echo "  ${GREEN}update${NC}  - Update flake"
	@echo "  ${GREEN}update-claude-code${NC} - Update claude-code to latest version"
	@echo "  ${GREEN}fetch-claude-hashes${NC} - Fetch latest claude-code hashes for manual update"
	@echo ""
	@make config

# Check configuration
check: config
	@echo "${GREEN}Checking configuration...${NC}"
	@nix flake check

# Switch to configuration
switch:
	@echo "${GREEN}Switching to new configuration...${NC}"
	@USER=$(USERNAME) home-manager switch --flake .#default --impure
	@echo "${GREEN}Cleaning up...${NC}"
	@rm -rf ./result

# Format nix files
fmt:
	@echo "${GREEN}Formatting nix files...${NC}"
	@nix fmt

update:
	@echo "${GREEN}Updating flake...${NC}"
	@nix flake update

sha:
ifndef url
	@echo "Error: url parameter is required. Usage: make fetch url=<URL>"
	@exit 1
else
	@hash=$$(nix-prefetch-url --unpack $(url)) && nix hash convert --to sri --hash-algo sha256 $$hash
endif


# Fetch latest claude-code hashes for manual update
fetch-claude-hashes:
	@echo "${GREEN}Fetching latest claude-code hashes...${NC}"
	@./overlays/claude-code/fetch-hashes.sh
	@echo "${YELLOW}Copy the values above to update overlays/claude-code/default.nix${NC}"
