return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
  },
  event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  branch = "regexp",
  config = function()
    require("venv-selector").setup({})
    vim.keymap.set("n", "<leader>vpe", "<cmd>VenvSelect<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>vpc", "<cmd>VenvSelectCached<cr>", { noremap = true, silent = true })
  end,
}
