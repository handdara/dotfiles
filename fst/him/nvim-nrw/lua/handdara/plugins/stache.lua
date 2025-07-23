return {
    dir = vim.fs.normalize('~/code/stache.nvim'),
    opts = { dirs = { data = require 'handdara.util.dirs'.stache.abs } },
}
