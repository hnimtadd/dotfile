return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "prettier",
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "gopls",
      })
    end,
  },
  -- null-ls
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")

      local root_has_file = function(files)
        return function(utils)
          return utils.root_has_file(files)
        end
      end

      local eslint_root_file = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" }
      local prettier_root_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json", "prettier.config.js" }
      local golang_ci_lint_files = { ".golangci.yml" }

      local local_opts = {
        eslint_formatting = {
          condition = function(utils)
            local has_eslint = root_has_file(eslint_root_file)(utils)
            local has_prettier = root_has_file(prettier_root_files)(utils)
            return has_eslint and not has_prettier
          end,
        },
        eslint_diagnostics = {
          condition = root_has_file(eslint_root_file),
        },
        prettier_formatting = {
          condition = root_has_file(prettier_root_files),
        },
      }

      opts.sources = vim.tbl_extend("force", opts.sources, {
        nls.builtins.formatting.prettier.with({
          condition = local_opts.prettier_formatting.condition,
          prefer_local = "node_modules/.bin",
        }),
        nls.builtins.diagnostics.golangci_lint.with({ condition = root_has_file(golang_ci_lint_files) }),
        nls.builtins.formatting.fish_indent,
        nls.builtins.diagnostics.fish,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.gofumpt.with({
          condition = function()
            return false
          end,
        }),
        nls.builtins.formatting.goimports.with({
          condition = function()
            return false
          end,
        }),
        -- nls.builtins.formatting.gofumpt,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = function(_, opts)
      vim.tbl_extend("force", opts.servers or {}, {
        eslint = true,
      })
    end,
  },
}
