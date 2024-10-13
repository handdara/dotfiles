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

vim.api.nvim_command("hi tkTag ctermfg=LightGreen guifg=LightGreen")

-- Set up highlighting on yank 
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

