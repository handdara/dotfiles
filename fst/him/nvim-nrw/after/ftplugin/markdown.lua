vim.opt_local.conceallevel = 2
vim.keymap.set('n', '<leader>it', '<CMD>r!today<CR>i##<Space><Esc>_',
  { buffer = true, desc = '[i]nsert [t]oday\'s date as heading' })
vim.keymap.set('v', '<leader>t', '!pandoc -t gfm<CR>', { buffer = true, desc = 'format highlighted [T]able' })
vim.keymap.set('v', '<leader>T', '!pandoc -t markdown_strict+grid_tables<CR>',
  { buffer = true, desc = 'format highlighted [T]able' })
vim.keymap.set('n', '<leader>gt', 'vip!pandoc -t ', { buffer = true })
