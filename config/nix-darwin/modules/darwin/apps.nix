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
    ];

    # `brew install`
    brews = [
      "antidote"
      "aspell"
      "autoconf"
      "clang-format"
      "cmake"
      "coreutils"
      "displayplacer"
      "docker-buildx"
      "git-crypt"
      "libtool"
      "ninja"
      "slides"
      "tlrc"
      "watch"
    "firefoxpwa"
    ];

    # `brew install --cask`
    casks = [
      "aerospace"
      "alacritty"
      "aldente"
      "evkey"
      "firefox"
      "homerow"
      "jordanbaird-ice"
      "karabiner-elements"
      "middleclick"
      "obsidian"
      "raycast"
      "stats"
      "cursor"
      "wezterm"
      "zed"
      "zen"
            "finicky"
    ];
  };
  programs.zsh.enable = true;
}
