---@diagnostic disable: missing-fields
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("snacks").setup({
        dashboard = { enabled = false },
        bigfile = { enabled = false },
        notifier = { enabled = true, timeout = 3000 },
        quickfile = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
        styles = {
          notification = {
            wo = { wrap = true }, -- Wrap notifications
          },
        },
      })
    end,
    keys = {
      {
        "<leader>un",
        function()
          require("snacks").notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<leader>gg",
        function()
          require("snacks").lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gf",
        function()
          require("snacks").lazygit.log_file()
        end,
        desc = "Lazygit Current File History",
      },
    },
  },
}
