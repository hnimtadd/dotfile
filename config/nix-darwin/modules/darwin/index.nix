{ inputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./nix-core.nix
    ./host-users.nix
    ./system.nix
    ./apps.nix
    ./fonts.nix
  ];
}
