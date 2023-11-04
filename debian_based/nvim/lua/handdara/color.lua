function SetHanddaraColor(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

require("rose-pine").setup({
	variant = 'moon',
	disable_background = true,
	disable_float_background = true,

	groups = {
		error = '#ff3333',
	},

	highlight_groups = {
		TelescopeBorder = { fg = "highlight_high", bg = "none" },
		TelescopeNormal = { bg = "none" },
		TelescopePromptNormal = { bg = "base" },
		TelescopeResultsNormal = { fg = "subtle", bg = "none" },
		TelescopeSelection = { fg = "text", bg = "base" },
		TelescopeSelectionCaret = { fg = "rose", bg = "rose" },

		String = { fg = "love" },
		Special = { fg = "gold" },
		['@variable.builtin'] = { fg = "gold" },
		['@function.builtin'] = { fg = "gold" },
	},
})
