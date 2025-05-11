return {
    {
        "rose-pine/neovim",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
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
    { "navarasu/onedark.nvim" },
    { "craftzdog/solarized-osaka.nvim" },
    { "ellisonleao/gruvbox.nvim" },
    {
        "zaldih/themery.nvim",
        config = function()
            require("themery").setup({
                livePreview = true,
                themes = {
                    { name = "Onedark",         colorscheme = "onedark" },
                    { name = "Rose pine Moon",  colorscheme = "rose-pine-moon" },
                    { name = "solarized-osaka", colorscheme = "solarized-osaka" },
                    { name = "gruvbox",         colorscheme = "gruvbox" },
                },
            })
        end,
    },
}
