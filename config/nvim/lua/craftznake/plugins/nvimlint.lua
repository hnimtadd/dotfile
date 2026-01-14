return {
    {
        "mfussenegger/nvim-lint",
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
                go = { "golangcilint" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })

            vim.api.nvim_create_user_command("Lint", function()
                require("lint").try_lint()
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
                require("lint").try_lint("write_good")
            end, { desc = "Try linting for current file" })
        end,
    }
}
