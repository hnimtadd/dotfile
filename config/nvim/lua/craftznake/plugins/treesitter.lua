return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- tag = "v0.10.0",
        build = ":TSUpdate",
        config = function()
            -- A list of parser names, or "all"
            require("nvim-treesitter").install({
                "vimdoc",
                "javascript",
                "typescript",
                "c",
                "lua",
                "rust",
                "jsdoc",
                "bash",
                "go",
            })
            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    "vimdoc",
                    "javascript",
                    "typescript",
                    "c",
                    "lua",
                    "rust",
                    "jsdoc",
                    "bash",
                    "go",
                },
                callback = function()
                    -- syntax highlighting, provided by Neovim
                    vim.treesitter.start()
                    -- folds, provided by Neovim
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.wo.foldmethod = 'expr'
                    vim.wo.foldlevel = 99 -- Keep everything unfolded by default
                    -- indentation, provided by nvim-treesitter
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        config = function()
            require("treesitter-context").setup({
                enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
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
}
