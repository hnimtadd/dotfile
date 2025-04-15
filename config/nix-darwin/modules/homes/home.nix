{ pkgs, username, home, lib, config, ... }:
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
  home = {
    packages = with pkgs; [
      mise
      git
      starship
      eza
      fd
      ripgrep
      neovim
      lazygit
      bazel_7
      neovide
      kubectl
      docker
      docker-compose
      terraform
      terraformer
      colima
      minikube
      wget
      bazelisk
      bazel-buildtools
      zoxide
      neofetch
      buf
      protobuf
      bat
      fzf
      tree
      ripgrep
      direnv
    ];
    username = "${username}";
    homeDirectory = "/Users/${username}";
    stateVersion = "24.05";
  };
  home.activation = {
    rsync-home-manager-applications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
      apps_source="$genProfilePath/home-path/Applications"
      moniker="Home Manager Trampolines"
      app_target_base="${config.home.homeDirectory}/Applications"
      app_target="$app_target_base/$moniker"
      mkdir -p "$app_target"
      ${pkgs.rsync}/bin/rsync $rsyncArgs "$apps_source/" "$app_target"
    '';
  };

  # TODO: setup eza with this
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
      CLICOLOR = 1;
      # ZSH_PLUGINS_FOLDER = pluginFolder;
      # ZSH = ohMyZshFolder;
      # ZSH_CUSTOM = "${ohMyZshFolder}/custom";
    };
    initExtra = ''
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
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
