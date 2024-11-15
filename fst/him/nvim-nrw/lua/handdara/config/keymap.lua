local map = vim.keymap.set

return function()
  map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- space is my leader key
  map('n', 'Q', '<Nop>', { silent = true })
  map('i', 'kk', '<Esc>')                                -- Better feeling exit insert mode
  map('t', '<C-/><C-/>', '<C-\\><C-n>')                  -- Better feeling exit term mode
  map({ 'n', 'v' }, "<leader>y", [["+y]])                -- Access system clipboard
  map('n', "<leader>Y", [["+Y]])
  map('n', "<leader>pp", [["+p]], { desc = '[P]aste system clipboard' })
  map('v', "<leader>p", [["_dP]]) -- Dont overwrite after pasting over text

  -- sorting paragraphs
  map('v', '<leader>s', '!sort<CR>', { desc = '[S]ort highlighted' })
  map('v', '<leader>gs', '!sort -r<CR>', { desc = 'reverse [S]ort highlighted' })

  map('n', '<leader>dt', '<CMD>r!date -u \'+\\%F \\%T\'<CR>', { desc = 'insert [D]ate [T]ime' })

  map('n', '<C-h>', "<C-w><C-h>") -- split movement
  map('n', '<C-j>', "<C-w><C-j>")
  map('n', '<C-k>', "<C-w><C-k>")
  map('n', '<C-l>', "<C-w><C-l>")

  map('n', "<C-,>", "<c-w>5<") -- split resizing
  map('n', "<C-.>", "<c-w>5>")
  map('n', "<C-t>", "<C-W>+")
  map('n', "<C-s>", "<C-W>-")
  map('n', "<C-=>", "<C-W>=")
end
