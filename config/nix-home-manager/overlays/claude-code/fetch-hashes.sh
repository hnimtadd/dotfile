#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nodePackages.npm

set -euo pipefail

echo "Fetching latest claude-code hashes..."

# Get the latest version from npm
version=$(npm view @anthropic-ai/claude-code version)
echo "Latest version: $version"

# Generate package-lock.json for the latest version
cd "$(dirname "${BASH_SOURCE[0]}")"
npm i --package-lock-only @anthropic-ai/claude-code@"$version"
rm -f package.json

# Generate source hash
echo "Generating source hash..."
src_hash=$(nix-prefetch-url --type sha256 "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-$version.tgz")
echo "Source hash: $src_hash"

# Generate npm deps hash
echo "Generating npm deps hash..."
npm_deps_hash=$(nix-prefetch-url file://$PWD/package-lock.json)
echo "NPM deps hash: $npm_deps_hash"

# Convert to SRI format
src_hash_sri=$(nix hash convert --to sri --hash-algo sha256 "$src_hash")
npm_deps_hash_sri=$(nix hash convert --to sri --hash-algo sha256 "$npm_deps_hash")

echo ""
echo "=== UPDATE VALUES ==="
echo "version = \"$version\";"
echo "srcHash = \"$src_hash_sri\";"
echo "depsHash = \"$npm_deps_hash_sri\";"
echo "===================="
echo ""
echo "Copy these lines to replace the corresponding variables in overlays/claude-code/default.nix"
