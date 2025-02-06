local luasnip = require "luasnip"

-- a lot of this is yanked straight from TJ DeVries' [dotfiles](https://github.com/tjdevries/config.nvim)
-- thanks teej! :)

luasnip.setup {
    enable_autosnippets = true,
    update_events = "TextChanged,TextChangedI",
}

vim.snippet.expand = luasnip.lsp_expand

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
    filter = filter or {}
    filter.direction = filter.direction or 1

    if filter.direction == 1 then
        return luasnip.expand_or_jumpable()
    else
        return luasnip.jumpable(filter.direction)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
    if direction == 1 then
        if luasnip.expandable() then
            return luasnip.expand_or_jump()
        else
            return luasnip.jumpable(1) and luasnip.jump(1)
        end
    else
        return luasnip.jumpable(-1) and luasnip.jump(-1)
    end
end

vim.snippet.stop = luasnip.unlink_current

vim.keymap.set({ "i", "s" }, '<C-j>', function()
    return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
end, { silent = true })

vim.keymap.set({ "i", 's' }, '<C-k>', function()
    return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, '<C-h>', function()
    if luasnip.choice_active() then
        luasnip.change_choice(-1)
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, '<C-l>', function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, { silent = true })

-- snippets for all files
require 'handdara.snippets.all'
require 'handdara.snippets.tex'
require 'handdara.snippets.lua'
require 'handdara.snippets.markdown'
require 'handdara.snippets.matlab'
require 'handdara.snippets.just'
require 'handdara.snippets.nix'
require 'handdara.snippets.stache'
