return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp",
    },
    config = function(_, opts)
        local function on_attach(_, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            map("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
            map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            map("n", "gr", vim.lsp.buf.references, "[G]oto [R]eferences")
            map("n", "gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
            map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
            map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help")

            map("n", "<leader>vrn", vim.lsp.buf.rename, "[R]e[n]ame")
            map("n", "<leader>vca", vim.lsp.buf.code_action, "[C]ode [A]ction")
            map("n", "<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

            -- Diagnostic keymaps
            map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
            map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
            map("n", "<leader>xe", vim.diagnostic.open_float, "Show Diagnostic")
            map("n", "<leader>xq", vim.diagnostic.setloclist, "Set Location List")
        end
        local servers = opts.servers
        local has_blink, blink = pcall(require, "blink.cmp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            has_blink and blink.get_lsp_capabilities() or {},
            opts.capabilities or {}
        )

        local function setup(server)
            local server_opts = vim.tbl_deep_extend("force", {
                capabilities = capabilities,
                on_attach = on_attach,
            }, servers[server] or {})
            if server_opts.enabled == false then
                return
            end

            if opts.setup[server] then
                if opts.setup[server](server, server_opts) then
                    return
                end
            elseif opts.setup["*"] then
                if opts.setup["*"](server, server_opts) then
                    return
                end
            end
            require("lspconfig")[server].setup(server_opts)
        end

        -- get all the servers that are available through mason-lspconfig
        local have_mason, mlsp = pcall(require, "mason-lspconfig")
        local all_mslp_servers = {}
        if have_mason then
            all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
        end

        local ensure_installed = {} ---@type string[]
        for server, server_opts in pairs(servers) do
            if server_opts then
                server_opts = server_opts == true and {} or server_opts
                if server_opts.enabled ~= false then
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end
        end

        if have_mason then
            mlsp.setup({
                automatic_installation = true,
                ensure_installed = ensure_installed,
                handlers = { setup },
            })
        end

        local lsp_utils = require("craftznake.lazy.utils.lsp_utils")
        lsp_utils.setup()
        require("craftznake.lazy.langs.go").setup()
        -- Set key mapping to toggle LSP on or off with <leader>tl
        vim.keymap.set("n", "<leader>tl", lsp_utils.toggle_lsp, { desc = "[T]oggle [L]sps" })
    end,
}
