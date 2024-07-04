-- Desc: Codeium (code suggestion) setup
return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      enable_chat = true,
    })

    vim.keymap.set(
      "n",
      "<leader>vcc",
      "<cmd>Codeium Chat<CR>",
      { desc = "[V]iew [C]hat with [C]odeium", silent = true }
    )

    vim.keymap.set("n", "<leader>ud", "<cmd>Codeium Disable<CR>", { desc = "[U]ndisable [A]I", silent = true })
  end,
}
