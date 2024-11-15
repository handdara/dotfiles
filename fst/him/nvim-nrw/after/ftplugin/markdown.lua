local map = vim.keymap.set
vim.opt_local.conceallevel = 2
map('n', '<leader>it', '<CMD>r!today<CR>i##<Space><Esc>_',
  { buffer = true, desc = '[i]nsert [t]oday\'s date as heading' })
map('v', '<leader>t', '!pandoc -t gfm<CR>', { buffer = true, desc = 'format highlighted [T]able' })
map('v', '<leader>T', '!pandoc -t markdown_strict+grid_tables<CR>',
  { buffer = true, desc = 'format highlighted [T]able' })
map('n', '<leader>gt', 'vip!pandoc -t ', { buffer = true })
