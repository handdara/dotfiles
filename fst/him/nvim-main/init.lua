-- WARNING: Setting the leader key must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.shortmess:append({ I = true })                      -- disable startup screen

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim' -- Install package manager
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup("handdara.plugins", {}) -- load my plugins
require("handdara.config")                    -- do configuration
