vim.opt.guicursor = "i:blinkwait700-blinkoff400-blinkon250"
_G.SetTheBackground = function()
	local list_of_bffrs = {
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLine",
		"CursorLineNr",
		"StatusLine",
		"StatusLineNC",
		"EndOfBuffer",
		--  here we could also set the following
		--  NeoTreeNormal
		--  NeoTreeNormalNC
		-- However, I don't like the neo-tree transparent
		-- so yeah, it's not
	}
	for _, item in ipairs(list_of_bffrs) do
		vim.api.nvim_set_hl(0, item, { bg = "none" })
	end
end

SetTheBackground()
