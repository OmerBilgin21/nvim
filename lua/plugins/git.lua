return {
  {
    "willothy/flatten.nvim",
    opts = {
      window = { open = "alternate" },
      hooks = {
        should_block = function(argv)
          if not argv or type(argv) ~= "table" then
            return false
          end
          return vim.tbl_contains(argv, "-b")
            or vim.tbl_contains(argv, "--remote-wait")
            or vim.tbl_contains(argv, "--remote-wait-sleep")
        end,
      },
    },
  },
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
