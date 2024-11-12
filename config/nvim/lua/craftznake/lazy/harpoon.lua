return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependecies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "folke/which-key.nvim",
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})
      local wk = require("which-key")

      wk.add({
        mode = { "n" },
        {
          "<leader>ha",
          function()
            harpoon:list():add()
          end,
          desc = "Harpoon [A]dd",
          noremap = true,
          silent = true,
        },
        {
          "<leader>h1",
          function()
            harpoon:list():select(1)
          end,
          desc = "Harpoon [1]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>h2",
          function()
            harpoon:list():select(2)
          end,
          desc = "Harpoon [2]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>h3",
          function()
            harpoon:list():select(3)
          end,
          desc = "Harpoon [3]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>h4",
          function()
            harpoon:list():select(4)
          end,
          desc = "Harpoon [4]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>hr1",
          function()
            harpoon:list():replace_at(1)
          end,
          desc = "Harpoon [R]eplace [1]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>hr2",
          function()
            harpoon:list():replace_at(2)
          end,
          desc = "Harpoon [R]eplace [2]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>hr3",
          function()
            harpoon:list():replace_at(3)
          end,
          desc = "Harpoon [R]eplace [3]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>hr4",
          function()
            harpoon:list():replace_at(4)
          end,
          desc = "Harpoon [R]eplace [4]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>hd1",
          function()
            harpoon:list():remove_at(1)
          end,
          desc = "Harpoon [D]elete [1]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>hd2",
          function()
            harpoon:list():remove_at(2)
          end,
          desc = "Harpoon [D]elete [2]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>hd3",
          function()
            harpoon:list():remove_at(3)
          end,
          desc = "Harpoon [D]elete [3]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>hd4",
          function()
            harpoon:list():remove_at(4)
          end,
          desc = "Harpoon [D]elete [4]",
          noremap = true,
          silent = true,
        },
        {
          "<leader>hp",
          function()
            harpoon:list():prev()
          end,
          desc = "Harpoon [P]revious",
          noremap = true,
          silent = true,
        },
        {
          "<leader>hd4",
          function()
            harpoon:list():next()
          end,
          desc = "Harpoon [N]ext",
          noremap = true,
          silent = true,
        },
      })

      -- Toggle previous & next buffers stored within Harpoon list
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

      wk.add({
        {
          mode = "n",
          {
            ";h",
            function()
              toggle_telescope(harpoon:list())
            end,
            desc = "Open [H]arpoon list",
            noremap = true,
            silent = true,
          },
        },
      })
    end,
  },
}
