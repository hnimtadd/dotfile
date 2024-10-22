return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = function()
      return {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump({ search = { forward = true, wrap = false, multi_window = false } })
          end,
          desc = "Flash",
        },
        {
          "S",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump({
              search = { forward = false, wrap = false, multi_window = false },
            })
          end,
          desc = "Flash",
        },
        {
          "<leader>vy",
          mode = { "n", "x", "o" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash Treesitter",
        },
        {
          "<c-s>",
          mode = { "c" },
          function()
            require("flash").toggle()
          end,
          desc = "Toggle Flash Search",
        },
      }
    end,
  },
}
