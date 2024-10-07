local telescope_builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local telescope_config = require("telescope.config")

local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!*.lock.json")

return {
  "nvim-telescope/telescope.nvim",

  opts = {
    pickers = {
      find_files = {
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--glob",
          "!**/.git/*",
          "--glob",
          -- package.lock.json or yarn version
          -- annoys me quite a bit
          "!*.lock.json",
        },
      },
    },
    defaults = {
      preview = {
        -- quite dangerous to disable this
        -- since I changed the config to recognize
        -- the hidden files as well
        filesize_limit = 1,
      },
      -- for live_grep since apparently it doesn't support
      -- changing the flags natively
      -- so I insert it above to a table and give it here
      vimgrep_arguments = vimgrep_arguments,
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
  },

  keys = {

    { "<C-p>",            "<cmd>Telescope find_files<CR>" },
    { "<C-f>",            "<cmd>Telescope live_grep<CR>" },
    { "<leader><leader>", "<cmd>Telescope buffers initial_mode=normal theme=dropdown sort_mru=true<CR>" },
    { "<leader>th",       "<cmd>Telescope help_tags<CR>" },
  },
}
