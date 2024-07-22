-- Desc: Codeium (code suggestion) setup
return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "folke/which-key.nvim",
  },
  config = function()
    require("codeium").setup({
      enable_chat = true,
    })
    local wk = require("which-key")

    wk.add({
      {
        mode = { "n" },
        { "<leader>vc", group = "[C]hat" },
        { "<leader>vcc", "<cmd>Codeium Chat<CR>", { desc = "[C]odeium", silent = true } },
        {
          "<leader>tc",
          "<cmd>Codeium Disable<CR>",
          desc = "[C]hat AI",
          silent = true,
        },
      },
    })
  end,
}
