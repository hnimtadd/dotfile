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
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- globalstatus = false,
        theme = "solarized_dark",
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      -- disable buffer-related keymaps
      { "<leader>bp", false },
      { "<leader>br", false },
      { "<leader>bl", false },
      { "<leader>bb", false },

      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant"
        show_buffer_icons = false,
        show_close_icon = false,
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enable = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
  {
    "nvimdev/dashboard-nvim",

    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
        ██╗  ██╗███╗   ██╗██╗███╗   ███╗████████╗ █████╗ ██████╗ ██████╗ 
        ██║  ██║████╗  ██║██║████╗ ████║╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
        ███████║██╔██╗ ██║██║██╔████╔██║   ██║   ███████║██║  ██║██║  ██║
        ██╔══██║██║╚██╗██║██║██║╚██╔╝██║   ██║   ██╔══██║██║  ██║██║  ██║
        ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║   ██║   ██║  ██║██████╔╝██████╔╝
        ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═════╝ 
                                                                        
    ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
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
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
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
