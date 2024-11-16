local map = vim.keymap.set
vim.opt_local.conceallevel = 0
map('n', '<leader>it', '<CMD>r!today<CR>i##<Space><Esc>_',
  { buffer = true, desc = '[i]nsert [t]oday\'s date as heading' })
map('v', '<leader>t', '!pandoc -t gfm<CR>', { buffer = true, desc = 'format highlighted [T]able' })
map('v', '<leader>T', '!pandoc -t markdown_strict+grid_tables<CR>',
  { buffer = true, desc = 'format highlighted [T]able' })
map('n', '<leader>gt', 'vip!pandoc -t ', { buffer = true })
vim.keymap.set('n', '<leader>nt', function()
  local lc = vim.api.nvim_get_option_value('conceallevel', {})
  if lc == 0 then
    vim.opt_local.conceallevel = 2
  else
    vim.opt_local.conceallevel = 0
  end
end, { desc = '[n]otes [t]oggle conceal' , buffer = true})
