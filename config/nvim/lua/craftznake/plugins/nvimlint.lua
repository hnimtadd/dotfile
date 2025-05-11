return {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local lint = require("lint")
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

        local function list_lint()
            local linters = require("lint").get_running()
            if #linters == 0 then
                return "󰦕"
            end
            return "󱉶 " .. table.concat(linters, ", ")
        end
        vim.api.nvim_create_user_command("LintList", function()
            print(list_lint())
        end, { desc = "Try linting for current file" })
    end,
}
