return {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft.go = { "golangcilint" }

    local golangcilint = require("lint.linters.golangcilint")
    golangcilint.append_fname = true
    golangcilint.args = {
      "run",
      "--out-format",
      "json",
    }
    --
    -- local dir_has_file = function(files)
    --   for _, file in ipairs(files) do
    --     if vim.fn.filereadable(file) then
    --       return true
    --     end
    --     return false
    --   end
    -- end
    --
    -- local golangci_lintfiles = { ".golangci.yml" }
    -- if dir_has_file(golangci_lintfiles) then
    --   print("golangci_lintfiles")
    --   -- create auto cmd that run command `golangci-lint run --fix` for all file end with .go extension
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     pattern = { "*.go" },
    --     end,
    --     callback = function()
    --   })
    -- end
  end,
}
