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
keymap.set("n", "n", "nzz", opts)
keymap.set("n", "N", "Nzz", opts)

keymap.set("n", "<leader>rst", "<cmd>LspRestart<cr>", opts)

-- greatest remap ever
keymap.set("x", "<leader>p", [["_dP]], opts)
-- next greatest remap ever : asbjornHaland

keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts)
keymap.set("n", "<leader>Y", [["+Y]], opts)

keymap.set("n", "Q", "<nop>")

keymap.set("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- tab
keymap.set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })

-- Terminal Mappings
keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
