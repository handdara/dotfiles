local ta = require 'telescope.actions'
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-v>'] = false,
                ['<C-s>'] = ta.select_vertical,
            },
            n = {
                ['<C-v>'] = false,
                ['<C-s>'] = ta.select_vertical,
            },
        },
        border = true,
    },
    pickers = {
        find_files = { theme = "ivy" },
        git_files = { theme = "ivy" },
        marks = { theme = "cursor" },
        commands = { theme = "cursor" },
        oldfiles = { theme = "ivy" },
        grep_string = { theme = "ivy" },
        live_grep = { theme = "ivy" },
        buffers = { theme = "dropdown" },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
        },
        media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg"
        }
    }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('media_files')

-- telescope keymaps
local tbi = require('telescope.builtin')
vim.keymap.set('n', '<leader>gf', tbi.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', tbi.find_files, { desc = '[S]earch [f]iles' })
vim.keymap.set('n', '<leader>sF', function() tbi.find_files({ no_ignore = true, no_ignore_parent = true }) end,
    { desc = '[S]earch [F]iles (include gitignored)' })
vim.keymap.set('n', '<leader>sh', tbi.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', tbi.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', tbi.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', tbi.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', tbi.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sm', tbi.marks, { desc = '[S]earch [M]arks' })
vim.keymap.set('n', '<leader>sj', tbi.jumplist, { desc = '[S]earch [J]umplist' })
vim.keymap.set('n', '<leader>st', function()
    tbi.builtin(require('telescope.themes').get_ivy({}))
end, { desc = '[S]earch [T]elescope' })
vim.keymap.set('n', '<leader>sc', tbi.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>?', tbi.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', tbi.buffers, { desc = '[ ] Find existing buffers' })
-- You can pass additional configuration to telescope to change theme, layout, etc.
vim.keymap.set('n', '<leader>/', function()
        tbi.current_buffer_fuzzy_find(require('telescope.themes').get_ivy { winblend = 10, previewer = true, })
    end,
    { desc = '[/] Fuzzily search in current buffer' })
