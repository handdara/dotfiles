local function set_looks(colorscheme)
  local c = colorscheme or "lunaperche"
  vim.cmd("colorscheme " .. c)
  vim.cmd [[
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
  ]]
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
