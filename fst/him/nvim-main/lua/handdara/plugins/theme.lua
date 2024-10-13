local orbital = {
  'fcpg/vim-orbital',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'orbital'
  end
}

local farenheit = {
  'fcpg/vim-fahrenheit',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'fahrenheit'
  end
}

local rose_pine = {
  'rose-pine/neovim',
  name = 'rose-pine',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'rose-pine'
  end,
}

local modus = { "miikanissi/modus-themes.nvim", priority = 1000 }

local eva01 = {
  "hachy/eva01.vim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "eva01"
    -- or
    -- vim.cmd.colorscheme "eva01-LCL"
  end,
}

local cyberdream = {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      -- Recommended - see "Configuring" below for more config options
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      borderless_telescope = true,
    })
    vim.cmd("colorscheme cyberdream") -- set the colorscheme
  end,
}

local lighthaus = {
  "mrjones2014/lighthaus.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('lighthaus').setup({
      -- set true to use dark bg by default
      bg_dark = false,
      -- see colors.lua to see colors table, set overrides here to be merged with defaults
      colors = {},
      -- set to 'underline' to replace undercurl with underline
      -- or empty string '' to disable
      lsp_underline_style = 'undercurl',
      -- make background transparent, this overrides `bg_dark`
      transparent = true,
      -- use an italic font for comments
      italic_comments = true,
      -- use an italic font for keywords/conditionals
      italic_keywords = false,
    })
    -- local lu = require("lighthaus.utils")
    vim.cmd('hi link LspCodeLens LspInlayHint')
  end,
}

return cyberdream
