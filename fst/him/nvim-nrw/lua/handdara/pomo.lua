require('pomo').setup {
    -- How often the notifiers are updated.
    update_interval = 500,
    -- Configure the default notifiers to use for each timer.
    -- You can also configure different notifiers for timers given specific names, see
    -- the 'timers' field below.
    notifiers = {
        -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
        {
            name = "Default",
            opts = {
                -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
                -- continuously displayed. If you only want a pop-up notification when the timer starts
                -- and finishes, set this to false.
                sticky = true,
                -- Configure the display icons:
                title_icon = "",
                text_icon = "",
            },
        },
        -- The "System" notifier sends a system notification when the timer is finished.
        -- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
        { name = "System" },
        -- You can also define custom notifiers by providing an "init" function instead of a name.
        -- { init = function(timer) ... end }
    },
    timers = { -- Override the notifiers for specific timer names.
        -- For example, use only the "System" notifier when you create a timer called "Break",
        -- e.g. ':TimerStart 2m Break'.
        Break = { { name = "System" }, },
    },
    sessions = {
        pomodoro = { -- session configuration for a session called "pomodoro"
            { name = "Work",        duration = "25m" },
            { name = "Short Break", duration = "5m" },
            { name = "Work",        duration = "25m" },
            { name = "Short Break", duration = "5m" },
            { name = "Work",        duration = "25m" },
            { name = "Long Break",  duration = "15m" },
        },
    },
}

vim.keymap.set('n', '<leader>ps', ':TimerSession pomodoro<cr>', { desc = '[s]tart [p]omodoro' })
vim.keymap.set('n', '<leader>pk', ':TimerStop<cr>', { desc = '[k]ill [p]omodoro-timer' })
vim.keymap.set('n', '<leader>pt', ':TimerStart 10m work-sesh', { desc = 'start  sessioncustom [p]omodoro [t]imer' })
vim.keymap.set('n', '<leader>ph', ':TimerHide<cr>', { desc = '[h]ide [p]omodoro' })
vim.keymap.set('n', '<leader>pH', ':TimerShow<cr>', { desc = 's[H]ow [p]omodoro' })
vim.keymap.set('n', '<leader>pp', ':TimerShow<cr>', { desc = '[p]ause [p]omodoro' })
vim.keymap.set('n', '<leader>pr', ':TimerShow<cr>', { desc = '[r]esume [p]omodoro' })
