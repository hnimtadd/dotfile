---@diagnostic disable: missing-fields
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      ---@type snacks.Config
      require("snacks").setup({
        ---@class snacks.dashboard.Config
        dashboard = {
          enabled = true,
          width = 60,
          row = nil, -- dashboard position. nil for center
          col = nil, -- dashboard position. nil for center
          pane_gap = 4, -- empty columns between vertical panes
          preset = {
            header = [[

           ██╗  ██╗███╗   ██╗██╗███╗   ███╗████████╗ █████╗ ██████╗ ██████╗
           ██║  ██║████╗  ██║██║████╗ ████║╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
           ███████║██╔██╗ ██║██║██╔████╔██║   ██║   ███████║██║  ██║██║  ██║
           ██╔══██║██║╚██╗██║██║██║╚██╔╝██║   ██║   ██╔══██║██║  ██║██║  ██║
           ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║   ██║   ██║  ██║██████╔╝██████╔╝
           ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═════╝
            ]],
          },
          formats = {
            footer = { "%s", align = "center" },
            header = { "%s", align = "center" },
          },
          sections = {
            { section = "header" },
            { section = "startup" },
            {
              section = "terminal",
              cmd = "krabby random --no-title; sleep .1",
              random = 10,
              pane = 2,
              indent = 4,
              height = 30,
            },
          },
        },
        bigfile = { enabled = false },
        notifier = { enabled = true, timeout = 3000 },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        ---@diagnostic disable-next-line: missing-fields
        words = { enabled = true },
        styles = {
          ---@diagnostic disable-next-line: missing-fields
          notification = {
            ---@diagnostic disable-next-line: missing-fields
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
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          require("snacks").win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
  },
}
