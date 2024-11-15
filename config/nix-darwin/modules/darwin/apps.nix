{ pkgs, ... }:
# let
#     yabai = pkgs.yabai.overrideAttrs (old: rec {
#       src = pkgs.fetchFromGitHub {
#         owner = "donaldguy";
#         repo = "yabai";
#         rev = "723f2ee0346b78360c497b7a7eb7be409c02302c";
#         sha256 = "sha256:1z95njalhvyfs2xx6d91p9b013pc4ad846drhw0k5gipvl03pp92";
#       };
#     });
# in
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
    ];
  };
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    package = pkgs.yabai;
    extraConfig = ''
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      sudo yabai --load-sa
    '';
  };
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
  };
  programs.zsh.enable = true;
}
