return {
    {
        "folke/trouble.nvim",
        dependencies = {
            "folke/which-key.nvim",
        },
        config = function()
            require("trouble").setup({})
            local wk = require("which-key")

            wk.add({
                {
                    mode = { "n" },
                    {
                        "[t",
                        function()
                            require("trouble").prev({ skip_groups = true, jump = true }, {})
                        end,
                        desc = "Prev [T]rouble",
                    },
                },
            })

            wk.add({
                {
                    mode = { "n" },
                    {
                        "]t",
                        function()
                            require("trouble").next({ skip_groups = true, jump = true }, {})
                        end,
                        desc = "Next [T]rouble",
                    },
                },
            })
        end,
    },
}
