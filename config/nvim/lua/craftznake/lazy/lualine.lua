return {
  {
    "letieu/harpoon-lualine",
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- You can use a custom component extending builtin filename component to do this.
      local function location()
        return string.format("%3d:%-2d", unpack(vim.api.nvim_win_get_cursor(0)))
      end

      local themes = require("craftznake.lazy.consts.themes")

      require("lualine").setup({
        options = {
          icons_enabled = true,
          section_separators = "",
          component_separators = "",
          theme = themes.nil_theme,
          always_divide_middle = true,
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(mode)
                return mode:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            -- custom_fname,
            {
              "filename",
              file_status = true,
              path = 0,
              symbols = {
                modified = "+",
                readonly = "-",
                unnamed = "[No Name]",
              },
            },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = "E",
                warn = "W",
                info = "I",
                hint = "H",
              },
            },
          },
          lualine_x = {
            "encoding",
            "fileformat",
            "filetype",
          },
          lualine_y = {
            "progress",
          },
          lualine_z = { location },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { location },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
}
