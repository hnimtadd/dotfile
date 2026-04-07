#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Get the dotfile directory
DOTFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILE_DIR

print_info "Starting installation process..."
print_info "Dotfile directory: $DOTFILE_DIR"

# Step 1: Install Nix package manager
install_nix() {
    if command -v nix &> /dev/null; then
        print_warn "Nix is already installed, skipping..."
    else
        print_info "Installing Nix package manager..."
        curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

        # Source nix for the current session
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
            . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
    fi
}

# Step 2: Enable Nix flakes and nix-command
enable_flakes() {
    print_info "Enabling Nix flakes..."
    mkdir -p ~/.config/nix
    if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
        echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    fi
}

# Step 3: Install nix-darwin
install_nix_darwin() {
    if command -v darwin-rebuild &> /dev/null; then
        print_warn "nix-darwin is already installed, skipping..."
    else
        print_info "Installing nix-darwin..."
        cd "$DOTFILE_DIR/config/nix-darwin"

        # Build and activate nix-darwin configuration
        make switch
    fi
}

# Step 4: Install home-manager
install_home_manager() {
    print_info "Installing home-manager configuration..."
    cd "$DOTFILE_DIR/config/nix-home-manager"

    # Build and activate home-manager configuration
    make switch
}

# Step 6: Post-installation steps
post_install() {
    print_info "Running post-installation steps..."

    # Source the shell configuration
    if [ -n "$SHELL" ]; then
        case "$SHELL" in
            */zsh)
                print_info "Sourcing zsh configuration..."
                if [ -f ~/.zshrc ]; then
                    zsh -c "source ~/.zshrc" || true
                fi
                ;;
            */bash)
                print_info "Sourcing bash configuration..."
                if [ -f ~/.bashrc ]; then
                    source ~/.bashrc || true
                fi
                ;;
        esac
    fi

    # Setup Homebrew environment
    if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
}

# Main installation flow
main() {
    print_info "=== Dotfile Installation Script ==="
    print_info "This will install:"
    print_info "  - Nix package manager"
    print_info "  - nix-darwin (system configuration)"
    print_info "  - home-manager (user packages & dotfiles)"
    print_info "  - All packages defined in flake.nix"
    echo ""

    read -p "Continue with installation? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warn "Installation cancelled."
        exit 0
    fi

    install_nix
    enable_flakes
    install_nix_darwin
    install_home_manager
    post_install

    print_info ""
    print_info "=== Installation Complete! ==="
    print_info ""
    print_info "To update your configuration:"
    print_info "  - System config: cd $DOTFILE_DIR/config/nix-darwin && make switch"
    print_info "  - Home config: cd $DOTFILE_DIR/config/nix-home-manager && make switch"
}

main "$@"
