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
      "displayplacer"
      "coreutils"
      "libtool"
      "cmake"
      "ninja"
      "clang-format"
      "autoconf"
      "aspell"
      "openjdk@11"
      "tlrc"
      "borders"
      "git-crypt"
      "slides"
      "docker-buildx"
      "test-cli"
      "displayplacer"
      "watch"
      "socat"
      "terminal-notifier"
      "antidote"
    ];

    # `brew install --cask`
    casks = [
      "jordanbaird-ice"
      "raycast"
      "stats"
      "aldente"
      "middleclick"
      "karabiner-elements"
      "homerow"
      "keycastr"
      "wezterm"
      "obsidian"
      "aerospace"
      "firefox"
      "zen"
    ];
  };
  programs.zsh.enable = true;
}
