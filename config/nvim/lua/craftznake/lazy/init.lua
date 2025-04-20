return {
  {
    "LazyVim/LazyVim",
    version = false,
    import = "lazyvim.plugins",
    opts = {
      defaults = { keymaps = false },
      news = { lazyvim = false, neovim = false },
    },
  },
  { "folke/lazy.nvim", version = false },
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.lang.go" },
}
