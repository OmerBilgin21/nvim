local exists, _ = pcall(require, "telescope")

local vimgrep_args = {
  "rg",
  "--color=never",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--glob",
  "!node_modules/**",
  "--glob",
  "!.git/**",
  "--glob",
  "!*lock.json",
}

local return_table = {
  "nvim-telescope/telescope.nvim",

  keys = {
    { "<C-p>",            "<cmd>Telescope find_files<CR>" },
    {
      "<C-f>",
      function()
        local tbuiltin = require("telescope.builtin")
        tbuiltin.live_grep({ vimgrep_arguments = vimgrep_args })
      end,
    },
    { "<leader><leader>", "<cmd>Telescope buffers initial_mode=normal theme=dropdown sort_mru=true<CR>" },
    { "<leader>d",        "<cmd>Telescope help_tags<CR>" },
  },
}

if exists then
  local actions = require("telescope.actions")

  return_table["opts"] = {
    defaults = {
      preview = {
        filesize_limit = 1,
      },
      mappings = {
        i = {
          ["<C-c>"] = actions.close,
          ["<esc>"] = actions.close,
        },
        n = {
          ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
          ["<C-c>"] = actions.close,
          ["q"] = actions.close,
        },
      },
    },
  }
end

return return_table
