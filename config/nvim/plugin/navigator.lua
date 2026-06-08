vim.pack.add({ 'https://github.com/mrjones2014/smart-splits.nvim' })

local smart_splits = require("smart-splits")
smart_splits.setup({
    ignored_buftypes = { "nofile", "quickfix", "prompt" },
    default_amount = 3,
    at_edge = "wrap",
    float_win_behavior = "previous",
    move_cursor_same_row = true,
    cursor_follows_swapped_bufs = false,
    ignored_events = { "BufEnter", "WinEnter" },
    disable_multiplexer_nav_when_zoomed = true,
    log_level = "debug",
})


-- Nvim-tmux navigation enabled
require("which-key").add({
    {
        mode = { "n" },
        { "<C-h>", smart_splits.move_cursor_left,  desc = "move cursor left",  noremap = true, silent = true },
        { "<C-j>", smart_splits.move_cursor_down,  desc = "move cursor down",  noremap = true, silent = true },
        { "<C-k>", smart_splits.move_cursor_up,    desc = "move cursor up",    noremap = true, silent = true },
        { "<C-l>", smart_splits.move_cursor_right, desc = "move cursor right", noremap = true, silent = true },
    },
})
