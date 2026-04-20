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
        difftastic
      git
      go
      golangci-lint
      gopls
      gotools
      jujutsu
      krabby
      kubectl
      lazygit
      lua-language-server
      minikube
      mise
      neovim
      nodejs_24
      protobuf
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
      python3
      ripgrep
      rustup
      starship
      terraform
      terraformer
      tmux
      tree
      tree-sitter
      uutils-coreutils-noprefix
      wdiff
      wget
      write-good
      yq
      zig
      zoxide
      zsh-abbr
    ];
  };
}
