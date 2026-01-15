{
  description = "My macOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-registry = {
      url = "github:nixos/flake-registry";
      flake = false;
    };
  };

  outputs = { nixpkgs, darwin, ... }:
    let
        # Determine system architecture
        # On Apple Silicon this is "aarch64-darwin", on Intel "x86_64-darwin"
          system = if builtins.pathExists "/usr/bin/arch" then
                 (if builtins.match ".*arm64.*" (builtins.readFile (builtins.toPath "/dev/null")) != null
                 then "aarch64-darwin" else "x86_64-darwin")
               else "unknown";
      username = builtins.getEnv "USER";
      hostname = builtins.getEnv "HOST";
      specialArgs = {
        inherit username hostname;
      };
    in
    {
      formatter."${system}" = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
      darwinConfigurations = {
        "${hostname}" = darwin.lib.darwinSystem {
          inherit system specialArgs;
          modules = [
            ./modules/darwin/index.nix
          ];
        };
      };
    };
}
