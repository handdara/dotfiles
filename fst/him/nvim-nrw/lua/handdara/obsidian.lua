local map = vim.keymap.set
local maps = {
    ["<leader>nx"] = {
        modes = 'v',
        action = ":ObsidianExtractNote<CR>",
        opts = {},
    },
    ["<leader>nln"] = {
        modes = 'v',
        action = ":ObsidianLinkNew<CR>",
        opts = {},
    },
    ["<leader>nll"] = {
        modes = 'v',
        action = ":ObsidianLink<CR>",
        opts = {},
    },
    ["<leader>nt"] = {
        modes = 'n',
        action = ":ObsidianTags<CR>",
        opts = {},
    },
    ["<leader>na"] = {
        modes = 'n',
        action = ":ObsidianToday<CR>",
        opts = {},
    },
    ["<leader>nA"] = {
        modes = 'n',
        action = ":ObsidianTomorrow<CR>",
        opts = {},
    },
    ["<leader>nz"] = {
        modes = 'n',
        action = ":ObsidianYesterday<CR>",
        opts = {},
    },
    ["<leader>gnf"] = {
        modes = 'n',
        action = ":ObsidianFollowLink<CR>",
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
end
