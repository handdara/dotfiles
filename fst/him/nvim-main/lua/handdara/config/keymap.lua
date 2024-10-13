local wk = require("which-key")

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'Q', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Vex, { desc = "Handdara: `:Vex`" })
-- vim.keymap.set("n", "<leader>pe", vim.cmd.Ex, { desc = "Handdara: `:Ex`" })
-- vim.keymap.set("n", "<leader>ph", vim.cmd.Hex, { desc = "Handdara: `:Hex`" })
vim.keymap.set('n', '<leader>pf', '<CMD>lua MiniFiles.open()<CR>', { desc = 'MiniFiles.open()' })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Handdara: Open undo tree" })

-- Better feeling exit insert mode
vim.keymap.set('i', "jk", "<Esc>")

-- Moving around windows
vim.keymap.set('n', '<leader>tj', '<C-w>j', { desc = 'Move [T]o window down' })
vim.keymap.set('n', '<leader>tk', '<C-w>k', { desc = 'Move [T]o window up' })
vim.keymap.set('n', '<leader>th', '<C-w>h', { desc = 'Move [T]o window left' })
vim.keymap.set('n', '<leader>tl', '<C-w>l', { desc = 'Move [T]o window right' })
vim.keymap.set('n', '<leader>tJ', '<C-w>J', { desc = 'Move window [T]o down' })
vim.keymap.set('n', '<leader>tK', '<C-w>K', { desc = 'Move window [T]o up' })
vim.keymap.set('n', '<leader>tH', '<C-w>H', { desc = 'Move window [T]o left' })
vim.keymap.set('n', '<leader>tL', '<C-w>L', { desc = 'Move window [T]o right' })
vim.keymap.set('t', '<C-Esc>', '<C-\\><C-n>', { desc = 'Close and exit [T]erminal mode', silent = true })
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
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "G", "Gzzzv")

-- telescope
local tbi = require('telescope.builtin')
vim.keymap.set('n', '<leader>gf', tbi.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', tbi.find_files, { desc = '[S]earch [f]iles' })
vim.keymap.set('n', '<leader>sF',
	function() tbi.find_files({ no_ignore = true, no_ignore_parent = true }) end,
	{ desc = '[S]earch [F]iles (include gitignored)' })
vim.keymap.set('n', '<leader>sh', tbi.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', tbi.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', tbi.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', tbi.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', tbi.resume, { desc = '[S]earch [R]esume' })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', tbi.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', tbi.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	tbi.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = true,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- for help mode, easier <C-]>
vim.keymap.set('n', 'g]', '<C-]>', { desc = 'CTRL-], or go down in help' })

-- # Command "remaps"

-- because i always do these
vim.api.nvim_create_user_command('W','write',{})
vim.api.nvim_create_user_command('Wq','wq',{})
vim.api.nvim_create_user_command('Q','quit',{})
vim.api.nvim_create_user_command('Qa','qall',{})
vim.api.nvim_create_user_command('Wqa','wqall',{})
vim.api.nvim_create_user_command('FO','Fo',{})

-- open up gitui
vim.api.nvim_create_user_command('Vtg','vert term gitui',{})

-- telekasten
local tk = require('telekasten')
vim.keymap.set('n', '<leader>n', '<CMD>Telekasten<CR>', { desc = 'Telekasten [S]earch' })
vim.keymap.set('n', '<leader>nw', tk.goto_thisweek, { desc = 'Open Telekaste[n]' })
vim.keymap.set('n', '<leader>nc', tk.toggle_todo, { desc = 'Toggle [C]heckbox `- [ ]`' })
vim.keymap.set('n', '<leader>nd', tk.follow_link, { desc = 'Go [d]own link' })
vim.keymap.set('n', '<leader>nb', tk.show_backlinks, { desc = 'Look at [B]acklinks' })
vim.keymap.set('n', '<leader>ng', tk.show_tags, { desc = 'Show Ta[g]s' })
vim.keymap.set('n', '<leader>nf', tk.find_notes, { desc = '[F]ind notes' })
vim.keymap.set('n', '<leader>nv', tk.switch_vault, { desc = 'Switch [V]ault' })
vim.keymap.set('n', '<leader>ni', tk.insert_link, { desc = '[I]nsert link' })
vim.keymap.set('n', '<leader>sn', tk.search_notes, { desc = '[S]earch [N]otes' })
vim.keymap.set('n', '<leader>nr', tk.rename_note, { desc = '[N]ote: [R]ename' })

-- decisive
vim.keymap.set('n', '<leader>cv', '<CMD>lua require("decisive").align_csv({})<cr>,', { desc = 'Align [C]S[V]' })
vim.keymap.set('n', '<leader>cc', '<CMD>lua require("decisive").align_csv_clear({})<cr>', { desc = '[C]lear [C]SV Align' })
vim.keymap.set('n', '<leader>cp', '<CMD>lua require("decisive").align_csv_prev_col()<cr>', { desc = '[C]SV [P]rev Col' })
vim.keymap.set('n', '<leader>cn', '<CMD>lua require("decisive").align_csv_next_col()<cr>', { desc = '[C]SV [N]ext Col' })
