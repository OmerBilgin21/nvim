return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gm", "<cmd>:Gvdiffsplit!<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gb", "<cmd>:G blame<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gr", function()
        local back = vim.fn.input("Enter how many times to take back:")
        local cmd = string.format("G reset --soft HEAD~%s", back)
        vim.cmd(cmd)
      end, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>go", "<cmd>:diffget //2<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gt", "<cmd>:diffget //3<cr>", { noremap = true, silent = true })
    end,
  },
}
