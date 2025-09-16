#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nodePackages.npm prefetch-npm-deps

set -euo pipefail

echo "Fetching latest claude-code hashes..."

# Get the latest version from npm
version=$(npm view opencode-ai version)
echo "Latest version: $version"

# Generate package-lock.json for the latest version
cd "$(dirname "${BASH_SOURCE[0]}")"
npm i --package-lock-only opencode-ai@"$version"
rm -f package.json

echo "Generating hashes..."

echo "Getting source hash from npm tarball (unpacked)..."
src_hash=$(nix-prefetch-url --unpack "https://registry.npmjs.org/opencode-ai/-/opencode-ai-$version.tgz")
# Convert source hash to SRI format
src_hash_sri=$(nix hash convert --to sri --hash-algo sha256 "$src_hash")

echo "Getting npm deps hash using prefetch-npm-deps..."
cd -
npm_deps_hash=$(prefetch-npm-deps overlays/opencode/package-lock.json)

echo ""
echo "==== UPDATE VALUES ===="
echo "version = \"$version\";"
echo "srcHash = \"$src_hash_sri\";"
echo "depsHash = \"$npm_deps_hash\";"
echo "======================="
echo ""
echo "Copy these lines to replace the corresponding variables in overlays/opencode/default.nix"
