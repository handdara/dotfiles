function SetHanddaraColor(color)
	color = color or "modus"
	vim.cmd.colorscheme(color)
end

vim.cmd.colorscheme("modus")

require("ibl").setup({
	scope = {enabled = false},
})

require("transparent").setup({ -- Optional, you don't have to run setup.
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  extra_groups = {
    "NormalFloat",
    "FloatBorder",
    "FloatTitle",
    "TelescopeBorder",
    "TelescopeNormal",
  },
  exclude_groups = {}, -- table: groups you don't want to clear
})
