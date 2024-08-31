local telescope_builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local telescope_config = require("telescope.config")

-- useless lua function so I can learn
function Trial()
	local my_opts = {
		ignore = "*.lock.json",
		hidden = true,
		glob = {
			"",
			"!**/.git/*",
			"!*.lock.json",
		},
	}
	local return_val = telescope_builtin.live_grep(my_opts)
	print(return_val)
end

local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!*.lock.json")

return {
	"nvim-telescope/telescope.nvim",

	opts = {
		pickers = {
			find_files = {
				find_command = {
					"rg",
					"--files",
					"--hidden",
					"--glob",
					"!**/.git/*",
					"--glob",
					-- package.lock.json or yarn version
					-- annoys me quite a bit
					"!*.lock.json",
				},
			},
		},
		defaults = {
			preview = {
				-- quite dangerous to disable this
				-- since I changed the config to recognize
				-- the hidden files as well
				filesize_limit = 1,
			},
			-- for live_grep since apparently it doesn't support
			-- changing the flags natively
			-- so I insert it above to a table and give it here
			vimgrep_arguments = vimgrep_arguments,
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer + actions.move_to_top,
					["<esc>"] = actions.close,
				},
			},
		},
	},

	keys = {

		{ "<leader>po", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>ç", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
		{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
	},
}
