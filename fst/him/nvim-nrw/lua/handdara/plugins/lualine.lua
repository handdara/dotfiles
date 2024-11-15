return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 40,
                tabline = 100,
                winbar = 100,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                {
                    'tabs',
                    mode = 2,
                    -- separator = '',
                    tabs_color = { -- these colors are for the using with the oxocarbon theme
                        -- active = { fg = '#78a9ff', gui = 'bold' },
                        --   inactive = { fg = '#d0d0d0', bg = '#161616' },
                    },
                },
                'branch', 'diff', 'diagnostics',
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
            },
            lualine_y = { 'encoding', 'fileformat', 'filetype' },
            lualine_z = { 'progress', 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    },
}
