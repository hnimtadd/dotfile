import plugins.before/zsh-eza.zsh
import plugins.before/zsh-vim-mode.zsh

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-vim-mode
    zsh-abbr
    z
    zsh-eza
)

source $ZSH/oh-my-zsh.sh

import plugins.after/pure.zsh
