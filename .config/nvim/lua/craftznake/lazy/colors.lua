function ColorMyPencils(color)
  color = color or "rose-pine-moon"
  vim.cmd.colorscheme(color)
end

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
    "xiyaowong/transparent.nvim",
    lazy = false,
    dependencies = {
      "akinsho/bufferline.nvim",
    },
    config = function()
      vim.keymap.set(
        "n",
        "<leader>ut",
        "<cmd>TransparentToggle<CR>",
        { desc = "Toggle transparency", silent = true, noremap = true }
      )

      require("transparent").setup({
        opts = {
          -- table: default groups
          groups = {
            "Normal",
            "NormalNC",
            "Comment",
            "Constant",
            "Special",
            "Identifier",
            "Statement",
            "PreProc",
            "Type",
            "Underlined",
            "Todo",
            "String",
            "Function",
            "Conditional",
            "Repeat",
            "Operator",
            "Structure",
            "LineNr",
            "NonText",
            "SignColumn",
            "CursorLineNr",
            "EndOfBuffer",
            require("bufferline.config").highlights,
          },
          -- table: additional groups that should be cleared
          extra_groups = {
            "NormalFloat",
            "NvimTreeNormal",
            "NvimTreeNormalNC",
            "NvimTreeNormalFloat",
            "NvimTreeEndOfBuffer",
          },
          -- table: groups you don't want to clear
          exclude_groups = {},
        },
      })
    end,
  },
}
