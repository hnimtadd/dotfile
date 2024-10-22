return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
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
            fmt = function(str)
              local mode_map = {
                n = "⽳", -- Normal
                i = "⼃", -- Insert
                v = "⼊", -- Visual
                V = "⽘", -- Visual Line
                c = "⼄", -- Command
                R = "⽡", -- Replace
                s = "ꓢ", -- Select
                S = "⺐", -- Select Line
                t = "⺘", -- Terminal
              }
              return mode_map[vim.fn.mode()] or str
            end,
          },
        },
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          "encoding",
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
    },
  },
}
