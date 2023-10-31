local wk = require("which-key")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Handdara: `:Ex`" })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Handdara: Open undo tree" })

-- Better feeling exit insert mode
vim.keymap.set('i', "<M-c>", "<Esc>")

-- Moving around windows
vim.keymap.set('n', '<leader>tj', '<C-w>j', { desc = 'Move [T]o window down' })
vim.keymap.set('n', '<leader>tk', '<C-w>k', { desc = 'Move [T]o window up' })
vim.keymap.set('n', '<leader>th', '<C-w>h', { desc = 'Move [T]o window left' })
vim.keymap.set('n', '<leader>tl', '<C-w>l', { desc = 'Move [T]o window right' })
wk.register(
	{ t = { name = "+[T]o window", } },
	{ prefix = "<leader>" }
)

-- Access system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>pp", [["+p]], { desc = '[P]aste system clipboard' })

-- Drop delete/paste
vim.keymap.set({"n", "v"}, "<leader>dd", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>dc", [["_c]])

-- Keep in center after move
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
