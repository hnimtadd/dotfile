return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "giuxtaposition/blink-cmp-copilot",
        },
        opts = {
            keymap = {
                preset = "none",
                -- manually trigger the blink completion
                ["<C-y>"] = { "show", "fallback" },
                ["<C-e>"] = { "cancel", "fallback" },
                ["<CR>"] = {
                    function(cmp)
                        if cmp.is_menu_visible() and cmp.is_active() then
                            return cmp.accept()
                        end
                    end,
                    "fallback",
                },
                ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
                ["<C-n>"] = { "select_next", "fallback_to_mappings" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
                ["<Tab>"] = {
                    function(cmp)
                        if cmp.is_ghost_text_visible() and cmp.is_active() then
                            return cmp.accept()
                        end
                    end,
                    "snippet_forward", "fallback" },
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
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = { border = "single" },
                },
                trigger = {
                    prefetch_on_insert = true,
                    show_on_keyword = true,
                    show_on_trigger_character = true,
                    show_on_blocked_trigger_characters = { ' ', '\n', "\t" },
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
                default = { "copilot", "lsp", "omni", "path", "snippets", "buffer" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        enabled = true,
                        async = true,
                        kind = "Copilot",
                        score_offset = 100,
                        override = {
                            get_trigger_characters = function(self)
                                local trigger_characters = self:get_trigger_characters()
                                return vim.list_extend(trigger_characters, { " " })
                            end,
                        },
                    },
                },
            },
        },
    },
}
