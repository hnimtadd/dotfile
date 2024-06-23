return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    keys = {
      { "<c-b>", false },
      { "<c-f>", false },
      { "<leader>sna", false },
      { "<leader>snd", false },
      { "<leader>snh", false },
      { "<S-Enter>" },
    },
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })

      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })

      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = true
        end,
      })

      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.comands = {
        all = {
          -- options for the message history that you get with ":Noice"
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = { timeout = 5000 },
  },
  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
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
            ["|"] = "open_split",
            ["-"] = "open_vsplit",
            ["S"] = "none",
            ["t"] = "open_tabnew",
            ["c"] = { "add", config = { show_path = "none" } },
            ["a"] = "none",
            ["C"] = "add_directory",
            ["A"] = "none",
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
      })
    end,
  },
}
