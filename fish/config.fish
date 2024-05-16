if status is-interactive || status is-login
    # set -x __fish_trace_fishscript
    set fish_greeting ""
    set -g theme_display_user yes
    set -g theme_hide_hostname no
    set -g theme_hostname always
    #
    #
    set -gx FISH_ROOT ~/.config/fish
    if test -e $FISH_ROOT/alias.fish
        source $FISH_ROOT/alias.fish
    end
    if test -e $FISH_ROOT/config-dev.fish
        source $FISH_ROOT/config-dev.fish
    end
    if test -e $FISH_ROOT/ui.fish
        source $FISH_ROOT/ui.fish
    end
    if test -e $FISH_ROOT/env.fish
        source $FISH_ROOT/env.fish
    end

    switch (uname)
        case Linux
            source $FISH_ROOT/config-linux.fish
        case Darwin
            source $FISH_ROOT/config-mac.fish
    end
    if test -d ~/.config/scripts
        set -gx PATH $PATH ~/.config/scripts
    end
    fish_vi_key_bindings
end
