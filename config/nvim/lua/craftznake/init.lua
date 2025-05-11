require("craftznake.lazy")
require("craftznake.set")
require("craftznake.remap")

local augroup = vim.api.nvim_create_augroup
local CraftznakeGroup = augroup("Craftznake", { clear = false })

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
    require("plenary.reload").reload_module(name)
end

-- Auto highlight next occur of yanked word
autocmd({ "TextYankPost" }, {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = CraftznakeGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
