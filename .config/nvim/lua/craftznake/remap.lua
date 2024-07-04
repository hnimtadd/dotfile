vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/Decrement
keymap.set("n", "_", "<C-x>", opts)
keymap.set("n", "+", "<C-a>", opts)

-- Delete a word backward
keymap.set("n", "dw", "vb_d", opts)

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><", { desc = "resize windows left" })
keymap.set("n", "<C-w><right>", "<C-w>>", { desc = "resize windows right" })
keymap.set("n", "<C-w><up>", "<C-w>+", { desc = "resize windows up" })
keymap.set("n", "<C-w><down>", "<C-w>-", { desc = "resize windows down" })
keymap.set("n", "<C-w>d", "<C-w>q", { desc = "delete windows" })

-- Make page-up, page-down and center
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- next and prev in search then center
-- FIX: this is overridden by LazyVim
keymap.set("n", "n", "nzz", opts)
keymap.set("n", "N", "Nzz", opts)

keymap.set("n", "<leader>rst", "<cmd>LspRestart<cr>", opts)

-- greatest remap ever
keymap.set("x", "<leader>p", [["_dP]], opts)
-- next greatest remap ever : asbjornHaland

keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts)
keymap.set("n", "<leader>Y", [["+Y]], opts)

keymap.set("n", "Q", "<nop>")
