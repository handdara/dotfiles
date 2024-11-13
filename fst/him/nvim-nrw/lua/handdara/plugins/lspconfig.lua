return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
  },
  config = function()
    require 'handdara.lspconfig'
  end,
}
