local startup_domain = 'local'
local default_unix = 'handdara-sha76'
local notes_unix = 'handdara-sha76-ansible'
local wsl = 'WSL:Ubuntu-20.04'

local local_dir = require('handdara.dirs').home_dir .. '.local/'

-- local monitor_domain = { DomainName = default_unix }
local monitor_domain = 'DefaultDomain'

return {
    unix_domains = {
        {
            name = default_unix,
            -- socket_path = local_dir .. 'share/wezterm/' .. default_unix .. '/sock',
        },
        {
            name = notes_unix,
            -- socket_path = local_dir .. 'share/wezterm/' .. notes_unix .. '/sock',
        },
    },
    startup_domain = startup_domain,
    default_unix = default_unix,
    dev_domain = { DomainName = default_unix },
    monitor_domain = monitor_domain,
    notes_domain = { DomainName = notes_unix },
    wsl = wsl,
}
