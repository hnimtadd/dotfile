require("craftznake.set")
require("craftznake.remap")
require("craftznake.lazy_init")

local augroup = vim.api.nvim_create_augroup
local CraftznakeGroup = augroup("Craftznake", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
  require("plenary.reload").reload_module(name)
end

-- Auto highlight next occur of yanked word
autocmd("TextYankPost", {
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

autocmd("VimEnter", {
  callback = function()
    ColorMyPencils()
  end,
})

autocmd("LspAttach", {
  group = CraftznakeGroup,
  callback = function(e)
    local opts = { buffer = e.buf }

    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, vim.tbl_extend("force", opts, { desc = "[G]oto [D]efinition" }))

    vim.keymap.set("n", "gD", function()
      vim.lsp.buf.declaration()
    end, vim.tbl_extend("force", opts, { desc = "[G]oto [D]ecalration" }))

    vim.keymap.set("n", "gi", function()
      vim.lsp.buf.implementation()
    end, vim.tbl_extend("force", opts, { desc = "[G]oto [I]mplementation" }))

    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)

    vim.keymap.set("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, vim.tbl_extend("force", opts, { desc = "[V]iew [W]orkspace [S]ymbol" }))

    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, vim.tbl_extend("force", opts, { desc = "[V]iew [D]iagnostic" }))

    vim.keymap.set("n", "<leader>vca", function()
      vim.lsp.buf.code_action()
    end, vim.tbl_extend("force", opts, { desc = "[V]iew [C]ode [A]ction" }))

    vim.keymap.set("n", "<leader>vrr", function()
      vim.lsp.buf.references()
    end, vim.tbl_extend("force", opts, { desc = "[V]iew [R]efe[R]ences" }))

    vim.keymap.set("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, vim.tbl_extend("force", opts, { desc = "[V]iew [R]e[N]ame" }))

    -- prevent focusing the signature popup
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)

    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_next()
    end, vim.tbl_extend("force", opts, { desc = "Next [D]iagnostic" }))

    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_prev()
    end, vim.tbl_extend("force", opts, { desc = "Prev [D]iagnostic" }))
  end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
