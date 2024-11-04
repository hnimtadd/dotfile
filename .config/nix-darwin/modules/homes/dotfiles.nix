{pkgs, username,...}:
let
    dotconfigs = "/Users/${username}/dotfile";
in
{
    home.activation.pullDotconfigs = pkgs.lib.mkAfter ''
        if [ -d "${dotconfigs}" ]; then
        echo "Pulling latest .dotconfigs from the repository..."
        git -C "${dotconfigs}" pull origin main || echo "Failed to pull .dotconfigs"
        else
        echo ".dotconfigs folder does not exist at ${dotconfigs}. Please check the path."
        fi
    '';
    home.sessionVariables = {
        EDITOR= "nvim";
        CLICOLOR= 1;
    };
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
        # "nix-darwin" = {
        #     source = "${dotconfigs}/.config/nix-darwin";
        #     target = ".config/nix-darwin";
        #     recursive = true;
        # };
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
    };
}
