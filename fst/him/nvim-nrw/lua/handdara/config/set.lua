return function()
  vim.o.breakindent = true -- Enable break indent
  vim.o.expandtab = true
  vim.o.hlsearch = false -- highlight on search
  vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
  vim.opt.colorcolumn = { 100 }
  vim.o.shiftwidth = 2
  vim.o.showtabline = 0
  vim.o.smartcase = true
  vim.o.softtabstop = 2
  vim.o.splitbelow = true
  vim.o.splitright = true
  vim.o.tabstop = 2
  vim.wo.number = true     -- Make line numbers default and relative
  vim.wo.relativenumber = true
  vim.wo.signcolumn = 'no' -- Keep signcolumn on by default
  vim.o.shell = "fish"
  vim.o.termguicolors = true -- NOTE: make sure your terminal supports this
  --[[
    [!IMPORTANT]
    The next line is a wezterm/neovim display update bug workaround for using nvim in a wezterm mux 
    server. see [this issue](https://github.com/wez/wezterm/issues/4607 ) for more info. Also look 
    at `.../ansible/1-active-quests/hix/nvim-nix-rewrite.md` for more info as well. The bug should 
    be fixed when the fix linked in issue 4607 above is merged into main, and I believe the nightly 
    version of wezterm already includes it.
  ]]
  vim.opt.termsync = false
  vim.o.updatetime = 250 -- Decrease update time
  vim.o.timeoutlen = 300
  vim.o.undofile = true -- Save undo history
end
