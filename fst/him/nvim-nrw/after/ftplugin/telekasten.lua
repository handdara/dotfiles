vim.keymap.set('n', '<leader>tc', function()
  local lc = vim.api.nvim_get_option_value('conceallevel',{})
  if lc == 0 then
    vim.opt_local.conceallevel = 2
  else
    vim.opt_local.conceallevel = 0
  end
end, { desc = '[t]oggle [c]onceal' })
vim.cmd [[hi link tkTag Constant]] -- custom highlights
vim.cmd [[hi link tkHighlight Constant]]
