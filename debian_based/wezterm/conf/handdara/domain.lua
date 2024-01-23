local startup_domain = 'local'
local default_unix = 'handdara-hpop'
return {
    unix_domains = {
        {
            name = default_unix,
        },
    },

    startup_domain = startup_domain,
    default_unix = default_unix,
    code = startup_domain,
    wsl = 'WSL:Ubuntu-20.04',
}
