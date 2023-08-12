local NvimTree = require('nvim-tree')
local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  vim.keymap.set('n', 'L', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'H', api.tree.change_root_to_parent, opts('CD'))
  vim.keymap.set('n', '<C-s>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<C-f>', api.node.open.horizontal, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
  vim.keymap.set('n', 'c', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
  vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  -- vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
  -- vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
  -- vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
  -- vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
  vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'gY', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  -- vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  -- vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  -- vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  -- vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  -- vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  -- vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
  -- vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
  vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'Y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'gy', api.fs.copy.relative_path, opts('Copy Relative Path'))
  -- api.config.mappings.default_on_attach(bufnr)
end
NvimTree.setup({
  on_attach           = my_on_attach,
  sync_root_with_cwd  = true, -- expreriment
  update_focused_file = {
    enable = false,
    update_cwd = false,
  },
  view                = {
    width = 30,
  },
  renderer            = {
    group_empty = true,
  },
  git                 = {
    enable = false,
  },
  actions             = {
    change_dir = {
      enable = true,
      global = true,
    }
  }
})
-- NvimTree.remove_keymaps()
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
