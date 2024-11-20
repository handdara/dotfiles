local hDirs = require 'handdara.dirs'
local hl = require 'handdara.launch'
local hd = require 'handdara.domains'

local note_args = {}
table.insert(note_args, hl.system_shell.args[1])
table.insert(note_args, '-c')
-- table.insert(note_args, 'nvim .')
table.insert(note_args, 'nvim quicklinks.md')

---makes a development workspace based on alphabetic key
---@param key string
---@return table
local function mk_dev_wksp(key)
    -- assert()
    local key_num = string.byte(key,1,1)
    -- local isalpha = (key_num 
    local x = (string.len(key) == 1) && (key[1] )
    local dev_wksp = {
        name = 'dev' .. key,
        spawn = {
            domain = hd.dev_domain,
        },
    }
    return dev_wksp
end

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
            cwd = hDirs.ansible_dir .. '/2-areas/work',
            -- domain = hd.notes_domain, -- debugging issue with separate domains
            domain = hd.dev_domain,
        },
    },
    personal_notes = {
        name = 'personal-notes',
        spawn = {
            args = note_args,
            cwd = hDirs.ansible_dir,
            -- domain = hd.notes_domain,
            domain = hd.dev_domain,
        },
    },
    mega = require('handdara.workspaces.mega'),
}
