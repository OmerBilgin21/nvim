return {
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
}
