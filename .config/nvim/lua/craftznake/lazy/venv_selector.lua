return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "folke/which-key.nvim",
  },
  event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  branch = "regexp",
  config = function()
    require("venv-selector").setup({})

    local wk = require("which-key")
    wk.add({
      {
        mode = { "n" },
        {
          "<leader>ve",
          group = "[E]nvironment",
        },
        {
          "<leader>vep",
          "<cmd>VenvSelect<cr>",
          desc = "[P]ython",
          noremap = true,
          silent = true,
        },
      },
    })
  end,
}
