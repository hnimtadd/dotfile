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
      local prettier_root_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }

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
        nls.builtins.formatting.prettier.with(local_opts.prettier_formatting),
        nls.builtins.code_actions.eslint.with(local_opts.eslint_diagnostics),
        nls.builtins.formatting.eslint.with(local_opts.eslint_formatting),
        nls.builtins.formatting.fish_indent,
        nls.builtins.diagnostics.fish,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
      })
    end,
  },
}
