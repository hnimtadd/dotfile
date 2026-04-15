#!/usr/bin/env bash

# Don't exit on error - we'll handle errors gracefully
set +e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Get the dotfile directory
DOTFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILE_DIR

print_info "Starting installation process..."
print_info "Dotfile directory: $DOTFILE_DIR"

# Step 0: Backup conflicting system files
backup_system_files() {
    print_step "Checking for conflicting system files..."

    local files_to_backup=(
        "/etc/zshrc"
        "/etc/bashrc"
        "/etc/zshenv"
    )

    for file in "${files_to_backup[@]}"; do
        if [ -f "$file" ] && [ ! -f "${file}.before-nix-darwin" ]; then
            print_info "Backing up $file to ${file}.before-nix-darwin"
            sudo mv "$file" "${file}.before-nix-darwin" 2>/dev/null || {
                print_warn "Could not backup $file - you may need to do this manually with:"
                print_warn "  sudo mv $file ${file}.before-nix-darwin"
            }
        fi
    done
}

# Step 1: Check prerequisites
check_prerequisites() {
    print_step "Checking prerequisites..."

    # Check if running on macOS
    if [[ "$(uname)" != "Darwin" ]]; then
        print_error "This script is designed for macOS only."
        exit 1
    fi

    # Check for Command Line Tools
    if ! xcode-select -p &> /dev/null; then
        print_warn "Xcode Command Line Tools not found."
        print_info "Installing Command Line Tools..."
        xcode-select --install
        print_warn "Please wait for the installation to complete, then re-run this script."
        exit 0
    fi

    # Warn about Full Disk Access for System Preferences
    print_warn "nix-darwin needs to modify system preferences."
    print_warn "If you see permission errors for 'com.apple.universalaccess':"
    print_warn "  1. Open System Settings → Privacy & Security → Full Disk Access"
    print_warn "  2. Add your Terminal app (Terminal.app, iTerm2, WezTerm, etc.)"
    print_warn "  3. Restart the terminal and re-run this script"
    echo ""
}

# Step 2: Install Nix
install_nix() {
    if command -v nix &> /dev/null; then
        print_info "Nix is already installed."
    else
        print_step "Installing Nix package manager (official installer)..."
        print_info "Using official Nix installer (nix-darwin will manage it after)"

        # Use the official Nix installer (multi-user)
        sh <(curl -L https://nixos.org/nix/install) --daemon

        # Source nix for the current session
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
            . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi

        # Verify installation
        if ! command -v nix &> /dev/null; then
            print_error "Nix installation failed. Please check the output above."
            exit 1
        fi
    fi
}

# Step 3: Enable Nix flakes and nix-command
enable_flakes() {
    print_step "Enabling Nix flakes..."
    mkdir -p ~/.config/nix
    if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
        echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
        print_info "Flakes enabled in ~/.config/nix/nix.conf"
    else
        print_info "Flakes already enabled"
    fi
}

# Step 4: Install nix-darwin
install_nix_darwin() {
    if command -v darwin-rebuild &> /dev/null; then
        print_warn "nix-darwin is already installed, updating configuration..."
        cd "$DOTFILE_DIR/config/nix-darwin"
        darwin-rebuild switch --flake . || {
            print_error "darwin-rebuild failed. Common fixes:"
            print_error "  1. Check Full Disk Access permissions (System Settings → Privacy & Security)"
            print_error "  2. Manually backup /etc/zshrc: sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin"
            print_error "  3. Re-run this script"
            exit 1
        }
    else
        print_step "Installing nix-darwin for the first time..."
        cd "$DOTFILE_DIR/config/nix-darwin"

        print_info "Building nix-darwin configuration..."
        print_warn "This may take several minutes on first run..."

        # Build and activate nix-darwin configuration
        make switch
    fi
}

# Step 5: Install home-manager
install_home_manager() {
    print_step "Installing home-manager configuration..."
    cd "$DOTFILE_DIR/config/nix-home-manager"

    # Build and activate home-manager configuration
    make switch
}

# Step 6: Setup Ollama (optional)
setup_ollama() {
    if command -v ollama &> /dev/null; then
        print_step "Ollama found. Setting up models..."
        print_warn "This will download several large models (~15GB). Press Ctrl+C to skip."
        sleep 3

        ollama pull qwen2.5-coder:14b || print_warn "Failed to pull qwen2.5-coder:14b"
        ollama pull qwen2.5-coder:7b || print_warn "Failed to pull qwen2.5-coder:7b"
        ollama pull qwen2.5-coder:1.5b || print_warn "Failed to pull qwen2.5-coder:1.5b"
        ollama pull nomic-embed-text || print_warn "Failed to pull nomic-embed-text"

        print_info "Ollama models installed!"
    else
        print_warn "Ollama not found. You can install it later:"
        print_info "  1. Download from https://ollama.ai"
        print_info "  2. Run: make setup-ollama"
    fi
}

# Step 7: Post-installation steps
post_install() {
    print_step "Running post-installation steps..."

    # Source the shell configuration
    if [ -n "$SHELL" ]; then
        case "$SHELL" in
            */zsh)
                print_info "Sourcing zsh configuration..."
                if [ -f ~/.zshrc ]; then
                    zsh -c "source ~/.zshrc" 2>/dev/null || true
                fi
                ;;
            */bash)
                print_info "Sourcing bash configuration..."
                if [ -f ~/.bashrc ]; then
                    source ~/.bashrc 2>/dev/null || true
                fi
                ;;
        esac
    fi

    # Setup Homebrew environment
    if [[ $(uname -m) == 'arm64' ]]; then
        if [ -x "/opt/homebrew/bin/brew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

# Main installation flow
main() {
    read -p "Continue with installation? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warn "Installation cancelled."
        exit 0
    fi

    echo ""
    check_prerequisites
    backup_system_files
    install_nix
    enable_flakes
    install_nix_darwin
    install_home_manager
    post_install

    echo ""
    print_info "Installation Complete!"
}

main "$@"
