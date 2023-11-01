function SetHanddaraColor(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

require("rose-pine").setup({
	variant = 'moon',
	disable_background = true,
	disable_float_background = true,
	highlight_groups = {
		TelescopeBorder = { fg = "highlight_high", bg = "none" },
		TelescopeNormal = { bg = "none" },
		TelescopePromptNormal = { bg = "base" },
		TelescopeResultsNormal = { fg = "subtle", bg = "none" },
		TelescopeSelection = { fg = "text", bg = "base" },
		TelescopeSelectionCaret = { fg = "rose", bg = "rose" },

		String = { fg = "love" },
		['@variable.builtin'] = { fg = "gold" },
	},
})
