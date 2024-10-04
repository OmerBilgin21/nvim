-- _G.insert_console_log_snippet = function()
-- 	local filetype = vim.bo.filetype
-- 	local allowed_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
--
-- 	if vim.tbl_contains(allowed_filetypes, filetype) then
-- 		-- Get the selected text or cursor word
-- 		local selected_text = vim.fn.expand("<cword>")
--
-- 		-- Insert the snippet at the cursor position
-- 		local snippet = string.format("console.log('%s: ', %s)", selected_text, selected_text)
-- 		vim.api.nvim_command("normal! ciw")
-- 		-- Insert the snippet
-- 		vim.api.nvim_put({ snippet }, "c", true, true)
-- 		-- Move the cursor inside the snippet
-- 		local cursor = vim.api.nvim_win_get_cursor(0)
-- 		vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + #selected_text + 13 })
-- 	end
-- end
--
-- _G.insert_console_log_snippet_visual = function()
-- 	local filetype = vim.bo.filetype
-- 	local allowed_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
--
-- 	if vim.tbl_contains(allowed_filetypes, filetype) then
-- 		-- Get the visually selected text start and end positions
-- 		local _, line_start, col_start, _ = unpack(vim.fn.getpos("'<"))
-- 		local _, _, col_end, _ = unpack(vim.fn.getpos("'>"))
--
-- 		-- Adjust the end column to ensure the full selection is included
-- 		col_end = col_end + 1
--
-- 		-- Get the selected text
-- 		local line = vim.fn.getline(line_start)
-- 		local selected_text = string.sub(line, col_start, col_end)
--
-- 		-- Delete the selected text first
-- 		vim.cmd('normal! gv"_d')
--
-- 		-- Insert the console.log snippet
-- 		local snippet = string.format("console.log('%s: ', %s)", selected_text, selected_text)
-- 		vim.api.nvim_put({ snippet }, "c", true, true)
--
-- 		-- Move the cursor inside the snippet
-- 		local cursor = vim.api.nvim_win_get_cursor(0)
-- 		vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + #selected_text + 13 })
-- 	end
-- end

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=200 }
  augroup END
]],
  false
)
