return {
	"OmerBilgin21/print-debugger.nvim",
	version = false,
	-- dir = "/home/omer/projects/print-debugger",
	config = function()
		require("print-debugger").setup({
			keymaps = {
				"<C-g>",
			},
		})
	end,
}
