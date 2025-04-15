import plugins.before/zsh-eza.zsh
import plugins.before/zsh-vi-mode.zsh
import plugins.before/zsh-mise.zsh

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit light z-shell/zsh-eza
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light olets/zsh-abbr

import plugins.after/zshvimode-abbr.zsh
import plugins.after/zsh-fzf.zsh
import plugins.after/zsh-starship.zsh
import plugins.after/zsh-z.zsh
import plugins.after/wt.zsh
import plugins.after/p.zsh
