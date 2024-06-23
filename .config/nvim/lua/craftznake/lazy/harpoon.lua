return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependecies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end, { desc = "Harpoon [A]dd" })

      vim.keymap.set("n", "<leader>h1", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon [1]" })

      vim.keymap.set("n", "<leader>h2", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon [2]" })

      vim.keymap.set("n", "<leader>h3", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon [3]" })

      vim.keymap.set("n", "<leader>h4", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon [4]" })

      vim.keymap.set("n", "<leader>hr1", function()
        harpoon:list():replace_at(1)
      end, { desc = "Harpoon [R]eplace [1]" })

      vim.keymap.set("n", "<leader>hr2", function()
        harpoon:list():replace_at(2)
      end, { desc = "Harpoon [R]eplace [2]" })

      vim.keymap.set("n", "<leader>hr3", function()
        harpoon:list():replace_at(3)
      end, { desc = "Harpoon  [R]eplace [3]" })

      vim.keymap.set("n", "<leader>hr4", function()
        harpoon:list():replace_at(4)
      end, { desc = "Harpoon  [R]eplace [4]" })
      --
      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<leader>hp", function()
        harpoon:list():prev()
      end, { desc = "Harpoon [P]revious" })

      vim.keymap.set("n", "<leader>hn", function()
        harpoon:list():next()
      end, { desc = "Harpoon [N]ext" })

      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      vim.keymap.set("n", ";h", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open [H]arpoon list" })
    end,
  },
}
