{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    obsidian
    mkalias
    wezterm
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
    ];

    # `brew install --cask`
    casks = [
      "brave-browser"
      "jordanbaird-ice"
      "raycast"
      "stats"
      "aldente"
      "middleclick"
      "karabiner-elements"
      "homerow"
      "keycastr"
      "aerospace"
    ];
  };
  services = {
    # Disable it for now since we don't use yabai
    # yabai = {
    #   enable = true;
    #   enableScriptingAddition = true;
    #   package = pkgs.yabai;
    #   extraConfig = ''
    #     yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
    #     sudo yabai --load-sa
    #   '';
    # };
    # skhd = {
    #   enable = true;
    #   package = pkgs.skhd;
    # };
  };
  programs.zsh.enable = true;
}
