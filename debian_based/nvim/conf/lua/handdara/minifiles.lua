require('mini.files').setup({
  mappings = {
    close       = 'q',
    go_in       = 'l',
    go_in_plus  = 'L',
    go_out      = 'h',
    go_out_plus = 'H',
    reset       = '<BS>',
    reveal_cwd  = 'g!',
    show_help   = 'g?',
    synchronize = '=',
    trim_left   = '<',
    trim_right  = '>',
  },
  options = {
    -- Whether to delete permanently or move into module-specific trash
    permanent_delete = false,
    -- Whether to use for editing directories
    -- use_as_default_explorer = true,
  },
  windows = {
    preview = true,
    width_focus = 25,
    width_preview = 70,
  }
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesWindowOpen',
  callback = function(args)
    local win_id = args.data.win_id
    vim.api.nvim_win_set_config(win_id, { border = 'double' })
  end,
})
