return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = function()
            return {
                { "s",          mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash", },
                { "<leader>vy", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            }
        end,
    },
}
