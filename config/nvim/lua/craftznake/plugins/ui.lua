return {
    {
        "rcarriga/nvim-notify",
        opts = { timeout = 5000 },
    },
    {
        -- Extensible UI for Neovim notifications and LSP progress messages.
        "j-hui/fidget.nvim",
        tag = "v1.6.1",
        config = function()
            require("fidget").setup()
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                multiwindow = false,      -- Enable multiwindow support.
                max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20,     -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            })
        end,
    },
    -- animations
    {
        "nvim-mini/mini.animate",
        event = "VeryLazy",
        config = function()
            require("mini.animate").setup({
                scroll = {
                    enable = false,
                },
            })
        end,
    },

    {
        "s1n7ax/nvim-window-picker",
        event = "VeryLazy",
        version = "2.*",
        config = function()
            require("window-picker").setup()
        end,
    },
    {
        -- show line the point from start of current scope to the end of scope
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                line_num = {
                    enable = true,
                    style = "#C39898",
                },
                chunk = {
                    enable = true,
                    priority = 15,
                    style = {
                        { fg = "#DBB5B5" }, -- Violet
                        { fg = "#c21f30" }, -- Maple red
                    },
                    use_treesitter = true,
                    chars = {
                        horizontal_line = "─",
                        vertical_line = "│",
                        left_top = "╭",
                        left_bottom = "╰",
                        right_arrow = ">",
                    },
                    textobject = "",
                    max_file_size = 1024 * 1024,
                    error_sign = true,
                },
            })
        end,
    },
    {
        "stevearc/quicker.nvim",
        ft = "qf",
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {},

    }
}
