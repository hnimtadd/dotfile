vim.pack.add({ 'https://github.com/maxandron/goplements.nvim' })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    once = false,
    callback = function()
        require("goplements").setup({})
    end,
})
