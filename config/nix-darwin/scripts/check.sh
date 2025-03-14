#!/usr/bin/env bash

# This script checks if nix is installed and if not, it installs it
check_and_install() {
    if ! command -v nix &>/dev/null; then
        echo "Nix could not be found, installing it"
        sh <(curl -L https://nixos.org/nix/install)
    else
        echo "Nix found, skipping this step"
    fi
}