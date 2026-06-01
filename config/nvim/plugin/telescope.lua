vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', name = 'telescope-fzf-native.nvim' },
    'https://github.com/nvim-telescope/telescope-file-browser.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
})

local actions = require("telescope.actions")

local function teleFilename(_, path)
    local tail = require("telescope.utils").path_tail(path)
    if string.len(tail) > 30 then
        tail = string.sub(tail, 0, 28) .. ".."
    end
    return string.format("%-30s %s", tail, path)
end

require("telescope").setup({
    defaults = {
        file_ignore_patterns = { "vendor/", "node_modules/", "target/" },
        mappings = {
            i = {
                ["<C-|>"] = actions.select_horizontal,
                ["<C-->"] = actions.select_vertical,
            },
            n = {
                ["<C-|>"] = actions.select_horizontal,
                ["<C-->"] = actions.select_vertical,
            },
        },
        layout_strategy = "flex",
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
    },
    preview = { treesitter = false },
    pickers = {
        find_files = { 
            path_display = teleFilename,
            find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
        },
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

local builtin = require("telescope.builtin")

vim.keymap.set("n", ";f", function()
    builtin.find_files()
end, { desc = "Open [F]iles list" })

vim.keymap.set("n", ";r", function() builtin.live_grep() end, { desc = "Open [R]egex" })
vim.keymap.set("n", ";b", function() builtin.buffers() end, { desc = "Open [B]uffers list" })
vim.keymap.set("n", ";t", function() builtin.help_tags() end, { desc = "Open [T]ags list" })
vim.keymap.set("n", ";d", function() builtin.diagnostics({ bufnr = 0 }) end, { desc = "Open [D]iagnostics (buffer)" })
vim.keymap.set("n", ";D", function() builtin.diagnostics() end, { desc = "Open [D]iagnostics (all)" })
vim.keymap.set("n", ";s", function() builtin.treesitter() end, { desc = "Open tree[S]itter symbols" })

vim.keymap.set("n", ";g", function()
    local function telescope_buffer_dir()
        return vim.fn.expand("%:p:h")
    end
    require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = { height = 40 },
    })
end, { desc = "Open File Browser" })
