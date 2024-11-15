local hset = require 'handdara.config.set'
local hkeymap = require 'handdara.config.keymap'
local hcmds = require 'handdara.config.commands'
local hlooks = require 'handdara.config.looks'

local function setup(opts)
    hset()
    hkeymap()
    hcmds()
    hlooks.init_looks(opts.colorscheme)
end

local function mkHUtil()
    HUtil = require 'handdara.util'
end

return {
    setup = setup,
    set_looks = hlooks.set_looks,
    mkHUtil = mkHUtil,
}
