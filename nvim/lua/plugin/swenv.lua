local swenv = require('swenv')
-- swenv.setup({
--   get_venvs = function(venvs_path)
--     return require("swenv.api").get_venvs(venvs_path)
--   end,
--   venvs_path = vim.fn.expand('/home/hnimtadd/miniconda3/envs'),
--   post_set_venv = vim.cmd.LspRestart,
-- })
local api = require('swenv.api')
swenv.setup({
  -- Should return a list of tables with a `name` and a `path` entry each.
  -- Gets the argument `venvs_path` set below.
  -- By default just lists the entries in `venvs_path`.
  get_venvs = function(venvs_path)
    return api.get_venvs(venvs_path)
  end,
  -- Path passed to `get_venvs`.
  venvs_path = vim.fn.expand('~/miniconda3/envs'),
  -- Something to do after setting an environment, for example call vim.cmd.LspRestart
  post_set_venv = vim.cmd.LspRestart,
})

vim.keymap.set('n', '<leader>sv', api.pick_venv, { desc = "change Python venv" })
