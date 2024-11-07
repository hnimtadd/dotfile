import plugins.before/zsh-eza.zsh
import plugins.before/zsh-vi-mode.zsh
import plugins.before/gvm.zsh

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-abbr
    zsh-vi-mode
    zsh-z
    zsh-exa
)


if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    source  "$ZSH/oh-my-zsh.sh"
fi

import plugins.after/zshvimode-abbr.zsh
import plugins.after/zsh-fzf.zsh
import plugins.after/zsh-starship.zsh

