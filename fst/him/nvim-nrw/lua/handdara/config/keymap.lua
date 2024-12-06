local map = vim.keymap.set

return function()
    map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- space is my leader key
    map('n', 'Q', '<Nop>', { silent = true })
    map('i', 'jk', '<Esc>')                                  -- Better feeling exit insert mode
    map('i', 'kj', '<Esc>')                                  -- Better feeling exit insert mode
    map('t', '<C-/><C-/>', '<C-\\><C-n>')                    -- Better feeling exit term mode
    map({ 'n', 'v' }, "<leader>y", [["+y]])                  -- Access system clipboard
    map('n', "<leader>Y", [["+Y]])
    map('n', "<leader>pp", [["+p]], { desc = '[P]aste system clipboard' })
    map('v', "<leader>p", [["_dP]]) -- Dont overwrite after pasting over text

    -- sorting paragraphs
    map('v', '<leader>s', '!sort<CR>', { desc = '[S]ort highlighted' })
    map('v', '<leader>S', '!sort -r<CR>', { desc = 'reverse [S]ort highlighted' })

    map('n', '<leader>dt', '<CMD>r!date -u \'+\\%F \\%T\'<CR>', { desc = 'insert [D]ate [T]ime' })

    map('n', '<C-h>', "<C-w><C-h>") -- split movement
    map('n', '<C-j>', "<C-w><C-j>")
    map('n', '<C-k>', "<C-w><C-k>")
    map('n', '<C-l>', "<C-w><C-l>")

    map('n', "<C-,>", "<c-w>5<") -- split resizing
    map('n', "<C-.>", "<c-w>5>")
    map('n', "<C-t>", "<C-W>+")
    map('n', "<C-b>", "<C-W>-")
    map('n', "<C-=>", "<C-W>=")

    map('n', "<C-a>", "mz'A`z") -- "quick-use" global marks
    map('n', "<C-s>", "mz'S`z")
    map('n', "<C-d>", "mz'D`z")
    map('n', "<C-f>", "mz'F`z")
    map('n', "<C-g>", "mz'G`z")
    map('n', "<C-S-a>", "mA")
    map('n', "<C-S-s>", "mS")
    map('n', "<C-S-d>", "mD")
    map('n', "<C-S-f>", "mF")
    map('n', "<C-S-g>", "mG")

    -- Diagnostic keymaps
    map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

    -- working with views
    map('n', 'zl', '<CMD>loadview<CR>', { desc = 'load [v]iew for current file' })
    map('n', 'zk', '<CMD>mkview<CR>', { desc = 'ma[k]e view for current file' })
end
