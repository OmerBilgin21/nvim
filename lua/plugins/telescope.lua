local exists, _ = pcall(require, "telescope")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  lazy = false,
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".git",
          -- for files you have to do it like below
          "!*lock.json",
          "raycast",
          "dist",
          "*.next",
          "*.gitlab",
          "build",
          "target",
        },
        preview = {
          filesize_limit = 1,
        },
        mappings = {
          i = {
            ["<C-c>"] = actions.close,
            ["<esc>"] = actions.close,
            ["q"] = actions.close,
          },
          n = {
            ["<C-d>"] = actions.delete_buffer,
            ["<C-c>"] = actions.close,
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        lsp_references = {
          jump_type = "vsplit",
        },
        live_grep = {
          theme = "ivy",
        },
        buffers = {
          initial_mode = "normal",
          theme = "dropdown",
          sort_mru = true,
        },
      },
    })
    vim.keymap.set("n", "<C-p>", function()
      builtin.find_files()
    end, {
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "<leader>p", function()
      builtin.find_files({
        hidden = true,
        no_ignore = true,
      })
    end, {
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "<leader>f", function()
      builtin.live_grep()
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader><leader>", function()
      builtin.buffers()
    end, {
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "<leader>d", function()
      builtin.help_tags()
    end, {
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "gd", function()
      builtin.lsp_definitions({ reuse_win = true })
    end, {})
    vim.keymap.set("n", "gr", function()
      builtin.lsp_references()
    end, {})

    if exists then
      telescope.load_extension("fzf")
    end
  end,
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
}
