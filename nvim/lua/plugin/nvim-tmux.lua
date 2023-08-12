require('nvim-tmux-navigation').setup {
  disable_when_zoomed = true, -- defaults to false
  keybindings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>",
    last_active = "<C-\\>",
    -- next = "<C-Space>",
  }
}
vim.keymap.set('n', '<C-U>', '<C-U>zz')
vim.keymap.set('n', '<C-D>', '<C-D>zz')
vim.keymap.set('n', '<C-h>', '<cmd>NvimTmuxNavigateLeft<CR>', { silent = false })
vim.keymap.set('n', '<C-j>', '<cmd>NvimTmuxNavigateDown<CR>', { silent = false })
vim.keymap.set('n', '<C-k>', '<cmd>NvimTmuxNavigateUp<CR>', { silent = false })
vim.keymap.set('n', '<C-l>', '<cmd>NvimTmuxNavigateRight<CR>', { silent = false })
