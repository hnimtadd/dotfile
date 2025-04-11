return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },
    after = { "cmp.lua" },
    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities =
            vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup({})
        local lspconfig = require("lspconfig")
        ---@diagnostic disable-next-line: missing-fields
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "vimls" },
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({ capabilities = capabilities })
                end,
                ["gopls"] = function()
                    lspconfig.gopls.setup({
                        capabilities = capabilities,
                        root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
                        -- settings = {
                        --     gopls = {
                        --         -- gofumpt = true,
                        --         -- semanticTokens = true,
                        --         -- staticcheck = true,
                        --     },
                        -- },
                    })
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
                ["pylsp"] = function()
                    lspconfig.pylsp.setup({
                        capabilities = capabilities,
                        settings = {
                            pylsp = {
                                plugins = {
                                    ruff = { enabled = true },
                                    flake8 = { enabled = false },
                                    pyflakes = { enabled = false },
                                    pycodestyle = { enabled = false },
                                    mccabe = { enabled = false },
                                },
                            },
                        },
                    })
                end,
            },
        })

        vim.lsp.handlers["textDocument/diagnostic"] = vim.lsp.with(vim.lsp.diagnostic.on_diagnostic, {
            -- Enable underline, use default values
            underline = true,
            -- Enable virtual text, override spacing to 4
            virtual_text = {
                spacing = 4,
            },
            -- Use a function to dynamically turn signs off
            -- and on, using buffer local variables
            signs = function(_, bufnr)
                return vim.b[bufnr].show_signs == true
            end,
            -- Disable a feature
            update_in_insert = false,
        })

        local lsp_utils = require("craftznake.lazy.utils.lsp_utils")
        lsp_utils.setup()
        require("craftznake.lazy.langs.go").setup()

        -- Set key mapping to toggle LSP on or off with <leader>tl
        vim.keymap.set("n", "<leader>tl", lsp_utils.toggle_lsp, { desc = "[T]oggle [L]sps" })
    end,
}
