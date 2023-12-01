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
    if type -q vim
        alias vim nvim
    end
end
