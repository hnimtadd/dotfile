alias gl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"
alias gdh="git diff HEAD"
alias rg="grep rg"

if [[ -d "$HOME/.cfg" ]];then
    alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
fi
