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
        routes = {
          {
            filter = {
              event = "notify",
              find = "No information available",
            },
            opts = { skip = true },
          },
          -- hide write messae
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "%d+L, %d+B" },
                { find = "; after #%d+" },
                { find = "; before #%d+" },
                { find = "%d fewer lines" },
                { find = "%d more lines" },
              },
            },
            view = "mini",
          },
        },
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
    config = function()
      require("mini.animate").setup({
        scroll = {
          enable = false,
        },
      })
    end,
  },

  {
    "s1n7ax/nvim-window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
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
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    -- opts = {
    --   indent = {
    --     char = "│",
    --     tab_char = "│",
    --   },
    -- },
  },
  -- indent line
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        line_num = {
          enable = true,
          style = "#C39898",
        },
        chunk = {
          enable = true,
          priority = 15,
          style = {
            { fg = "#DBB5B5" }, -- Violet
            { fg = "#c21f30" }, -- Maple red
          },
          use_treesitter = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          textobject = "",
          max_file_size = 1024 * 1024,
          error_sign = true,
        },
      })
    end,
  },
}
