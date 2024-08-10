return {
  "mbbill/undotree",
  dependencies = {
    "folke/which-key.nvim",
  },
  config = function()
    local wk = require("which-key")
    wk.add({
      {
        mode = { "n" },
        { "<leader>tu", vim.cmd.UndotreeToggle, desc = "[U]ndo Tree", noremap = true, silent = true },
      },
    })
  end,
}
