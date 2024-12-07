local wezterm = require('wezterm')

local sym_fallback = { family = 'Symbols Nerd Font', scale = 1 }
return {
    hasklug   = wezterm.font_with_fallback({
        { family = 'Hasklug Nerd Font', weight = 'Regular' },
        sym_fallback,
    }),
    monofur   = wezterm.font_with_fallback({
        { family = 'Monofur Nerd Font', weight = 'Regular' },
        sym_fallback,
    }),
    monoid    = wezterm.font_with_fallback({
        { family = 'Monoid Nerd Font', weight = 'Regular' },
        sym_fallback,
    }),
    f3270     = wezterm.font_with_fallback({
        { family = '3270 Nerd Font', weight = 'Regular' },
        sym_fallback,
    }),
    agave     = wezterm.font_with_fallback({
        { family = 'Agave Nerd Font', weight = 'Regular' },
        sym_fallback,
    }),
    hurmit    = wezterm.font 'Hurmit Nerd Font',
    spacemono = wezterm.font 'SpaceMono Nerd Font',
    firacode  = wezterm.font 'Fira Code',
    jetbrains = wezterm.font 'JetBrains Mono',
}
