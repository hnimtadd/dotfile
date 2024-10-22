# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"


# You can also set it to another string to have that shown instead of the default red dots.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
HIST_STAMPS="mm/dd/yyyy"

# zsh-abbr related stuffs
ABBR_USER_ABBREVIATIONS_FILE="$ZSH_ROOT/abbrs.zsh"
ABBR_SET_EXPANSION_CURSOR=1

# ZSH_AUTOSUGGEST config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#907aa9,bg=#2a273f,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

