return {
  "akinsho/toggleterm.nvim",
  version = "*",
  dependencies = {
    "folke/which-key.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local highlights = require("rose-pine.plugins.toggleterm")
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,

      open_mapping = [[<c-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      autochdir = false,
      shade_terminals = false,
      shade_filetypes = {},
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,

      start_in_insert = true,
      insert_mappings = true,
      direction = "horizontal",
      persist_size = true,
      highlights = highlights,
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      winbar = {
        enabled = true,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end,
      },
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    local wk = require("which-key")
    wk.add({
      {
        mode = { "n" },
        { "<leader>vt", group = "[T]erminal" },
        { "<leader>vts", ":TermSelect<CR>", desc = "Terminal [S]elect" },
        { "<leader>\\", ":ToggleTerm direction=float<CR>", desc = "Toggle Terminal Float" },
        {
          "<leader>g",
          function()
            lazygit:toggle()
          end,
          desc = "LazyGit",
        },
      },
    })
  end,
}
