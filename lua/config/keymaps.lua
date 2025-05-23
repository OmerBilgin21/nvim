local km = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

km.set({ "i", "n", "v", "x" }, "<C-c>", "<esc>", { desc = "control+c acts like esc", noremap = true, silent = true })
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
km.set("n", "<leader>m", "<cmd>Mason<cr>", { noremap = true, silent = true })
km.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
km.set("n", "<leader>sh", "<C-W>s", { desc = "split horizontally", remap = true })
km.set("n", "<leader>sv", "<C-W>v", { desc = "split vertically", remap = true })
km.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
km.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
km.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
km.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
km.set({ "v", "n" }, "<leader>bd", "<cmd>:bd<cr>", { noremap = true, silent = true })
km.set("n", "<leader>rs", function()
  reload_module("print-debugger")
end)
km.set("n", "<F2>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
km.set("n", "<F3>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
km.set("n", "<leader>rm", "<cmd>%s/\r//g<cr>", { desc = "dos 2 unix" })
km.set(
  "x",
  "<leader>rc",
  [[:lua require('vim.lsp.buf').rename(vim.fn.input('New Name: '))<CR>]],
  { noremap = true, silent = true }
)
km.set("n", "<leader><tab>d", "<cmd>tabnew | DBUIToggle<CR>", { desc = "", noremap = true, silent = true })
km.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
km.set("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "New Tab" })
km.set("n", "<leader><tab>n", "<cmd>:tabnext<cr>")
km.set("n", "<leader><tab>p", "<cmd>:tabprevious<cr>")

km.set({ "i", "x", "n", "s" }, "<C-s>", function()
  vim.cmd("w")
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end)
