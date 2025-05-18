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
      system = builtins.currentSystem;
      username = builtins.getEnv "USER";
      hostname = builtins.getEnv "HOST";
      specialArgs = {
        inherit username hostname;
      };
    in
    {
      darwinConfigurations = {
        "${hostname}" = darwin.lib.darwinSystem {
          inherit system specialArgs;
          modules = [
            ./modules/darwin/index.nix
          ];
        };
      };
      formatter."${system}" = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    };
}
