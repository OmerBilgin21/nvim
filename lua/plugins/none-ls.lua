return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.erb_lint,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.code_actions.gitsigns,
				},
				debug = false,
			})

			vim.keymap.set("n", "<leader>tt", vim.lsp.buf.format, {})
		end,
	},
}
