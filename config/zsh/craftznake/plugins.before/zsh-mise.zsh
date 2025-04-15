if type "mise" >/dev/null 2>&1; then
    # Only source this one in the first level shell in the terminal
    if [[ $SHLVL -eq 1  ]]; then
        # Your mise configuration here
        eval "$(mise activate zsh)"
    fi
fi
