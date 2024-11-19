local wezterm = require('wezterm')

return {
    hasklug   = wezterm.font_with_fallback({
        { family = 'Hasklug Nerd Font', weight = 'Regular' },
        { family = 'Symbols Nerd Font Mono', scale = 1 },
    }),
    monofur   = wezterm.font_with_fallback({
        { family = 'Monofur Nerd Font',      weight = 'Regular' },
        { family = 'Symbols Nerd Font Mono', scale = 1 },
    }),
    monoid    = wezterm.font_with_fallback({
        { family = 'Monoid Nerd Font',       weight = 'Regular' },
        { family = 'Symbols Nerd Font Mono', scale = 1 },
    }),
    f3270     = wezterm.font_with_fallback({
        { family = '3270 Nerd Font',         weight = 'Regular' },
        { family = 'Symbols Nerd Font Mono', scale = 1 },
    }),
    agave     = wezterm.font_with_fallback({
        { family = 'Agave Nerd Font',        weight = 'Regular' },
        { family = 'Symbols Nerd Font Mono', scale = 1 },
    }),
    spacemono = wezterm.font_with_fallback({
        { family = 'SpaceMono Nerd Font', weight = 'Regular' },
        { family = 'Symbols Nerd Font Mono',    scale = 1 },
    }),
    firacode  = wezterm.font 'Fira Code',
    jetbrains = wezterm.font 'JetBrains Mono',
}
