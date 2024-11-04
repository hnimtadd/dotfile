{pkgs,...}:
let
  customZshPlugins = [
    # List of plugins you want to install
    pkgs.zsh-syntax-highlighting
    pkgs.zsh-autosuggestions
  ];
in
{
    programs.git.enable = true;
    programs.zsh = {
        enable = true;
        oh-my-zsh= {
            enable = true;
            package = pkgs.oh-my-zsh;
            plugins = [
                "git"
                "zsh-autosuggestions"
            ];
            theme = "robbyrussell";
        };
        shellAliases= {
            nix_deploy = "darwin-rebuild switch --impure --flake ~/dotfile/.config/nix-darwin#pro";
        };
        # initExtra = ''
        # # Source your custom configuration file
        # source ~/.config/zsh/index.zsh
        # '';
    };
}
