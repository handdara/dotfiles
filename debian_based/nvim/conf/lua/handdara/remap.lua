local wk = require("which-key")

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Vex, { desc = "Handdara: `:Vex`" })
-- vim.keymap.set("n", "<leader>pe", vim.cmd.Ex, { desc = "Handdara: `:Ex`" })
-- vim.keymap.set("n", "<leader>ph", vim.cmd.Hex, { desc = "Handdara: `:Hex`" })
vim.keymap.set('n', '<leader>pf', '<CMD>lua MiniFiles.open()<CR>', { desc = 'MiniFiles.open()' })
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

-- Dont overwrite after pasting over text
vim.keymap.set("v", "<leader>p", [["_dP]])

-- Keep in center after move
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- telescope
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

