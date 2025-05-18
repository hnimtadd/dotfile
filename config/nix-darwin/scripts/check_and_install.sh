#!/usr/bin/env bash

# This script checks if nix is installed and if not, it installs it
if ! command -v nix &>/dev/null; then
    echo "nix command could not be found, installing it"
    sh <(curl -L https://nixos.org/nix/install)
else
    echo "nix command found, skipping this step"
fi
