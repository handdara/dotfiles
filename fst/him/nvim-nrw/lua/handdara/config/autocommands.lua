local hdirs = require 'handdara.util.dirs'
return function()
    -- use register `z` as last location
    local zmark_group = vim.api.nvim_create_augroup('ZMarkPrevLoc', { clear = true })
    vim.api.nvim_create_autocmd('BufLeave', {
        callback = function()
            vim.cmd [[mark z]]
        end,
        group = zmark_group,
        pattern = '*',
    })

    local calcurse = vim.api.nvim_create_augroup('CalcurseMarkdown', { clear = true })
    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        callback = function()
            vim.bo.filetype = "markdown"
        end,
        group = calcurse,
        pattern = '/tmp/calcurse*',
    })
    local calcurse_nts = vim.api.nvim_create_augroup('CalcurseNotes', { clear = true })
    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        callback = function()
            vim.bo.filetype = "markdown"
        end,
        group = calcurse_nts,
        pattern = '~/.local/share/calcurse/notes/*',
    })
    local stache_enter = vim.api.nvim_create_augroup('StacheEnter', { clear = true })
    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        callback = function()
            vim.bo.filetype = "yaml"
        end,
        group = stache_enter,
        pattern = hdirs.stache.abs..'/*',
    })
end
