return {
  { "folke/lazy.nvim", version = false },
  {
    "LazyVim/LazyVim",
    version = false,
    import = "lazyvim.plugins",
    opts = {
      defaults = {
        keymaps = false,
      },
    },
  },

  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  -- { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
}
