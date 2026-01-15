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
      supportedSystems = [ "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
      username = builtins.getEnv "USER";
      hostname = builtins.getEnv "HOST";
    in
    {
      formatter = forAllSystems (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );
      darwinConfigurations =
        if hostname != "" then {
          "${hostname}" = darwin.lib.darwinSystem {
            system = builtins.currentSystem;
            specialArgs = { inherit username hostname; };
            modules = [
              ./modules/darwin/index.nix
            ];
          };
        } else { };
    };
}
