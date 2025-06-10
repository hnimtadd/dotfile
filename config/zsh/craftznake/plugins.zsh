# Import custom configurations
import plugins.before/zsh-eza.zsh
import plugins.before/zsh-vi-mode.zsh
import plugins.before/zsh-mise.zsh
import plugins.before/zsh-abbr.zsh

# Initialize antidote
# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

fpath=($(brew --prefix)/opt/antidote/share/antidote/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source the static plugins file.
source ${zsh_plugins}.zsh

import plugins.after/zsh-fzf.zsh
import plugins.after/zsh-starship.zsh
import plugins.after/zsh-z.zsh
import plugins.after/wt.zsh
import plugins.after/p.zsh
import plugins.after/zsh-history-substring-search.zsh
