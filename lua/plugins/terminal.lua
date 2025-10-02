return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    opts = function()
      vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { noremap = true })
      vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { noremap = true })
      vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { noremap = true })
      vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { noremap = true })
    end,
  },
  {
    "brettanomyces/nvim-terminus",
    config = function()
      vim.keymap.set("n", "<C-x>", [[<cmd>TerminusOpen<CR>]], { desc = "Edit command in buffer" })
      vim.keymap.set("t", "<C-x>", [[<C-\><C-n><cmd>TerminusEditCommand<CR>]], { desc = "Edit command in buffer" })
    end,
  },
}
