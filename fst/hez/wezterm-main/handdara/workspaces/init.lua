local hDirs = require 'handdara.dirs'
local hl = require 'handdara.launch'
local hd = require 'handdara.domains'

local note_args = {}
table.insert(note_args, hl.system_shell.args[1])
table.insert(note_args, '-c')
table.insert(note_args, 'nvim quicklinks.md')

---makes a development workspace based on alphabetic key
---@param key string which key (a through z) to id the wksp with
---@return table
local function mk_dev_wksp(key)
    assert(type(key) == 'string')
    local key_lower = string.lower(key)
    local key_num = string.byte(key_lower, 1, 1)
    local isalpha = (97 <= key_num and key_num <= 122) -- a:97 z:122 A:65 Z:90
    assert((string.len(key_lower) == 1) and isalpha)
    return {
        name = 'dev-' .. key_lower,
        spawn = {
            domain = hd.dev_domain,
        },
    }
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
    mk_dev_wksp = mk_dev_wksp,
}
