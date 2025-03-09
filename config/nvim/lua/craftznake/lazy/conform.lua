return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  cmd = { "ConformInfo" },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opt = {
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      go = { "gofumpt", "goimports" },
      python = { "isort", "ruff_format" },
      -- typescript = { "prettierd", "eslint_d" },
      -- javascript = { "prettierd", "eslint_d" },
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
          if vim.fs.find({ ".pretter", ".prettier.json", ".prettier.js" }, {}) then
            return true
          else
            return false
          end
        end,
      },
      -- },
    },
  },
  init = function()
    -- Command to proactively Format current buffer
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })

    -- Command to DisableFormat current buffer
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    -- Command to DisableFormat current buffer
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}
