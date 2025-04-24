return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
            panel = { enabled = false },
            suggestion = { enabled = false },
        },
        config = function()
            require("copilot").setup({})
        end,
    },
    { "giuxtaposition/blink-cmp-copilot" },
}
