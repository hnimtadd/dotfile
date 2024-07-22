return {
  {
    "echasnovski/mini.animate",
    version = "*",
    config = function()
      require("mini.animate").setup({
        scroll = {
          enable = false,
        },
      })
    end,
  },
}
