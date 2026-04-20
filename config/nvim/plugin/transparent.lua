vim.pack.add({ 'https://github.com/xiyaowong/transparent.nvim' })

vim.keymap.set(
    "n",
    "<leader>ut",
    "<cmd>TransparentToggle<CR>",
    { desc = "Toggle transparency", silent = true, noremap = true }
)

require("transparent").setup({
    opts = {
        groups = {
            "Normal", "NormalNC", "Comment", "Constant", "Special",
            "Identifier", "Statement", "PreProc", "Type", "Underlined",
            "Todo", "String", "Function", "Conditional", "Repeat",
            "Operator", "Structure", "LineNr", "NonText", "SignColumn",
            "CursorLineNr", "EndOfBuffer",
            require("bufferline.config").highlights,
        },
        extra_groups = {
            "NormalFloat",
            "NvimTreeNormal",
            "NvimTreeNormalNC",
            "NvimTreeNormalFloat",
            "NvimTreeEndOfBuffer",
        },
        exclude_groups = {},
    },
})
