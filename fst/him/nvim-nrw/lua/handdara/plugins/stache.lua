return {
    dir = vim.fn.stdpath('config') .. "/lua/stache.nvim",
    opts = { dirs = { data = require 'handdara.util.dirs'.stache.abs } },
}
