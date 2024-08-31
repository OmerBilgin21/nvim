return {
	{
		-- "olimorris/onedarkpro.nvim",
		"navarasu/onedark.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			-- require("onedark").setup({
			-- 	style = "darker",
			-- })
			require("onedark").load()
		end,
		-- opts = function() end,
	},
}
