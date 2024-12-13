{
  description = "My zen nix configuration";

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs =
    inputs @ { self
    , nixpkgs
    , darwin
    , home-manager
    , ...
    }:
    let
      # TODO replace with your own username, system and hostname
      username = if builtins.getEnv "USER" != "" then builtins.getEnv "USER" else "hnimtadd";

      system = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
      hostname = "pro";

      specialArgs =
        inputs
        // {
          inherit username hostname;
        };
    in
    {
      darwinConfigurations = {
        "${hostname}" = darwin.lib.darwinSystem {
          inherit system specialArgs;
          modules = [
            ./modules/darwin/index.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                backupFileExtension = "backup";
                useGlobalPkgs = true;
                # useUserPackages = true;
                extraSpecialArgs = specialArgs;
                users = {
                  "${username}" = import ./modules/homes/home.nix;
                };
              };
            }
          ];
        };
      };
      formatter."${system}" = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    };
}
