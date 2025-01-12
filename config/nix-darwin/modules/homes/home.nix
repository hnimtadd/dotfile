{ pkgs, username, home, lib, config, ... }:
let
  dotconfigs = "/Users/${username}/dotfile";
  ohMyZshFolder = "/Users/${username}/.oh-my-zsh";
  ohMyZsh = pkgs.fetchFromGitHub {
    owner = "ohmyzsh";
    repo = "ohmyzsh";
    rev = "master";
    hash="sha256-NPFrqbyCet8CFxD2BM3DzU0ybUAWIGVJCXf0AKaJdgY=";
  };

  pluginFolder = "${ohMyZshFolder}/custom/plugins";
  zshPlugins = {
    zsh-autosuggestions = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-autosuggestions";
      rev = "v0.7.0";
    hash="sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
    };
    zsh-syntax-highlighting = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-syntax-highlighting";
      rev = "0.8.0";
      hash = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
    };
    zsh-abbr = pkgs.fetchFromGitHub {
      owner = "olets";
      repo = "zsh-abbr";
      rev = "v5.8.3";
      hash = "sha256-Kl98S1S4Ds9TF3H1YOjwds38da++/5rpgO/oAfKwRrc=";
    };
    zsh-vi-mode = pkgs.fetchFromGitHub {
      owner = "jeffreytse";
      repo = "zsh-vi-mode";
      rev = "v0.11.0";
      hash = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
    };
    zsh-eza = pkgs.fetchFromGitHub {
      owner = "z-shell";
      repo = "zsh-eza";
      rev = "master";
      hash = "sha256-UycK0hkS/iJxCH8IZNAj1dewNqPc6+tOIlwh/28rwnY=";
    };
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
      vscode
      docker
      docker-compose
      terraform
      colima
      minikube
      wget
      bazelisk
      bazel-buildtools
        zoxide
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
      ZSH_PLUGINS_FOLDER = pluginFolder;
      ZSH = ohMyZshFolder;
      ZSH_CUSTOM = "${ohMyZshFolder}/custom";
    };
    initExtra = ''
      source ~/.config/zsh/index.zsh
      if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
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
    "alacritty" = {
      source = "${dotconfigs}/config/alacritty";
      target = ".config/alacritty";
      recursive = true;
    };
    "eza" = {
      source = "${dotconfigs}/config/eza";
      target = ".config/eza";
      recursive = true;
    };
    "fish" = {
      source = "${dotconfigs}/config/fish";
      target = ".config/fish";
      recursive = true;
    };
    "karabiner" = {
      source = "${dotconfigs}/config/karabiner";
      target = ".config/karabiner";
      recursive = true;
    };
    "kitty" = {
      source = "${dotconfigs}/config/kitty";
      target = ".config/kitty";
      recursive = true;
    };
    "nvim" = {
      source = "${dotconfigs}/config/nvim";
      target = ".config/nvim";
      recursive = true;
    };
    # "skhd" = {
    #   source = "${dotconfigs}/config/skhd";
    #   target = ".config/skhd";
    #   recursive = true;
    # };
    "tmux" = {
      source = "${dotconfigs}/config/tmux";
      target = ".config/tmux";
      recursive = true;
    };
    "wezterm" = {
      source = "${dotconfigs}/config/wezterm";
      target = ".config/wezterm";
      recursive = true;
    };
    # "yabai" = {
    #   source = "${dotconfigs}/config/yabai";
    #   target = ".config/yabai";
    #   recursive = true;
    # };
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
    "zsh-autosuggestions" = {
      source = zshPlugins.zsh-autosuggestions;
      target = "${pluginFolder}/zsh-autosuggestions";
      recursive = true;
    };
    "zsh-syntax-highlighting" = {
      source = zshPlugins.zsh-syntax-highlighting;
      target = "${pluginFolder}/zsh-syntax-highlighting";
      recursive = true;
    };
    "zsh-abbr" = {
      source = zshPlugins.zsh-abbr;
      target = "${pluginFolder}/zsh-abbr";
      recursive = true;
    };
    "zsh-vi-mode" = {
      source = zshPlugins.zsh-vi-mode;
      target = "${pluginFolder}/zsh-vi-mode";
      recursive = true;
    };
    "zsh-eza" = {
      source = zshPlugins.zsh-eza;
      target = "${pluginFolder}/zsh-eza";
      recursive = true;
    };
    "oh-my-zsh" = {
      source = ohMyZsh;
      target = ohMyZshFolder;
      recursive = true;
    };
  };
}
