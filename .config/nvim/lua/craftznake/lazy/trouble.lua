return {
  {
    "folke/trouble.nvim",
    dependencies = {
      "folke/which-key.nvim",
    },
    config = function()
      require("trouble").setup({})
      local wk = require("which-key")

      wk.add({
        {
          mode = { "n" },
          {
            "<leader>tt",
            function()
              require("trouble").toggle()
            end,
            desc = "[T]rouble",
          },
        },
      })

      vim.keymap.set("n", "[t", function()
        require("trouble").next({ skip_groups = true, jump = true }, {})
      end)

      vim.keymap.set("n", "]t", function()
        require("trouble").prev({ skip_groups = true, jump = true }, {})
      end)
    end,
  },
}
