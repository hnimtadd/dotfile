return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "BurntSushi/ripgrep",
  },
  keys = {
    {
      ";f",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          no_ignore = false,
          hidden = true,
          file_ignore_patterns = { ".git/" },
        })
      end,
      desc = "Open [F]iles list",
    },
    {
      ";r",
      function()
        local builtin = require("telescope.builtin")
        builtin.live_grep()
      end,
      desc = "Open [R]egex",
    },
    {
      ";b",
      function()
        local builtin = require("telescope.builtin")
        builtin.buffers()
      end,
      desc = "Open [B]uffers list",
    },
    {
      ";t",
      function()
        local builtin = require("telescope.builtin")
        builtin.help_tags()
      end,
      desc = "Open [T]ags list",
    },
    {
      ";d",
      function()
        local builtin = require("telescope.builtin")
        builtin.diagnostics({ bufnr = 0 })
      end,
      desc = "Open [D]iagnostics lists",
    },
    {
      ";D",
      function()
        local builtin = require("telescope.builtin")
        builtin.diagnostics()
      end,
      desc = "Open [D]iagnostics lists",
    },
    {
      ";s",
      function()
        local builtin = require("telescope.builtin")
        builtin.treesitter()
      end,
      desc = "Open tree[S]itter lists function names, variables",
    },
    {

      "gt",
      function()
        local builtin = require("telescope.builtin")
        builtin.lsp_definitions()
      end,
      desc = "[G]oto [T]ype Definition",
    },
    {
      "gr",
      function()
        local builtin = require("telescope.builtin")
        builtin.lsp_references()
      end,
      desc = "[G]oto [R]efe[R]ences",
    },
    {

      "gd",
      function()
        local builtin = require("telescope.builtin")
        builtin.lsp_definitions()
      end,
      desc = "[G]oto [D]efinition",
    },
    {
      "gi",
      function()
        local builtin = require("telescope.builtin")
        builtin.lsp_implementations()
      end,
      desc = "[G]oto [I]mplementation",
    },
    {
      ";g",
      function()
        local telescope = require("telescope")

        local function telescope_buffer_dir()
          return vim.fn.expand("%:p:h")
        end

        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
      end,
      desc = "Open File Browser with the path of the current buffer",
    },
  },
  config = function()
    local actions = require("telescope.actions")
    -- Reference from this: show file name first before path
    -- https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1873229658
    local function teleFilename(_, path)
      local tail = require("telescope.utils").path_tail(path)

      if string.len(tail) > 30 then
        tail = string.sub(tail, 0, 28) .. ".."
      end
      -- Calculate width of the output line
      return string.format("%-30s %s", tail, path)
    end

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-|>"] = actions.select_horizontal,
            ["<C-->"] = actions.select_vertical,
          },
          n = {
            ["<C-|>"] = actions.select_horizontal,
            ["<C-->"] = actions.select_vertical,
          },
        },
        layout_strategy = "flex",
      },
      pickers = {
        find_files = {
          path_display = teleFilename,
        },
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
  end,
}
