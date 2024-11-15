local ansible_path = vim.fn.expand("~/MEGA/ansible")

local subvault_config = function(vault_name, subdir, subdirs_in_links, tag_notation)
  local vault_subdir = "/" .. (subdir or "")
  return {
    home = ansible_path .. vault_subdir .. vault_name,
    templates = ansible_path .. "/misc/templates",
    tag_notation = tag_notation or ":tag:",
    subdirs_in_links = subdirs_in_links or false,
    command_palette_theme = "dropdown",
  }
end

require('telekasten').setup({
  -- home vault
  home = ansible_path,
  dailies = ansible_path .. '/0-quest-board/dailies',
  weeklies = ansible_path .. '/0-quest-board/weeklies',
  templates = ansible_path .. "/misc/templates",
  tag_notation = ":tag:",
  subdirs_in_links = false,
  command_palette_theme = "dropdown",
  plug_into_calendar = true,
  media_previewer = "telescope-media-files",
  calendar_opts = {
    weeknm = 1,
  },
  clipboard_program = "xclip",
  auto_set_filetype = true,
  auto_set_syntax = true,
  -- template_new_weekly = ,
  journal_auto_open = true,
  -- sub-vaults
  vaults = {
    work = subvault_config("work", "2-build/"),
    dnd = subvault_config("dnd", "2-build/"),
    conlang = subvault_config("conlang", "2-build/dnd/"),
    namer_conlang = subvault_config("namer_conlang", "2-build/dnd/conlang/"),
    tadok = subvault_config("tadok", "2-build/dnd/"),
    finance = subvault_config("finance", "2-build/"),
    what_we_owe = subvault_config("what_we_owe", "2-build/dnd/"),
    stashlog = subvault_config("stashlog", "3-inventory/"),
  },
})

local tk = require('telekasten')
vim.keymap.set('n', '<leader>nn', '<CMD>Telekasten<CR>', { desc = 'Telekasten [S]earch' })
vim.keymap.set('n', '<leader>nw', tk.goto_thisweek, { desc = 'This [w]eek' })
vim.keymap.set('n', '<leader>na', tk.goto_today, { desc = 'This [w]eek' })
vim.keymap.set('n', '<leader>nc', tk.show_calendar, { desc = 'Show [C]alendar' })
vim.keymap.set('n', '<leader>gnc', '<CMD>CalendarT<CR>', { desc = 'Show lar[g]e [C]alendar' })
vim.keymap.set('n', '<leader>nd', tk.follow_link, { desc = 'Go [d]own link' })
vim.keymap.set('n', '<leader>nb', tk.show_backlinks, { desc = 'Look at [B]acklinks' })
vim.keymap.set('n', '<leader>ng', tk.show_tags, { desc = 'Show Ta[g]s' })
vim.keymap.set('n', '<leader>nf', tk.find_notes, { desc = '[F]ind notes' })
vim.keymap.set('n', '<leader>nv', tk.switch_vault, { desc = 'Switch [V]ault' })
vim.keymap.set('n', '<leader>ni', tk.insert_link, { desc = '[I]nsert link' })
vim.keymap.set('n', '<leader>sn', tk.search_notes, { desc = '[S]earch [N]otes' })
vim.keymap.set('n', '<leader>nr', tk.rename_note, { desc = '[N]ote: [R]ename' })
vim.keymap.set('n', '<C-c>', tk.toggle_todo, { desc = 'Toggle Check Box' })

-- trying to fix treesitter parsing of telekasten files
vim.treesitter.language.register('markdown', 'telekasten')
