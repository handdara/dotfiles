local neogit = require 'neogit'
local map = vim.keymap.set

map('n', '<leader>gg', function()
    neogit.open()
end, { desc = 'Open neo[g]it' })
map('n', '<leader>gs', function()
    neogit.open({ kind = 'vsplit' })
end, { desc = 'Open neo[g]it in vertical [s]plit' })
