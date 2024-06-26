return {
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("cmp_tabnine.config"):setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        show_prediction_strength = false,
        min_percent = 0,
      })
      local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })

      vim.api.nvim_create_autocmd("BufRead", {
        group = prefetch,
        pattern = "*.(py|go)",
        callback = function()
          require("cmp_tabnine"):prefetch(vim.fn.expand("%:p"))
        end,
      })
    end,
  },
}
