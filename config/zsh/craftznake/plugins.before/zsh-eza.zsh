AUTOCD=1
_EZA_PARAMS=(
    '--group'
    '--group-directories-first'
    '--time-style=long-iso'
    '--color-scale=all'
    '--icons'
)
alias 'lg=eza --all --git --header --long $_EZA_PARAMS[@]'
export EZA_CONFIG_DIR=$HOME/.config/eza
