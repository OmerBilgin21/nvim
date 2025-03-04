local km = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

km.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
km.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
km.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
km.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
km.set("n", "<S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
km.set("n", "<S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
km.set("n", "<S-left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
km.set("n", "<S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
km.set("n", "yy", [["+Y]])
km.set({ "n", "v" }, "y", [["+y]])
km.set("n", "<C-d>", "15<C-d>zz", { noremap = true })
km.set("n", "<C-u>", "15<C-u>zz", { noremap = true })
km.set({ "n", "v" }, "-", "$", { noremap = true, silent = true })
km.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
km.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
km.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
km.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
km.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
km.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
km.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
km.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

km.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
km.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
km.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
km.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })

km.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
km.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
km.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
km.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
km.set({ "v", "n" }, "<leader>bd", "<cmd>:bd<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rs", function()
  local module_name = vim.fn.input("Enter module name:")
  reload_module(module_name)
end)

km.set("n", "<leader>rc", function()
  local replace_from = vim.fn.input("Replace from:")
  local replace_to = vim.fn.input("Replace to:")

  local cmd_str = string.format("/%s/%s/gc", replace_from, replace_to)
  cmd_str = "%s" .. cmd_str
  print(cmd_str)
  vim.cmd(cmd_str)
end, { noremap = true, silent = true })

km.set({ "i", "x", "n", "s" }, "<C-s>", function()
  vim.lsp.buf.format()
  vim.cmd("w")
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end)
