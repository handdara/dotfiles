local u = require 'handdara.util'
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options           = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = false,
            globalstatus = true,
            refresh = {
                statusline = 40,
                tabline = 100,
                winbar = 40,
            }
        },
        sections          = {
            lualine_a = { 'mode' },
            lualine_b = {
                {
                    'tabs',
                    mode = 0,
                    path = 0,
                    tabs_color = {
                        active = { fg = '#b968fc' },
                    },
                    -- separator = { left = '', right = '' },
                    separator = { left = '', right = '' },
                    draw_empty = true,
                    symbols = {
                        modified = '󱐋',
                    },
                },
                'branch',
                'diff',
                'diagnostics',
            },
            lualine_c = {
                {
                    'filename',
                    file_status = true,
                    newfile_status = true,
                    path = 1,
                },
            },
            lualine_x = {
                function()
                    local ok, pomo = pcall(require, "pomo")
                    if not ok then
                        return ""
                    end

                    local timer = pomo.get_first_to_finish()
                    if timer == nil then
                        return ""
                    end

                    return "󰄉 " .. tostring(timer)
                end,
                'fileformat',
            },
            lualine_y = {
                'encoding',
                'filetype',
                function()
                    local ts = u.timestamp()
                    return 'WK' .. u.dtnum2str(ts.wk)
                end,
                function()
                    local ts = u.timestamp()
                    return ts.hr .. ts.mi .. ' ' .. ts.sc .. 's'
                end,
            },
            lualine_z = {
                function()
                    local ts = u.timestamp()
                    return ts.yr .. ' ' .. ts.month .. ' ' .. ts.dy .. ', Week ' .. ts.wk .. ', Day ' .. ts.yrdy
                end,
                'progress',
                'location',
            }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline           = {},
        winbar = {
            lualine_z = { 'filename', }
        },
        inactive_winbar = {
            lualine_z = { 'filename', }
        },
        extensions = {}
    },
}
