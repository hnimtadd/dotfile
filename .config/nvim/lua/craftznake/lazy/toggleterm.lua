return {
  "akinsho/toggleterm.nvim",
  version = "*",
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
      shade_terminals = true,
      shade_filetypes = {},

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
    vim.keymap.set("n", "<leader>ts", ":TermSelect<CR>", { desc = "[T]erminal [S]elect" })
  end,
}
