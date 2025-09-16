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
      "homebrew/services"
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
      "displayplacer"
      "docker-buildx"
      "firefoxpwa"
      "git-crypt"
      "libtool"
      "ninja"
      "openjdk@11"
      "slides"
      "socat"
      "terminal-notifier"
      "test-cli"
      "tlrc"
      "watch"
    ];

    # `brew install --cask`
    casks = [
      "aerospace"
      "aldente"
      "firefox"
      "homerow"
      "jordanbaird-ice"
      "karabiner-elements"
      "keycastr"
      "middleclick"
      "obsidian"
      "raycast"
      "stats"
      "wezterm"
      "zen"
    ];
  };
  programs.zsh.enable = true;
}
