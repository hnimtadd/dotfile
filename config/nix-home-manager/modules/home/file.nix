{ pkgs, username, ... }:
################################
#
# User dotfile
#
################################
let
  dotconfigs = "/Users/${username}/dotfile";
  zinitFolder = "/Users/${username}/.local/state/zinit/zinit.git";
  zinit = pkgs.fetchFromGitHub {
    owner = "zdharma-continuum";
    repo = "zinit";
    rev = "v3.14.0";
    hash = "sha256-cBMGmFrveBes30aCSLMBO8WrtoPZeMNjcEQoQEzBNvM=";
  };
in
{
  programs.zsh = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
      CLICOLOR = 1;
    };
    initContent = ''
      # FROM https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#manual
      source "${zinitFolder}/zinit.zsh"
      autoload -Uz _zinit

      (( ''${+_comps} )) && _comps[zinit]=_zinit
      source ~/.config/zsh/index.zsh
      if [[ $(uname -m) == 'arm64' ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
      eval "$(direnv hook zsh)"
    '';
  };
  home.file = {
    "aerospace" = {
      source = "${dotconfigs}/config/aerospace";
      target = ".config/aerospace";
      recursive = true;
    };
    "eza" = {
      source = "${dotconfigs}/config/eza";
      target = ".config/eza";
      recursive = true;
    };
    "karabiner" = {
      source = "${dotconfigs}/config/karabiner";
      target = ".config/karabiner";
      recursive = true;
    };
    "nvim" = {
      source = "${dotconfigs}/config/nvim";
      target = ".config/nvim";
      recursive = true;
    };
    "wezterm" = {
      source = "${dotconfigs}/config/wezterm";
      target = ".config/wezterm";
      recursive = true;
    };
    "zsh" = {
      source = "${dotconfigs}/config/zsh";
      target = ".config/zsh";
      recursive = true;
    };
    "starship" = {
      source = "${dotconfigs}/config/starship.toml";
      target = ".config/starship.toml";
      recursive = true;
    };
    "scripts" = {
      source = "${dotconfigs}/scripts";
      target = ".scripts";
      recursive = true;
    };
    "zinit" = {
      source = zinit;
      target = zinitFolder;
      recursive = true;
    };
    # NOTE: not used stuffs
    # "kitty" = {
    #   source = "${dotconfigs}/config/kitty";
    #   target = ".config/kitty";
    #   recursive = true;
    # };
    # "skhd" = {
    #   source = "${dotconfigs}/config/skhd";
    #   target = ".config/skhd";
    #   recursive = true;
    # };
    # "yabai" = {
    #   source = "${dotconfigs}/config/yabai";
    #   target = ".config/yabai";
    #   recursive = true;
    # };
    # "tmux" = {
    #   source = "${dotconfigs}/config/tmux";
    #   target = ".config/tmux";
    #   recursive = true;
    # };
    # "alacritty" = {
    #   source = "${dotconfigs}/config/alacritty";
    #   target = ".config/alacritty";
    #   recursive = true;
    # };
    # "fish" = {
    #   source = "${dotconfigs}/config/fish";
    #   target = ".config/fish";
    #   recursive = true;
    # };
  };
}

