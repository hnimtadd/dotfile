vim.pack.add({ 'https://github.com/folke/trouble.nvim' })

require("trouble").setup({})

require("which-key").add({
    {
        mode = { "n" },
        {
            "[t",
            function() require("trouble").prev({ skip_groups = true, jump = true }, {}) end,
            desc = "Prev [T]rouble",
        },
    },
})

require("which-key").add({
    {
        mode = { "n" },
        {
            "]t",
            function() require("trouble").next({ skip_groups = true, jump = true }, {}) end,
            desc = "Next [T]rouble",
        },
    },
})
