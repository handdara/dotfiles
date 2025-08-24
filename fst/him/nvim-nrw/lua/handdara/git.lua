local neogit = require 'neogit'
local map = vim.keymap.set

map('n', '<leader>gg', function()
    neogit.open()
end, { desc = 'Open neo[g]it' })
map('n', '<leader>gs', function()
    neogit.open({ kind = 'vsplit' })
end, { desc = 'Open neo[g]it in vertical [s]plit' })

map('n', '<leader>gb', function()
    vim.cmd [[Gitsigns toggle_current_line_blame]]
end, { desc = 'Toggle [g]it [b]lame' })

map('n', ']g', ':Gitsigns next_hunk<CR>', { desc = '[g]itsigns [n]ext hunk' })
map('n', '[g', ':Gitsigns prev_hunk<CR>', { desc = '[g]itsigns [p]rev hunk' })

map('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { desc = 'gitsigns [h]unk [p]review' })
map('n', '<leader>hx', ':Gitsigns reset_hunk<CR>', { desc = 'gitsigns [h]unk reset' })
map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = 'gitsigns [h]unk [s]tage' })
map('n', '<leader>hu', ':Gitsigns undo_stage_hunk<CR>', { desc = 'gitsigns [h]unk [u]ndo last stage' })
