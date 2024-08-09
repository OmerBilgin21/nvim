local actions = require("telescope.actions")

return {
	"nvim-telescope/telescope.nvim",
	config = {
		defaults = {
			mappings = {
				i = {
					["<esc>"] = actions.close,
				},
			},
		},
	},

	keys = {
		{ "<leader>po", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>ç", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
	},
}
