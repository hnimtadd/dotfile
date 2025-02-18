return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "folke/which-key.nvim",
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
      enable_git_status = false,
      enable_diagnostics = false,
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
          ["Y"] = function(state)
            -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
            -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local results = {
              filepath,
              modify(filepath, ":."),
              modify(filepath, ":~"),
              filename,
              modify(filename, ":r"),
              modify(filename, ":e"),
            }

            vim.ui.select({
              "1. Absolute path: " .. results[1],
              "2. Path relative to CWD: " .. results[2],
              "3. Path relative to HOME: " .. results[3],
              "4. Filename: " .. results[4],
              "5. Filename without extension: " .. results[5],
              "6. Extension of the filename: " .. results[6],
            }, { prompt = "Choose to copy to clipboard:" }, function(choice)
              local i = tonumber(choice:sub(1, 1))
              local result = results[i]
              vim.fn.setreg('"', result)
              vim.notify("Copied: " .. result)
            end)
          end,
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["P"] = function(state)
            local node = state.tree:get_node()
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end,
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
    local wk = require("which-key")
    wk.add({
      {
        mode = { "n" },
        {
          "<leader>e",
          "<Cmd>Neotree toggle reveal=false<CR>",
          desc = "Open neo-tree",
          noremap = true,
          silent = true,
        },
        {
          "<leader>E",
          "<Cmd>Neotree toggle reveal=true<CR>",
          desc = "Open neo-tree at current file or working directory",
          noremap = true,
          silent = true,
        },
      },
    })
  end,
}
