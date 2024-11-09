{ pkgs, username, home, ... }:
let
    dotconfigs = "/Users/${username}/dotfile";
    ohMyZshFolder = "/Users/${username}/.oh-my-zsh";
    ohMyZsh = pkgs.fetchFromGitHub {
        owner = "ohmyzsh";
        repo = "ohmyzsh";
        rev = "master";
        sha256 = "0r7577ilzqb1d4z2ng6gz7w5n1kzc8grv0wajf8lizmcdff9dnxd";
    };
    pluginFolder = "${ohMyZshFolder}/custom/plugins";
    zshPlugins = {
        zsh-autosuggestions = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
        zsh-syntax-highlighting = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.8.0";
            sha256 = "1yl8zdip1z9inp280sfa5byjbf2vqh2iazsycar987khjsi5d5w8";
        };
        zsh-z = pkgs.fetchFromGitHub {
            owner = "agkozak";
            repo = "zsh-z";
            rev = "master";
            sha256 = "1s23azd9hk57dgya0xrqh16jq1qbmm0n70x32mxg8b29ynks6w8n";
        };
        zsh-abbr = pkgs.fetchFromGitHub {
            owner = "olets";
            repo = "zsh-abbr";
            rev = "v5.8.3";
            sha256 = "1ds6n3r03s7gh3lrmzxymxszrkbny3l61xbi2x9wy3mqai5pqpra";
        };
        zsh-vi-mode = pkgs.fetchFromGitHub {
            owner = "jeffreytse";
            repo = "zsh-vi-mode";
            rev = "v0.11.0";
            sha256 = "0bs5p6p5846hcgf3rb234yzq87rfjs18gfha9w0y0nf5jif23dy5";
        };
        zsh-eza = pkgs.fetchFromGitHub {
            owner = "z-shell";
            repo = "zsh-eza";
            rev = "master";
            sha256 = "0xn25dpzy8aw497fpsywlcvb1mym4g86823z11qj5zhj3790l9sk";
        };
    };
in
{
    home = {
        packages = with pkgs; [
            go
            git
            starship
            eza
            fd
            ripgrep
        ];
            username = "${username}";
            homeDirectory = "/Users/${username}";
            stateVersion = "24.05";
    };

    # TODO: setup eza with this
    programs.home-manager.enable = true;
    programs.zsh = {
        enable = true;
        sessionVariables = {
            EDITOR= "nvim";
            CLICOLOR= 1;
            ZSH_PLUGINS_FOLDER = pluginFolder;
            ZSH=ohMyZshFolder;
            ZSH_CUSTOM="${ohMyZshFolder}/custom";
        };
        initExtra = ''
            source ~/.config/zsh/index.zsh
        '';
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
    home.file = {
        "alacritty" = {
            source = "${dotconfigs}/.config/alacritty";
            target = ".config/alacritty";
            recursive = true;
        };
        "eza" = {
            source = "${dotconfigs}/.config/eza";
            target = ".config/eza";
            recursive = true;
        };
        "fish" = {
            source = "${dotconfigs}/.config/fish";
            target = ".config/fish";
            recursive = true;
        };
        "karabiner" = {
            source = "${dotconfigs}/.config/karabiner";
            target = ".config/karabiner";
            recursive = true;
        };
        "kitty" = {
            source = "${dotconfigs}/.config/kitty";
            target = ".config/kitty";
            recursive = true;
        };
        "nvim" = {
            source = "${dotconfigs}/.config/nvim";
            target = ".config/nvim";
            recursive = true;
        };
        "skhd" = {
            source = "${dotconfigs}/.config/skhd";
            target = ".config/skhd";
            recursive = true;
        };
        "tmux" = {
            source = "${dotconfigs}/.config/tmux";
            target = ".config/tmux";
            recursive = true;
        };
        "wezterm" = {
            source = "${dotconfigs}/.config/wezterm";
            target = ".config/wezterm";
            recursive = true;
        };
        "yabai" = {
            source = "${dotconfigs}/.config/yabai";
            target = ".config/yabai";
            recursive = true;
        };
        "zsh" = {
            source = "${dotconfigs}/.config/zsh";
            target = ".config/zsh";
            recursive = true;
        };
        "starship" = {
            source = "${dotconfigs}/.config/starship.toml";
            target = ".config/starship.toml";
            recursive = true;
        };
        "scripts" = {
            source = "${dotconfigs}/.scripts";
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
        "zsh-z" = {
            source = zshPlugins.zsh-z;
            target = "${pluginFolder}/zsh-z";
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
