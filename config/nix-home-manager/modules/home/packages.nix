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
      amp-cli
      ascii-image-converter
      atuin
      awscli2
      bat
      bazel-buildtools
      bazel_7
      bazelisk
      buf
      claude-code
      colima
      direnv
      docker
      docker-compose
      eza
      fd
      fzf
      git
      go
        gopls
      krabby
      kubectl
      lazygit
      minikube
      mise
      neofetch
      neovim
      nodejs_24
      opencode
      protobuf
      python3
      ripgrep
      starship
      terraform
      terraformer
      tree
      uutils-coreutils-noprefix
      wdiff
      wget
      write-good
      zoxide
      zsh-abbr
        zig
    ];
  };
}
