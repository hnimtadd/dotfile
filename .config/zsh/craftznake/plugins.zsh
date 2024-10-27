import plugins.before/zsh-eza.zsh
import plugins.before/zsh-vi-mode.zsh

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-abbr
    zsh-vi-mode
    z
    zsh-eza
)

source $ZSH/oh-my-zsh.sh

import plugins.after/pure.zsh
import plugins.after/zsh-vi-mode-abbr.zsh

if [[ -d "$ZSH_CUSTOM/plugins/nvm" ]]; then
    source  "$ZSH_CUSTOM/plugins/nvm/nvm.sh"
fi
