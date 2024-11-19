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
    ];

    # `brew install`
    brews = [
    ];

    # `brew install --cask`
    casks = [
      "brave-browser"
      "jordanbaird-ice"
      "raycast"
      "stats"
      "aldente"
      "middleclick"
      "spaceid"
      "karabiner-elements"
      "homerow"
    ];
  };
  services = {
    yabai = {
      enable = true;
      enableScriptingAddition = true;
      package = pkgs.yabai;
      extraConfig = ''
        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
        sudo yabai --load-sa
      '';
    };
    skhd = {
      enable = true;
      package = pkgs.skhd;
    };
  };
  programs.zsh.enable = true;
}
