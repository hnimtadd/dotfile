if type -q starship
    starship init fish | source
end

if type -q bat
    alias cat bat
end

if type -q git
    alias gl "git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"
    alias g git
    alias gs "g status"
    alias gpom "git push origin main"
end

if type -q exa
    alias ls "exa -g --git --icons --group-directories-first"
    alias ll "exa -l  --icons --git --group-directories-first"
    alias lla "ll -a"
    function etree -d "View with hirenchy tree"
        if test (count $argv) = 2
            command exa --tree -l -g --git --icons --level=$argv[1] $argv[2]
        else
            command exa --tree -l -g --git --icons --level=$argv[1] .
        end
    end
end

if type -q tmux
    source (dirname (status --current-filename))/tmux.fish
end
