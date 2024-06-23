-- bufferline
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    -- disable buffer-related keymaps
    { "<leader>bp", false },
    { "<leader>br", false },
    { "<leader>bl", false },
    { "<leader>bd", false },
    { "<leader>bo", false },

    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
  },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",
        show_buffer_icons = false,
        show_close_icon = false,
      },
    })
  end,
}
