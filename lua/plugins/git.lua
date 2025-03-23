return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>gb", "<cmd>:GitBlameToggle<cr>", { noremap = true, silent = true })
    end,
    opts = {
      enabled = false,
      message_template = " <summary> • <date> • <author> • <<sha>>",
      date_format = "%m-%d-%Y %H:%M:%S",
      virtual_text_column = 1,
    },
    {
      "tpope/vim-fugitive",
      config = function()
        vim.keymap.set("n", "<leader>gm", "<cmd>:Gdiffsplit!<cr>", { noremap = true, silent = true })
      end,
    },
  },
}
