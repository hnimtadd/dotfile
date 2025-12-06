return {
    { "onsails/lspkind.nvim" },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "stevearc/conform.nvim",
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            {
                "saghen/blink.cmp",
                tag = "v1.8.0",
            },
        },
        opts = {
            servers = {
                rust_analyzer = { mason = false },
                lua_ls = {
                    mason = false,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            require("mason").setup()
            local blink = require("blink.cmp")
            local capabilities =
                vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
                    blink.get_lsp_capabilities())
            local servers = opts.servers or {}
            local setups = opts.setup or {}

            local function handler(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = capabilities,
                }, servers[server] or {})
                if server_opts.enabled == false then
                    return
                end

                if setups[server] then
                    if setups[server](server, server_opts) then
                        return
                    end
                elseif setups["*"] then
                    if setups["*"](server, server_opts) then
                        return
                    end
                end
                vim.lsp.config(server, server_opts)
                vim.lsp.enable(server)
            end

            local ensure_installed = {}
            for server, server_opts in pairs(servers) do
                if server_opts then
                    if server_opts.enabled ~= false then
                        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                        if server_opts.mason == false then
                            handler(server)
                        else
                            ensure_installed[#ensure_installed + 1] = server
                        end
                    end
                end
            end

            -- get all the servers that are available through mason-lspconfig
            local mason_lsp = require("mason-lspconfig")
            mason_lsp.setup({
                automatic_installation = true,
                ensure_installed = ensure_installed,
                handlers = { handler },
            })

            local lsp_utils = require("craftznake.plugins.utils.lsp_utils")
            lsp_utils.setup()
            vim.keymap.set("n", "<leader>tl", lsp_utils.toggle_lsp, { desc = "[T]oggle [L]sps" })

            blink.setup({
                keymap = {
                    preset = "none",
                    -- manually trigger the blink completion
                    ["<C-y>"] = { "show", "fallback" },
                    ["<C-e>"] = { "cancel", "fallback" },
                    ["<CR>"] = {
                        function(cmp)
                            if cmp.is_menu_visible() and cmp.is_active() then
                                print("accept")
                                return cmp.accept()
                            end
                        end,
                        "fallback",
                    },
                    ["<C-p>"] = { "select_prev", "fallback" },
                    ["<C-n>"] = { "select_next", "fallback" },
                    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
                    ["<Tab>"] = {
                        function(cmp)
                            if cmp.is_ghost_text_visible() and cmp.is_active() then
                                return cmp.accept()
                            end
                        end,
                        "snippet_forward",
                        "fallback",
                    },
                    ["<S-Tab>"] = { "snippet_backward", "fallback" },
                },
                appearance = {
                    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = "mono",
                },
                completion = {
                    keyword = { range = "prefix" },
                    menu = {
                        enabled = true,
                        auto_show = false,
                        border = "none",
                        draw = {
                            treesitter = { "lsp" },
                            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                        },
                    },
                    list = {
                        selection = { preselect = true, auto_insert = false },
                        cycle = { from_top = false },
                    },
                    documentation = {
                        auto_show = false,
                        auto_show_delay_ms = 200,
                        window = { border = "single" },
                    },
                    trigger = {
                        prefetch_on_insert = true,
                        show_on_keyword = true,
                        show_on_trigger_character = true,
                        show_on_blocked_trigger_characters = { " ", "\n", "\t" },
                        show_on_insert_on_trigger_character = true,
                    },
                    ghost_text = {
                        enabled = true,
                        show_with_selection = true,
                        show_with_menu = false,
                    },
                },
                signature = {
                    enabled = false,
                    window = { border = "none" },
                },
                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { "lsp", "omni", "path", "snippets" },
                },
            })

            vim.diagnostic.config({
                virtual_text = true, -- Enable virtual text for diagnostics
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = true,
                    header = "",
                    prefix = "",
                },
            })
        end,
    },
}
