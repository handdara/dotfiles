return {
    'renerocksai/telekasten.nvim',
    enabled = false,
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'renerocksai/calendar-vim',
        },
    config = function()
        require 'handdara.telekasten'
    end
}
