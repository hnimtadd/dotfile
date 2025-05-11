return {
    {
        "xiyaowong/transparent.nvim",
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
