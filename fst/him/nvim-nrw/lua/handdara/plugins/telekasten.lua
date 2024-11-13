return {
  'renerocksai/telekasten.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'renerocksai/calendar-vim',
  },
  config = function()
    require 'handdara.telekasten'
  end
}
