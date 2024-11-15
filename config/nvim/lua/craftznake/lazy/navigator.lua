return {
  "mrjones2014/smart-splits.nvim",
  dependencies = {
    "folke/which-key.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local smart_splits = require("smart-splits")
    smart_splits.setup({
      -- Ignored buffer types (only while resizing)
      ignored_buftypes = {
        "nofile",
        "quickfix",
        "prompt",
      },
      -- The default number of lines/columns to resize by at a time
      default_amount = 3,
      at_edge = "wrap",
      float_win_behavior = "previous",
      move_cursor_same_row = true,
      cursor_follows_swapped_bufs = false,
      ignored_events = {
        "BufEnter",
        "WinEnter",
      },
      disable_multiplexer_nav_when_zoomed = true,
      log_level = "debug",
    })

    local wk = require("which-key")
    wk.add({
      {
        mode = { "n" },
        { "<C-h>", smart_splits.move_cursor_left, desc = "move cursor left", noremap = true, silent = true },
        { "<C-j>", smart_splits.move_cursor_down, desc = "move cursor down", noremap = true, silent = true },
        { "<C-k>", smart_splits.move_cursor_up, desc = "move cursor up", noremap = true, silent = true },
        { "<C-l>", smart_splits.move_cursor_right, desc = "move cursor right", noremap = true, silent = true },
        { "<C-H>", smart_splits.resize_left, desc = "move cursor left", noremap = true, silent = true },
        { "<C-J>", smart_splits.resize_down, desc = "move cursor down", noremap = true, silent = true },
        { "<C-K>", smart_splits.resize_up, desc = "move cursor up", noremap = true, silent = true },
        { "<C-L>", smart_splits.resize_right, desc = "move cursor right", noremap = true, silent = true },
      },
    })
  end,
}
