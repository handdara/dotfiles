local hDirs = require 'handdara.dirs'
local hl = require 'handdara.launch'
local hd = require 'handdara.domains'

local note_args = {}
table.insert(note_args, hl.system_shell.args[1])
table.insert(note_args, '-c')
table.insert(note_args, 'nvim .')

return {
  config = {
    name = 'config',
    spawn = { cwd = hDirs.home_dir .. '/code/dotfiles' }
  },
  development = {
    name = 'development',
    spawn = {
      domain = hd.dev_domain,
    },
  },
  misc = { name = 'miscellaneous' },
  hpi = {
    name = 'hpi',
    spawn = {
      args = { 'fish', '-c', 'hpiconnect' },
      domain = 'DefaultDomain',
    },
  },
  spotify = {
    name = 'spotify',
    spawn = {
      args = { 'fish', '-c', 'spt' },
      domain = 'DefaultDomain',
    },
  },
  monitoring = {
    name = 'monitoring',
    spawn = {
      args = hl.default_monitor.args,
      domain = hd.monitor_domain,
    },
  },
  work_notes = {
    name = 'work-notes',
    spawn = {
      args = note_args,
      cwd = hDirs.ansible_dir .. '/work',
      -- domain = hd.notes_domain, -- debugging issue with separate domains
      domain = hd.dev_domain,
    },
  },
  personal_notes = {
    name = 'personal-notes',
    spawn = {
      args = note_args,
      cwd = hDirs.ansible_dir .. '/personal',
      -- domain = hd.notes_domain,
      domain = hd.dev_domain,
    },
  },
}
