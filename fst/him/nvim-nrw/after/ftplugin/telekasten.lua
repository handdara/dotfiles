local wikilink_regex = '\\[\\[.*\\]\\]'
local mdlink_regex = '\\[[^]]*\\](.*)'
local link_regex = [[\(]].. wikilink_regex ..[[\|]].. mdlink_regex ..[[\)]]

vim.keymap.set('n', '<Tab>', '/'.. wikilink_regex ..'<CR>zz', { desc = 'go to next link', buffer = true })
vim.keymap.set('n', '<S-Tab>', '?'.. wikilink_regex ..'<CR>zz', { desc = 'go to prev link', buffer = true })
vim.keymap.set('n', '<C-Tab>', '/'.. link_regex ..'<CR>zz', { desc = 'go to next link', buffer = true })
vim.keymap.set('n', '<C-S-Tab>', '?'.. link_regex ..'<CR>zz', { desc = 'go to prev link', buffer = true })
-- vim.keymap.set('n', '<leader>nt', function()
--   local lc = vim.api.nvim_get_option_value('conceallevel', {})
--   if lc == 0 then
--     vim.opt_local.conceallevel = 2
--   else
--     vim.opt_local.conceallevel = 0
--   end
-- end, { desc = '[n]otes [t]oggle conceal' , buffer = true})
vim.cmd [[hi link tkTag Constant]] -- custom highlights
-- vim.cmd [[hi link tkHighlight @comment.note]]
vim.cmd [[hi link tkHighlight Visual]]
