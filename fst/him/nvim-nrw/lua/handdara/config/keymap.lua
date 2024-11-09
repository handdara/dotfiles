vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- space is my leader key
vim.keymap.set('n', 'Q', '<Nop>', { silent = true })
vim.keymap.set('i', 'kk', '<Esc>')                                  -- Better feeling exit insert mode
vim.keymap.set('t', '<C-/><C-/>', '<C-\\><C-n>')                    -- Better feeling exit term mode
vim.keymap.set({ 'n', 'v' }, "<leader>y", [["+y]])                  -- Access system clipboard
vim.keymap.set('n', "<leader>Y", [["+Y]])
vim.keymap.set('n', "<leader>pp", [["+p]], { desc = '[P]aste system clipboard' })
vim.keymap.set('v', "<leader>p", [["_dP]]) -- Dont overwrite after pasting over text
