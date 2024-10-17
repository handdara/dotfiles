local startup_domain = 'local'
local default_unix = 'handdara-sha76'
local wsl = 'WSL:Ubuntu-20.04'

return {
    unix_domains = {
        { name = default_unix, },
    },
    startup_domain = startup_domain,
    default_unix = default_unix,
    dev_domain = default_unix,
    monitor_domain = default_unix,
    wsl = wsl,
}
