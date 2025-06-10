{ pkgs, ... }:
##################################
#
# Homemanager managed packages
#
#################################
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    packages = with pkgs; [
      mise
      git
      starship
      eza
      fd
      ripgrep
      neovim
      lazygit
      bazel_7
      kubectl
      docker
      docker-compose
      terraform
      terraformer
      colima
      minikube
      wget
      bazelisk
      bazel-buildtools
      zoxide
      neofetch
      buf
      protobuf
      bat
      fzf
      tree
      ripgrep
      direnv
      awscli2
      ascii-image-converter
      krabby
      wdiff
      uutils-coreutils-noprefix
    ];
  };
}
