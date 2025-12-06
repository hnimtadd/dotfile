return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  optional = true,
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      sh = {},
      python = {},
      lua = {},
      markdown = {},
      text = {},
      json = {},
      zsh = {},
    }

    vim.api.nvim_create_user_command("Lint", function()
      lint.try_lint()
    end, { desc = "Try linting for current file" })

    vim.api.nvim_create_user_command("LintList", function()
      local linters = require("lint").get_running()
      if #linters == 0 then
        print("󰦕 No linters found")
        return
      end
      print("󱉶 " .. table.concat(linters, ", "))
    end, { desc = "Try linting for current file" })

    vim.api.nvim_create_user_command("LintGrammar", function()
      lint.try_lint("write_good")
    end, { desc = "Try linting for current file" })
  end,
}
