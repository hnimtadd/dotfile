# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
    emulate -LR zsh

    # spacebar expands abbreviations
    bindkey " " abbr-expand-and-insert

    # control-spacebar is a normal space
    bindkey "^[[32;1u" magic-space

    # when running an incremental search,
    # spacebar behaves normally and control-space expands abbreviations
    bindkey -M isearch "^ " abbr-expand-and-insert
    bindkey -M isearch " " magic-space
}
