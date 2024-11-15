local function set_looks(colorscheme)
  local c = colorscheme or "lunaperche" -- default is lunaperche b/c it's my favorite builtin colorscheme
  vim.cmd("colorscheme " .. c)
  local groups = {
    'Normal',
    'NormalNC',
    'Comment',
    'Constant',
    'Special',
    'Identifier',
    'Statement',
    'PreProc',
    'Type',
    'Underlined',
    'Todo',
    'String',
    'Function',
    'Conditional',
    'Repeat',
    'Operator',
    'Structure',
    'LineNr',
    'NonText',
    'SignColumn',
    'CursorLine',
    'CursorLineNr',
    'EndOfBuffer',
  }
  ---@diagnostic disable-next-line: unused-local
  local extra_groups = {
    'NormalFloat',
    'FloatBorder',
    'WhichKeyBorder',
    'FloatTitle',
    'TelescopeBorder',
    'TelescopeNormal',
  }
  local function apply(grps)
    for _, value in ipairs(grps) do
      vim.cmd('highlight ' .. value .. " guibg=none")
      vim.cmd('highlight ' .. value .. " cterm=none")
    end
  end
  apply(groups)
  apply(extra_groups)
end

local function init_looks(colorscheme)
  -- Highlight when yanking (copying) text
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })
  set_looks(colorscheme)
end

return {
  init_looks = init_looks,
  set_looks = set_looks,
}
