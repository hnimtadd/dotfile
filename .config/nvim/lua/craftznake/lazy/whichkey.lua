return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {

      preset = "classic",
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>h", group = "harpoon" },
          { "<leader>m", group = "make" },
          { "<leader>r", group = "restart" },
          { "<leader>v", group = "view" },
          { "<leader>z", group = "zen" },
          { "<leader>t", group = "toggle/term" },
        },
      },
    },
  },
}
