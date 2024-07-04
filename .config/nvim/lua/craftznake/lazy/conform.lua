return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "gofumpt", "goimports" },
    },
    formatters = {
      gofumpt = {
        prepend_args = { "-w", "$FILENAME" },
        stdin = false,
        tmpfile_format = ".conform.$RANDOM.$FILENAME",
      },
    },
  },
}
