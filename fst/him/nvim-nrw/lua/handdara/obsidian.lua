local map = vim.keymap.set
local maps = {
    ["<leader>nx"] = {
        modes = 'v',
        action = ":ObsidianExtractNote<CR>",
        opts = { buffer = true },
    },
    ["<leader>nln"] = {
        modes = 'v',
        action = ":ObsidianLinkNew<CR>",
        opts = {},
    },
    ["<leader>nll"] = {
        modes = 'v',
        action = ":ObsidianLink<CR>",
        opts = { buffer = true },
    },
    ["<leader>na"] = {
        modes = 'n',
        action = ":ObsidianToday<CR>",
        opts = {},
    },
    ["<leader>nf"] = {
        modes = 'n',
        action = ":ObsidianQuickSwitch<CR>",
        opts = {},
    },
}
for combos, dat in pairs(maps) do
    map(dat.modes, combos, dat.action, dat.opts )
    print(combos, dat)
end
