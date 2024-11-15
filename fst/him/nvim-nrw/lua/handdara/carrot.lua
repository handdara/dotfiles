local c = require 'carrot'

vim.keymap.set('n', '<leader>ce', function ()
    local prev_ft = vim.bo.filetype
    if prev_ft == "telekasten" then
        vim.bo.filetype = "markdown"
        c.execute_normal()
        vim.bo.filetype = prev_ft
        vim.cmd 'write'
        vim.cmd 'edit'
    end
end, { desc = '[c]arrot: [e]val code block' })
