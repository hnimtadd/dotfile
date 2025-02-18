return {
  {
    "letieu/harpoon-lualine",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- You can use a custom component extending builtin filename component to do this.

      local custom_fname = require("lualine.components.filename"):extend()
      local highlight = require("lualine.highlight")
      local default_status_colors = { saved = "#228B22", modified = "#C70039" }

      function custom_fname:init(options)
        custom_fname.super.init(self, options)
        self.status_colors = {
          saved = highlight.create_component_highlight_group({}, "filename_status_saved", self.options),
          modified = highlight.create_component_highlight_group(
            { fg = default_status_colors.modified },
            "filename_status_modified",
            self.options
          ),
        }
        if self.options.color == nil then
          self.options.color = ""
        end
      end

      function custom_fname:update_status()
        local data = custom_fname.super.update_status(self)
        data = highlight.component_format_highlight(
          vim.bo.modified and self.status_colors.modified or self.status_colors.saved
        ) .. data
        return data
      end

      require("lualine").setup({
        options = {
          icons_enabled = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "⟫", right = "⟪" },
          -- component_separators = { left = "⟩", right = "⟨⟮" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = false,
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
            },
          },
          lualine_b = {},
          lualine_c = {
            custom_fname,
          },
          lualine_x = {
            {
              "harpoon2",
              icon = "♥",
              indicators = { "1", "2", "3", "4" },
              active_indicators = { "[1]", "[2]", "[3]", "[4]" },
              _separator = " ",
              no_harpoon = "Harpoon not loaded",
            },
            {
              "encoding",
            },
            {
              "fileformat",
              symbols = {
                unix = "", -- e712
                dos = "", -- e70f
                mac = "", -- e711
              },
            },
            {
              "filetype",
              colored = true, -- Displays filetype icon in color if set to true
              icon_only = false, -- Display only an icon for filetype
            },
          },
          lualine_y = {
            "progress",
          },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
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
