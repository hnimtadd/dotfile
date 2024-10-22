return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- Filter using buffer options
            bo = {
              -- If the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- If the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        })
      end,
    },
  },
  config = function()
    local neotree = require("neo-tree")
    neotree.setup({
      close_if_last_window = true,
      window = {
        mappings = {
          ["<space>"] = "none",
          ["<cr>"] = "open",
          ["<esc>"] = "cancel",
          ["|"] = "open_vsplit",
          ["-"] = "open_split",
          ["S"] = "none",
          ["s"] = "none",
          ["t"] = "open_tabnew",
          ["N"] = "add_directory",
          ["n"] = { "add", config = { show_path = "none" } },
          ["a"] = "none",
          ["A"] = "none",
          ["c"] = "none",
          ["m"] = "none",
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["i"] = "show_file_details",
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = false,
          leave_dirs_open = false,
        },
      },
    })
    vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle reveal=false<CR>", { desc = "Open neo-tree" })

    vim.keymap.set(
      "n",
      "<leader>E",
      "<Cmd>Neotree toggle reveal=true<CR>",
      { desc = "Open neo-tree at current file or working directory" }
    )
  end,
}
