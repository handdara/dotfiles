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
end
