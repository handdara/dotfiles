local hDir = require 'handdara.dirs'
local hLaunch = require 'handdara.launch'

local workspaces = {
  config = { name = 'config' },
  development = { name = 'development' },
  misc = { name = 'miscellaneous' },
  hpi = {
    name = 'hpi',
    spawn = {
      args = { 'fish', '-c', 'hpiconnect' }
    },
  },
  spotify = {
    name = 'spotify',
    spawn = {
      args = { 'fish', '-c', 'spt' }
    },
  },
  monitoring = {
    name = 'monitoring',
    spawn = hLaunch.default_monitor,
  },
  work_notes = {
    name = 'work-notes',
    spawn = {
      args = { 'fish', '-c', 'mdh qw' },
      cwd = hDir.ansible_dir .. '/work',
    },
  },
  personal_notes = {
    name = 'personal-notes',
    spawn = {
      args = { 'fish', '-c', 'mdh qp' },
      cwd = hDir.ansible_dir .. '/personal',
    },
  },
}

return workspaces
