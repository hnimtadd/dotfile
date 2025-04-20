return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "none",
        -- manually trigger the blink completion
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        keyword = { range = "prefix" },
        menu = {
          enabled = true,
          auto_show = false,
          border = "none",
          draw = {
            treesitter = { "lsp" },
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        list = {
          selection = { preselect = false, auto_insert = false },
          cycle = { from_top = false },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = "single" },
        },
        trigger = {
          prefetch_on_insert = true,
          show_on_keyword = false,
          show_on_trigger_character = true,
        },
        ghost_text = {
          enabled = true,
        },
      },
      signature = {
        enabled = false,
        window = { border = "none" },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "omni", "path", "snippets", "buffer" },
      },
    },
  },
}
