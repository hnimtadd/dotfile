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
            require("copilot").setup({
                enable = true,
                filetypes = {
                    lua = true,
                    go = true,
                    markdown = true,
                    javascript = true,
                    typescript = true,
                    typescriptreact = true,
                    javascriptreact = true,
                    zig = true,
                    rust = true,
                    python = true,
                    ["*"] = false,
                }
            })
        end,
    },
    { "giuxtaposition/blink-cmp-copilot" },
}
