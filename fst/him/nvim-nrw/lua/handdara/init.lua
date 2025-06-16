local hset = require 'handdara.config.set'
local hkeymap = require 'handdara.config.keymap'
local hcmds = require 'handdara.config.commands'
local hlooks = require 'handdara.config.looks'
local hautocmds = require 'handdara.config.autocommands'

local M = {}

M.setup = function(opts)
    local N = {}
    hset()
    hkeymap()
    hcmds()
    hautocmds()
    local col = opts.colorscheme
    if type(col) == 'string'  then
        hlooks.init_looks(col)
    else
        hlooks.init_looks(col.name, col.is_light)
    end
    require 'handdara.obsidian'
    vim.notify = require('notify')

    N.util = require 'handdara.util'

    N.set_looks = hlooks.set_looks

    return N
end

return M
