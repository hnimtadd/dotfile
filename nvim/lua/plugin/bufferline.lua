local bufferline = require('bufferline')
bufferline.setup({
  options = {
    mode = "buffers",
    separator_style = 'slant',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
    close_command = "bdelete! %d",
    numbers = 'ordinal',
    highlights = {
      separator = {
        guifg = '#073642',
        guibg = '#002b36',
      },
      separator_selected = {
        guifg = '#073642',
      },
      background = {
        guifg = '#657b83',
        guibg = '#002b36'
      },
      buffer_selected = {
        guifg = '#fdf6e3',
        gui = "bold",
      },
      fill = {
        guibg = '#073642'
      }
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true
      }
    }
  }
}
)



vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

vim.keymap.set('n', '<C-b>h', ':BufferLineCyclePrev<CR>', { desc = "Go to left buffer" })
vim.keymap.set('n', '<C-b>l', ':BufferLineCycleNext<CR>', { desc = "Go to right buffer" })
vim.keymap.set('n', '<C-b>H', ':BufferLineMovePrev<CR>', { desc = "Move buffer to left" })
vim.keymap.set('n', '<C-b>L', ':BufferLineMoveNext<CR>', { desc = "Move buffer to right" })
vim.keymap.set('n', '<C-b>q', ':Bdelete!<CR>', { desc = "Close current buffer" })
vim.keymap.set('n', '<C-b>p', ':BufferLineTogglePin<CR>', { desc = "Toggle pin current buffer" })

-- navigate between buffer
-- function navigateBuffer(bNum)
--   if bNum ~= nil and bNum ~= '' then
--     local cmd = 'BufferLineGoToBuffer ' .. bNum
--     vim.api.nvim_command(cmd)
--   end
-- end

-- function triggerNavigateBuffer()
--   local num = vim.fn.nr2char(vim.fn.getchar())
--   navigateBuffer(num)
-- end

-- vim.keymap.set('n', '<Tab>', "<cmd>lua triggerNavigateBuffer()<CR>", { silent = true, desc = "Go to buffer n" })
