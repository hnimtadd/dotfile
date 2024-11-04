{ pkgs, username, ... }:

{
  imports = [
    # You can also split up your configuration and import pieces of it here:
    ./dotfiles.nix
  ];

  home = {
        packages = with pkgs; [ go ];
        username = "${username}";
        homeDirectory = "/Users/${username}";
        stateVersion = "24.05";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
