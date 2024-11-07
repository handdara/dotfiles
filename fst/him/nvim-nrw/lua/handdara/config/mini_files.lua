require('mini.files').setup({
  -- Customization of shown content
  content = {
    filter = nil, -- Predicate for which file system entries to show
    prefix = nil, -- What prefix to show to the left of file system entry
    sort = nil, -- In which order to show file system entries
  },

  mappings = { -- Module mappings created only inside explorer.
    close       = 'q',
    go_in       = 'L',
    go_in_plus  = '<CR>',
    go_out      = 'H',
    go_out_plus = '', -- Use `''` (empty string) to not create one.
    mark_goto   = "'",
    mark_set    = 'm',
    reset       = '<BS>',
    reveal_cwd  = '@',
    show_help   = 'g?',
    synchronize = 's',
    trim_left   = '<',
    trim_right  = '>',
  },

  options = { -- General options
    permanent_delete = false, -- Whether to delete permanently or move into module-specific trash
    use_as_default_explorer = true, -- Whether to use for editing directories
  },

  windows = { -- Customization of explorer windows
    max_number = math.huge, -- Maximum number of windows to show side by side
    preview = true,
    width_focus = 25, -- Width of focused window
    width_nofocus = 25, -- Width of non-focused window
    width_preview = 100, -- Width of preview window
  },
})

vim.keymap.set('n', '<leader>o', function() MiniFiles.open(vim.api.nvim_buf_get_name(0), false) end, { desc = '[O]pen file browser at current file' })
vim.keymap.set('n', '<leader>go', function() MiniFiles.open() end, { desc = '[O]pen file browser' })

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesWindowOpen',
  callback = function(args)
    local win_id = args.data.win_id
    vim.wo[win_id].winblend = 30 -- Customize window-local settings
    vim.wo[win_id].number = true
    vim.wo[win_id].relativenumber = true
    vim.api.nvim_win_set_config(win_id, { border = 'double' })
  end,
})
