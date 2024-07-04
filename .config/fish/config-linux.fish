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


# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
