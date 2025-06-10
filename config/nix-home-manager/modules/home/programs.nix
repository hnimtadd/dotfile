{ ... }:
#############################################################
#
#  Programs configuration
#
#############################################################
{
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
  };
}
