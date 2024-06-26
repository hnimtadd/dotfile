return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<c-b>", false },
      { "<c-f>", false },
      { "<leader>sna", false },
      { "<leader>snd", false },
      { "<leader>snh", false },
      { "<S-Enter>" },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      require("noice").setup({

        all = {
          -- options for the message history that you get with ":Noice"
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        presets = {
          -- you can enable a preset by setting it to true, or a table that will override the preset config
          -- you can also add custom presets that you can enable/disable with enabled=true
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
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
