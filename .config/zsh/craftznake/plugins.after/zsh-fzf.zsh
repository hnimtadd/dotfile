
if [[ -d "$ZSH_CUSTOM/plugins/fzf-zsh-plugin" ]];then
    source "$ZSH_CUSTOM/plugins/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh"
fi

if type fzf &> /dev/null; then
    source <(fzf --zsh)
fi


