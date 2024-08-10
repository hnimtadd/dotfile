return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "s1n7ax/nvim-window-picker",
  },
  keys = function()
    return {
      { "<leader>e", "<Cmd>Neotree toggle<Cr>", desc = "Toggle file" },
    }
  end,
  opts = function(_, opts)
    return vim.tbl_extend("force", opts, {
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
  end,
}
