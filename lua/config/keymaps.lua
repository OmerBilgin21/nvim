-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Define the function to insert the snippet
_G.insert_console_log_snippet = function()
  local filetype = vim.bo.filetype
  local allowed_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

  if vim.tbl_contains(allowed_filetypes, filetype) then
    -- Get the selected text or cursor word
    local selected_text = vim.fn.expand("<cword>")

    -- Insert the snippet at the cursor position
    local snippet = string.format("console.log('%s: ', %s)", selected_text, selected_text)
    vim.api.nvim_command("normal! ciw")
    -- Insert the snippet
    vim.api.nvim_put({ snippet }, "c", true, true)
    -- Move the cursor inside the snippet
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + #selected_text + 13 })
  end
end

return {
  vim.api.nvim_set_keymap("i", "<C-g>", "<cmd>lua insert_console_log_snippet()<CR>", { noremap = true, silent = true }),
  vim.keymap.set("i", "C-c", "<Esc>"),
}

-- ":tabc[lose][!]"
