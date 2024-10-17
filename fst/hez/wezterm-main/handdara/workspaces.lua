local hDirs = require 'handdara.dirs'
local hl = require 'handdara.launch'
local hd = require 'handdara.domains'

local note_args = {}
table.insert(note_args, hl.system_shell.args[1])
table.insert(note_args, '-c')
table.insert(note_args, 'nvim .')

return {
  config = { name = 'config' },
  development = {
    name = 'development',
    spawn = {
      domain = { DomainName = hd.dev_domain },
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
      domain = { DomainName = hd.monitor_domain },
    },
  },
  work_notes = {
    name = 'work-notes',
    spawn = {
      args = note_args,
      cwd = hDirs.ansible_dir .. '/work',
      domain = 'DefaultDomain',
    },
  },
  personal_notes = {
    name = 'personal-notes',
    spawn = {
      args = note_args,
      cwd = hDirs.ansible_dir .. '/personal',
      domain = 'DefaultDomain',
    },
  },
}
