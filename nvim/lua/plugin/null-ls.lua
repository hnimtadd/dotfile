local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local lSsources = {
    null_ls.builtins.formatting.prettierd.with({
        filetypes = {
            "javascript",
            "typescript",
            "css",
            "scss",
            "html",
            "json",
            "yaml",
            "markdown",
            "graphql",
            "md",
            "txt",
            "htmldjango",
        },
        only_local = "node_modules/.bin",
    }),
    null_ls.builtins.formatting.stylua.with({
        filetypes = {
            "lua",
        },
        args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
    }),
    null_ls.builtins.diagnostics.stylelint.with({
        filetypes = {
            "css",
            "scss",
        },
    }),
}
null_ls.setup({
    -- you can reuse a shared lspconfig on_attach callback here
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.eslint_d.with({
            diagnostics_format = '[eslint] #{m}\n(#{c})'
        }),
        null_ls.builtins.diagnostics.fish
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
                group = augroup,
                buffer = bufnr
            })
            vim.api.nvim_clear_autocmds({
                group = 'kickstart-lsp-attach-format',
                buffer = bufnr
            })
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        async = true,
                        filter = function(c)
                            return c.name == 'null-ls'
                        end,
                    })
                end,
            })
            vim.api.nvim_buf_create_user_command(
                bufnr,
                "Lint",
                function()
                    vim.lsp.buf.format({
                        async = false,
                        filter = function(c)
                            return c.id == 'null-ls'
                        end,
                    })
                end,
                { desc = "Format current buffer with Prettier" }
            )
        end
    end
})
vim.api.nvim_create_user_command(
    'DisableLspFormatting',
    function()
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
    end,
    { nargs = 0 }
)
