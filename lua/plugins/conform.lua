local supported = {
	"css",
	"graphql",
	"handlebars",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"jsonc",
	"less",
	"markdown",
	"markdown.mdx",
	"scss",
	"typescript",
	"typescriptreact",
	"vue",
	"yaml",
}

return {
	-- conform
	-- this is kind of an extra unnecessary safety measure
	-- but, I write ts for work so unnecessary measure it is
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			for _, ft in ipairs(supported) do
				opts.formatters_by_ft[ft] = { "prettier" }
			end

			opts.formatters = opts.formatters or {}
			opts.formatters.prettier = true
		end,
	},
}
