if type -q rg
    alias grep rg
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
