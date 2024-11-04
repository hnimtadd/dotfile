{ pkgs, ...}:
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
    git
    neovim
    eza
    fd
    ripgrep
    kitty
    skhd
    obsidian
    mkalias
    spotify
    shortcat
    wezterm
  ];
    # environment.shells = with pkgs; [ bash zsh ];
    # environment.loginShell = pkgs.zsh ;

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
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
    brews = [ ];

    # `brew install --cask`
    casks = [
      "google-chrome"
    ];
  };
 services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    package = pkgs.yabai;
  };
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
};
}
