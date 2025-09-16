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
            sh = { "shellcheck" },
            python = { "flake8" },
            lua = { "luacheck" },
            markdown = { "markdownlint-cli2" },
            text = {},
            json = { "jsonlint", },
            zsh = { "zsh" },
        }
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.api.nvim_create_user_command("Lint", function()
            lint.try_lint()
        end, { desc = "Try linting for current file" })

        vim.api.nvim_create_user_command("LintList", function()
            local linters = require("lint").get_running()
            if #linters == 0 then
                print("󰦕")
                return
            end
            print("󱉶 " .. table.concat(linters, ", "))
        end, { desc = "Try linting for current file" })


        vim.api.nvim_create_user_command("LintGrammar", function()
            lint.try_lint("write_good")
        end, { desc = "Try linting for current file" })
    end,
}
