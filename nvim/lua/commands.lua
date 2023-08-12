-- vim.cmd [[autocmd BufWritePre * %s/\s\+$//e ]]

-- Swap folder
vim.cmd('command! ListSwap split | enew | r !ls -l ~/.local/state/nvim/swap/')
vim.cmd('command! CleanSwap !rm -rf ~/.local/state/nvim/swap/')

-- Make locsetList diagnostic change with DiagnosticChanged
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(args)
    vim.diagnostic.setloclist({ open = false })
  end,
})
-- vim.cmd [[ augroup remember_folds
--   augroup remember_folds
--     autocmd!
--     autocmd BufWinLeave ?* mkview 1
--     autocmd BufWinEnter ?* silent! loadview 1
--   augroup END
-- ]]
