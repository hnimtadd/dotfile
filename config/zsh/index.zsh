# Path to your Oh My Zsh installation.
ZSH_ROOT="$HOME/.config/zsh/craftznake"

typeset -ga chpwd_functions precmd_functions preexec_functions
if [[ -f "$ZSH_ROOT/index.zsh" ]]; then
    source "$ZSH_ROOT/index.zsh"
fi
