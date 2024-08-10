if type -q rg
    alias grep rg
end
if type -q neovide
    abbr vide "neovide &"
end

if type -q neovide
    abbr vide "neovide &"
end

if type -q escrotum
    alias capture escrotum
end

if type -q xmodmap
    alias xm "sh ~/xmodmap.sh"
end

if type -q nvim
    alias delvs 'delete_swap_neovim;commandline -f repaint'
end

if type -q nvim
    command -q nvim && alias vim nvim
    set -gx EDITOR nvim
else if type -q vim
    set -gx EDITOR vim
end

if type -q tmux
    abbr tmux 'tmux -2'
end

abbr cp 'cp -i'
abbr rm 'rm -i'
abbr mkdir 'mkdir -p'
abbr which type

if test -d $HOME/.cfg
    alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
end

if type -q nvm
    set -gx nvm_default_version 'v20.10.0'
end

if type -q eza
    alias ls "eza -g --git --icons --group-directories-first"
    alias ll "eza -l  --icons --git --group-directories-first"
    alias lla "ll -a"
    alias gl "git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"
    alias g git
    alias gs "g status"
    alias gpom "git push origin main"
    function etree -d "View with hirenchy tree"
        if test (count $argv) = 2
            command eza --tree -l -g --git --icons --level=$argv[1] $argv[2]
        else
            command eza --tree -l -g --git --icons --level=$argv[1] .
        end
    end
end
