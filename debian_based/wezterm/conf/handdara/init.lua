local wezterm = require('wezterm')
local hColors = require('handdara.colors')
local hKeymap = require('handdara.keymap')
local hDomain = require('handdara.domain')

return {
    colors = hColors.colors,
    keys = hKeymap.keys,
    key_tables = hKeymap.key_tables,
    unix_domains = hDomain.unix_domains,
    font = wezterm.font_with_fallback({
        { family = "Hasklig",                weight = "Regular" },
        { family = "Symbols Nerd Font Mono", scale = 1 },
    }),
    startup_domain = hDomain.startup_domain,
}
