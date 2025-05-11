-- messages, cmdline and the popupmenu
return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<c-b>",       false },
        { "<c-f>",       false },
        { "<leader>sna", false },
        { "<leader>snd", false },
        { "<leader>snh", false },
        { "<S-Enter>" },
    },
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function(event)
                vim.schedule(function()
                    require("noice.text.markdown").keys(event.buf)
                end)
            end,
        })
        require("noice").setup({
            routes = {
                {
                    view = "notify",
                    filter = { event = "msg_showmode" },
                },
                {
                    filter = {
                        event = "notify",
                        find = "No information available",
                    },
                    opts = { skip = true },
                },
                -- hide write messae
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                            { find = "%d fewer lines" },
                            { find = "%d more lines" },
                        },
                    },
                    view = "mini",
                },
            },
            all = {
                -- options for the message history that you get with ":Noice"
                view = "split",
                opts = { enter = true, format = "details" },
                filter = {},
            },
            -- Classic Cmdline
            cmdline = {
                enabled = true,
                view = "cmdline",
                format = {
                    -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
                    -- view: (default is cmdline view)
                    -- opts: any options passed to the view
                    -- icon_hl_group: optional hl_group for the icon
                    -- title: set to anything or empty string to hide
                    cmdline = { pattern = "^:", icon = "", lang = "vim" },
                    search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                    search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                    filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                    lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                    help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                    calculator = { pattern = "^=", icon = "", lang = "vimnormal" },
                    input = { view = "cmdline", icon = "󰥻 " },
                },
            },
            popupmenu = {
                enabled = true,
                view = "cmdline",
            },
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
            views = {
                -- Disable popup view for inputs
                cmdline_input = {
                    view = "cmdline",
                    border = nil,
                },
            },
        })
    end,
}
