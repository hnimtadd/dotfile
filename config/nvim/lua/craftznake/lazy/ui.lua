return {
  {
    "rcarriga/nvim-notify",
    opts = { timeout = 5000 },
  },
  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    config = function()
      require("mini.animate").setup({
        scroll = {
          enable = false,
        },
      })
    end,
  },

  {
    "s1n7ax/nvim-window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    -- show line the point from start of current scope to the end of scope
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        line_num = {
          enable = true,
          style = "#C39898",
        },
        chunk = {
          enable = true,
          priority = 15,
          style = {
            { fg = "#DBB5B5" }, -- Violet
            { fg = "#c21f30" }, -- Maple red
          },
          use_treesitter = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          textobject = "",
          max_file_size = 1024 * 1024,
          error_sign = true,
        },
      })
    end,
  },
}
