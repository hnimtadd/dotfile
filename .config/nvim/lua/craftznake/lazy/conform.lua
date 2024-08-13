return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "gofumpt", "goimports" },
      python = { "isort", "ruff_format" },
      typescript = { "prettierd", "eslint_d" },
      javascript = { "prettierd", "eslint_d" },
      rust = { "rustfmt" },
      json = { "jq" },
    },
    formatters = {
      gofumpt = {
        prepend_args = { "-w", "$FILENAME" },
        stdin = false,
        tmpfile_format = ".conform.$RANDOM.$FILENAME",
      },
      -- prettier_d = {

      prettier_d = {
        condition = function()
          -- check if the project have .prettier or .prettier.json file, if there, return true, otherwise false
          if
            vim.fs.find({
              ".pretter",
              ".prettier.json",
              ".prettier.js",
            }, {})
          then
            return true
          else
            return false
          end
        end,
      },

      -- },
    },
  },
}
