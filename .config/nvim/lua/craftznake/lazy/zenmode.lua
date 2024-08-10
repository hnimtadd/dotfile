return {
  "folke/zen-mode.nvim",
  dependencies = {
    "b0o/incline.nvim",
  },
  config = function()
    require("zen-mode").setup({
      on_open = function()
        require("incline").disable()
      end,
      on_close = function()
        require("incline").enable()
      end,
    })

    vim.keymap.set("n", "<leader>zz", function()
      require("zen-mode").toggle({
        window = {
          width = 150,
          option = {},
        },
      })
      vim.wo.wrap = false
      vim.wo.number = true
      vim.wo.rnu = true
      ColorMyPencils()
    end)

    vim.keymap.set("n", "<leader>zZ", function()
      require("zen-mode").toggle({
        window = {
          width = 140,
          options = {},
        },
      })
      vim.wo.wrap = false
      vim.wo.number = false
      vim.wo.rnu = false
      vim.opt.colorcolumn = "0"
      ColorMyPencils()
    end)
  end,
}
