return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "j-hui/fidget.nvim",
    "hrsh7th/nvim-cmp",
    {
      "hrsh7th/cmp-nvim-lsp",
      cond = function()
        return require("lazyvim.util").has("nvim-cmp")
      end,
    },
  },
  after = { "cmp.lua" },
  config = function()
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities =
      vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",
        "vimls",
        "golangci_lint_ls",
        "ruff_lsp",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- ["golangci_lint_ls"] = function()
        --   local lspconfig = require("lspconfig")
        --   local configs = require("lspconfig/configs")
        --
        --   if not configs.golangcilsp then
        --     configs.golangcilsp = {
        --       default_config = {
        --         cmd = { "golangci-lint-langserver" },
        --         root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
        --         init_options = {
        --           command = {
        --             "golangci-lint",
        --             "run",
        --             "--enable-all",
        --             "--disable",
        --             "lll",
        --             "--out-format",
        --             "json",
        --             "--issues-exit-code=1",
        --           },
        --         },
        --       },
        --     }
        --   end
        --   lspconfig.golangci_lint_ls.setup({
        --     filetypes = { "go", "gomod" },
        --     capabilities = capabilities,
        --   })
        -- end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                },
              },
            },
          })
        end,
        ["pylsp"] = function()
          local lspconfig = require("lspconfig")

          lspconfig.pylsp.setup({
            capabilities = capabilities,
            settings = {
              pylsp = {
                plugins = {
                  ruff = { enabled = true },
                  flake8 = { enabled = false },
                  pyflakes = { enabled = false },
                  pycodestyle = { enabled = false },
                  mccabe = { enabled = false },
                },
              },
            },
          })
        end,
        ["rust_analyzer"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
          })
        end,
      },
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      },
    })
  end,
}
