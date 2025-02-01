local d = require('handdara.util.dirs').dailies
return {
    'kmonad/kmonad-vim',
    {
        'NFrid/due.nvim',
        opts = {},
    },
    {
        'rcarriga/nvim-notify',
        opts = {
            background_colour = "#000000",
            render = "compact",
            top_down = false,
        },
    },
    {
        'handdara/calendar-vim',
        config = function ()
            vim.cmd ([[let g:calendar_diary=]] .. d)
            vim.cmd [[let g:calendar_weeknm = 1]]
            vim.cmd [[let g:calendar_monday = 1]]
        end
    },
}
