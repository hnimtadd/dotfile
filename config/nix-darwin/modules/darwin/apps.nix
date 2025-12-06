{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    mkalias
  ];
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    taps = [
      "nikitabobko/tap"
      "FelixKratz/formulae"
      # Custom tag used inside Grab
      {
        name = "gandalf/homebrew";
        clone_target = "git@gitlab.myteksi.net:gandalf/homebrew.git";
      }
    ];

    # `brew install`
    brews = [
      "antidote"
      "aspell"
      "autoconf"
      "borders"
      "clang-format"
      "cmake"
      "coreutils"
      "displayplacer"
      "docker-buildx"
      "git-crypt"
      "libtool"
      "ninja"
      "slides"
      "socat"
      "test-cli"
      "tlrc"
      "watch"
    ];

    # `brew install --cask`
    casks = [
    "alacritty"
      "aerospace"
      "aldente"
      "firefox"
      "homerow"
      "jordanbaird-ice"
      "karabiner-elements"
      "middleclick"
      "obsidian"
      "raycast"
      "stats"
      "evkey"
        "zen"
      "wezterm"
    ];
  };
  programs.zsh.enable = true;
}
