-- Description: nvim-cmp configuration
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",

    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    "onsails/lspkind.nvim",
    "zbirenbaum/copilot-cmp",
  },
  config = function()
    local cmp = require("cmp")

    -- local has_words_before = function()
    --   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    --     return false
    --   end
    --
    --   local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    --   return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    -- end

    local lspkind = require("lspkind")
    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
          mode = "text_symbol",
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          -- can also be a function to dynamically calculate max width such as
          -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = false,
          symbol_map = {
            Text = "🈯",
            Method = "🈸",
            Function = "🈹",
            Constructor = "🈴",
            Field = "🈂️",
            Variable = "🈲",
            Class = "🈶",
            Interface = "🈵",
            Module = "🈳",
            Property = "🈵",
            Unit = "🈳",
            Value = "🈂️",
            Enum = "🈲",
            Keyword = "🈺",
            Snippet = "🈶",
            Color = "🈸",
            File = "🈺",
            Reference = "🈶",
            Folder = "🈯",
            EnumMember = "",
            Constant = "🈹",
            Struct = "🈴",
            Event = "🈺",
            Operator = "🈹",
            TypeParameter = "🈯",
            Copilot = "🈺",
            Codeium = "🈚",
            TabNine = "🈺",
          },
        }),
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-y>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),

        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Replace, select = true }),

        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
      }),

      sources = cmp.config.sources({
        { name = "copilot", group_index = 2, priority = 100 },
        -- { name = "codeium", group_index = 2, priority = 100 },
        { name = "cmp_tabnine", group_index = 2, priority = 100 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "luasnip", group_index = 2 }, -- For luasnip users.
        { name = "emoji", group_index = 2 },
      }, {
        { name = "buffer" },
      }),
      auto_brackets = { "python" },
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
