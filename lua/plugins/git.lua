vim.keymap.set("n", "<leader>gb", "<cmd>:GitBlameToggle<cr>", { noremap = true, silent = true })
return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = false,
      date_format = "%m-%d-%Y",
      virtual_text_column = 1,
    },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gm", "<cmd>:Gvdiffsplit!<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>go", "<cmd>:diffget //2<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gt", "<cmd>:diffget //3<cr>", { noremap = true, silent = true })
    end,
  },
}
