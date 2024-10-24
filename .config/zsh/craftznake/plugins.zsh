import plugins.before/zsh-eza.zsh
import plugins.before/zsh-vi-mode.zsh

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-abbr
    zsh-vi-mode
    z
    zsh-eza
)

source $ZSH/oh-my-zsh.sh

import plugins.after/pure.zsh
import plugins.after/zshvimode-abbr.zsh
