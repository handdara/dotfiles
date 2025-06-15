return {
    dir = vim.fn.stdpath('config') .. "/lua/stache",
    dev = true,
    config = function()
       require 'stache'
    end
}
