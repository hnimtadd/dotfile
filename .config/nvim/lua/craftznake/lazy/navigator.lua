return {
  {
    "alexghergh/nvim-tmux-navigation",
    config = true,
    keys = {
      { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", desc = "Move left" },
      { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", desc = "Move down" },
      { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", desc = "Move up" },
      { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "Move right" },
    },
  },
}
