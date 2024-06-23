-- A useless plugin that might help you cope with stubbornly broken tests or overall lack of sense in life. It lets you execute aesthetically pleasing, cellular automaton animations based on the content of neovim buffer.

return {
  {
    "eandrju/cellular-automaton.nvim",
    keys = {
      {
        "<leader>mir",
        "<cmd>CellularAutomaton make_it_rain<CR>",
        desc = "[M]ake [I]t [R]ain",
      },
      {
        "<leader>ms",
        "<cmd>CellularAutomaton scramble<CR>",
        desc = "[M]ake [S]cramble",
      },
    },
  },
}
