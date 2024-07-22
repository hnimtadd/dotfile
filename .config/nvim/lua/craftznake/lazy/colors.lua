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
    dependencies = {
      "akinsho/bufferline.nvim",
    },
    config = function()
      require("transparent").setup({ -- Optional, you don't have to run setup.
        groups = { -- table: default groups
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
          "CursorLine",
          "CursorLineNr",
          "StatusLine",
          "StatusLineNC",
          "EndOfBuffer",
          require("bufferline.config").highlights,
        },
        extra_groups = {
          "NormalFloat",
          "NeoTreeNormal",
        }, -- table: additional groups that should be cleared
        exclude_groups = {}, -- table: groups you don't want to clear
      })

      vim.keymap.set("n", "<leader>uu", "<Cmd>TransparentToggle<CR>", { desc = "Toggle transparent" })
    end,
  },
}
