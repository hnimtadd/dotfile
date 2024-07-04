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
abbr cp 'cp -i'
abbr rm 'rm -i'
abbr mkdir 'mkdir -p'
abbr which type

if test -d $HOME/.cfg
    alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
end
