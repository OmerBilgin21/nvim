return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		require("neo-tree").setup({
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				filtered_items = {
					hide_gitignored = false,
					hide_hidden = false,
					hide_dotfiles = false,
				},
			},
			indent_size = 2,
			padding = 1,
			window = {
				position = "right",
			},
		})
		vim.keymap.set({ "n", "v", "x" }, "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
	end,
}
