local hset = require 'handdara.config.set'
local hkeymap = require 'handdara.config.keymap'
local hcmds = require 'handdara.config.commands'
local hlooks = require 'handdara.config.looks'

local function setup(opts)
    hset()
    hkeymap()
    hcmds()
    local col = opts.colorscheme
    if type(col) == 'string'  then
        hlooks.init_looks(col)
    else
        hlooks.init_looks(col.name, col.is_light)
    end
end

local function mkHUtil()
    HUtil = require 'handdara.util'
end

return {
    setup = setup,
    set_looks = hlooks.set_looks,
    mkHUtil = mkHUtil,
}
