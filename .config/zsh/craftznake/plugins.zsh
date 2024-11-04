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
)
source $ZSH/oh-my-zsh.sh

import plugins.after/pure.zsh
import plugins.after/zshvimode-abbr.zsh
import plugins.after/zsheza.zsh
import plugins.after/zsh-fzf.zsh
import plugins.after/zsh-vi-mode-abbr.zsh

if [[ -d "$ZSH_CUSTOM/plugins/nvm" ]]; then
    source  "$ZSH_CUSTOM/plugins/nvm/nvm.sh"
fi
