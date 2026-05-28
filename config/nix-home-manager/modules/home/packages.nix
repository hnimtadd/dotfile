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
      (rust-bin.stable.latest.default.override {
        extensions = [ "rust-src" "rust-analyzer" "clippy" "rustfmt" "llvm-tools-preview" ];
      })
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
      curl
      websocat
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
