return {
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        disable_background = false,
        -- transparent telescope
        highlight_groups = {
          TelescopeBorder = { fg = "highlight_high", bg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopePromptNormal = { bg = "base" },
          TelescopeResultsNormal = { fg = "subtle", bg = "none" },
          TelescopeSelection = { fg = "text", bg = "base" },
          TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
        },
        --
        styles = {
          italic = false,
          bold = true,
          transparency = false,
        },
      })
    end,
  },
  {
    "navarasu/onedark.nvim",
  },
  {
    "rebelot/kanagawa.nvim",
  },
  {
    "zaldih/themery.nvim",
    config = function()
      require("themery").setup({
        themes = {
          {
            name = "Onedark",
            colorscheme = "onedark",
          },
          {
            name = "Rose pine Moon",
            colorscheme = "rose-pine-moon",
          },
          {
            name = "Tokyo moon",
            colorscheme = "tokyonight-moon",
          },
          {
            name = "Kanagawa-wave",
            colorscheme = "kanagawa-wave",
          },
          {
            name = "Kanagawa-dragon",
            colorscheme = "kanagawa-dragon",
          },
          {
            name = "Kanagawa-lotus",
            colorscheme = "kanagawa-lotus",
          },
        },
      })
    end,
  },
}
