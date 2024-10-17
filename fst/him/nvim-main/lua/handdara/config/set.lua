-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.hlsearch = false -- highlight on search

vim.wo.number = true   -- Make line numbers default and relative
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim. See `:help 'clipboard'`

vim.o.breakindent = true -- Enable break indent

-- Save undo history
-- vim.o.undodir = os.getenv("HOME") .. "/.local/share/undodir"
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'no'

vim.opt.colorcolumn = { 100 }

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.completeopt = 'menuone,noselect' -- Set for a better completion experience

vim.o.termguicolors = true             -- NOTE: make sure your terminal supports this

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.shell = "fish"

vim.o.splitright = true
vim.o.splitbelow = true
