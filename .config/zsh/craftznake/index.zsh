if [[ -f "$ZSH_ROOT/utils.zsh" ]]; then
    source "$ZSH_ROOT/utils.zsh"
fi

if [[ -f "$ZSH_ROOT/options.zsh" ]]; then
    source "$ZSH_ROOT/options.zsh"
fi

if [[ -f "$ZSH_ROOT/plugins.zsh" ]]; then
    source "$ZSH_ROOT/plugins.zsh"
fi

if [[ -f "$ZSH_ROOT/alias.zsh" ]]; then
    source "$ZSH_ROOT/alias.zsh"
fi

if [[ -f "$ZSH_ROOT/themes.zsh" ]]; then
    source "$ZSH_ROOT/themes.zsh"
fi

if [[ -f "$ZSH_ROOT/envs.zsh" ]]; then
    source "$ZSH_ROOT/envs.zsh"
fi


