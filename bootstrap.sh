#!/usr/bin/env bash

set -e

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

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

# Configuration - UPDATE THESE VALUES
# You can override these by setting environment variables:
#   export DOTFILES_REPO_URL="git@github.com:youruser/dotfiles.git"
#   curl -fsSL https://raw.githubusercontent.com/youruser/dotfiles/main/bootstrap.sh | bash
REPO_URL="https://github.com/hnimtadd/dotfile.git" # Change this to your repo!
INSTALL_DIR="${DOTFILES_DIR:-$HOME/dotfile}"

main() {
    print_header "Dotfiles Bootstrap Script"

    echo ""
    print_info "This script will:"
    print_info "  1. Clone dotfiles repository to: $INSTALL_DIR"
    print_info "  2. Run the installation script"
    echo ""
    print_info "Repository: $REPO_URL"
    echo ""

    # Check if running on macOS
    if [[ "$(uname)" != "Darwin" ]]; then
        print_error "This script is designed for macOS only."
        exit 1
    fi

    # Check if directory already exists
    if [ -d "$INSTALL_DIR" ]; then
        print_warn "Directory $INSTALL_DIR already exists."
        read -p "Do you want to (u)pdate it, (r)emove and re-clone, or (a)bort? [u/r/a] " -n 1 -r
        echo
        case $REPLY in
            [Uu])
                print_info "Updating existing repository..."
                cd "$INSTALL_DIR"
                git pull origin main || git pull origin master || print_warn "Could not update. Proceeding anyway..."
                ;;
            [Rr])
                print_warn "Removing existing directory..."
                rm -rf "$INSTALL_DIR"
                clone_repo
                ;;
            *)
                print_info "Using existing directory..."
                ;;
        esac
    else
        clone_repo
    fi

    # Run the installation
    if [ -f "$INSTALL_DIR/install.sh" ]; then
        print_info "Running installation script..."
        cd "$INSTALL_DIR"
        chmod +x install.sh
        exec ./install.sh
    else
        print_error "install.sh not found in $INSTALL_DIR"
        print_error "Please check your repository structure."
        exit 1
    fi
}

clone_repo() {
    print_info "Cloning dotfiles repository..."

    # Try SSH first, fall back to HTTPS if it fails
    if ! git clone "$REPO_URL" "$INSTALL_DIR" 2>/dev/null; then
        print_error "Failed to clone repository."
        print_error "Please check:"
        print_error "  1. Repository URL is correct"
        print_error "  2. You have access to the repository"
        print_error "  3. Git is installed (run: xcode-select --install)"
        exit 1
    fi

    print_info "Repository cloned successfully!"
}

# Handle Ctrl+C gracefully
trap 'print_warn "Installation cancelled by user."; exit 130' INT

main "$@"
