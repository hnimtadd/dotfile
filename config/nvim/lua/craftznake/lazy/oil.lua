return {
  "stevearc/oil.nvim",
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  config = function()
    local oil = require("oil")
    oil.setup({
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
      default_file_explorer = true,
      columns = { "permissions" },
      -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
      delete_to_trash = false,
      lsp_file_methods = {
        -- Enable or disable LSP file operations
        enabled = false,
      },
      -- Constrain the cursor to the editable parts of the oil buffer
      -- Set to `false` to disable, or "name" to keep it on the file names
      constrain_cursor = "editable",
      -- Set to true to watch the filesystem for changes and reload oil
      watch_for_changes = false,
      use_default_keymaps = false,
      keymaps = {
        ["?"] = { "actions.show_help", mode = "n" },
        ["q"] = { "actions.close", mode = "n" },
        ["<CR>"] = "actions.select",
        -- Splits (following Vim's window commands)
        ["<C-w>v"] = { "actions.select", opts = { vertical = true } }, -- Vertical split
        ["<C-w>s"] = { "actions.select", opts = { horizontal = true } }, -- Horizontal split
        ["<C-w>t"] = { "actions.select", opts = { tab = true } }, -- New tab
        ["<C-p>"] = "actions.preview",
        ["R"] = "actions.refresh",
        ["P"] = "actions.preview", -- Toggle preview
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
      },
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
      },
      win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
      },
      sort = {
        -- sort order can be "asc" or "desc"
        -- see :help oil-columns to see which columns are sortable
        { "type", "asc" },
        { "name", "asc" },
      },
    })

    vim.keymap.set("n", "_", function()
      oil.open(".")
    end, { desc = "Open root directory" })

    vim.keymap.set("n", "-", function()
      oil.open()
    end, { desc = "Open parent directory" })
    -- Create Ex command that behaves like Oil
    vim.api.nvim_create_user_command("Ex", function(opts)
      vim.cmd("Oil " .. (opts.args or ""))
    end, {
      nargs = "?",
      complete = "dir",
      desc = "Oil file explorer",
    })
    -- Declare a global function to retrieve the current directory
    function _G.get_oil_winbar()
      local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
      local dir = oil.get_current_dir(bufnr)
      if dir then
        return vim.fn.fnamemodify(dir, ":~")
      else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
      end
    end
  end,
}
