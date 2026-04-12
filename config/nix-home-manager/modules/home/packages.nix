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
      golangci-lint
      rustup
      krabby
      kubectl
      lazygit
      minikube
      mise
      neovim
      nodejs_24
      protobuf
      python3
      ripgrep
      starship
      terraform
      terraformer
      tree
      uutils-coreutils-noprefix
      lua-language-server
      wdiff
      wget
        jujutsu
      write-good
      zoxide
      zsh-abbr
      zig
      gotools
      protoc-gen-go-grpc
      protoc-gen-go
      protobuf
    yq
    ];
  };
}
