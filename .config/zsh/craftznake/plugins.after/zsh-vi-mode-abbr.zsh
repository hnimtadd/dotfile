# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  emulate -LR zsh
  bindkey " " abbr-expand-and-insert
  bindkey "^ " magic-space
  bindkey -M isearch "^ " abbr-expand-and-insert
  bindkey -M isearch " " magic-space
}
