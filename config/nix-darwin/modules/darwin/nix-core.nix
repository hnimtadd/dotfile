{ pkgs, ... }:
{
  nix.settings = {
    # enable flakes globally
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Auto upgrade nix package and the daemon service.
  nix.package = pkgs.nix;
}
