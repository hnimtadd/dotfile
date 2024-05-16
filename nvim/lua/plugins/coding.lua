return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  { "echasnovski/mini.surround", enabled = false },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        go = { "goimports_reviser", "gofumpt" },
      })
    end,
  },
}
