# Claude Code Overlay

This directory contains the overlay for the `claude-code` package.

## Files

- `default.nix` - The main overlay definition
- `package-lock.json` - NPM dependencies lock file
- `update.sh` - Update script using nix-update
- `README.md` - This documentation

## Usage

### Update to latest version
```bash
make update-claude-code
```

### Manual update
```bash
./overlays/claude-code/update.sh
```

## How it works

1. The overlay builds `claude-code` from the npm package
2. Uses `package-lock.json` for reproducible npm dependencies
3. The update script uses `nix-update` to automatically update version and hashes
4. Disables auto-updater to prevent conflicts with Nix package management

## Requirements

The update script requires:
- `nodePackages.npm` - For npm operations
- `nix-update` - For automatic hash generation and file updates

These are provided by the nix-shell shebang in the update script.
