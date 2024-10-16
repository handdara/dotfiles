local wezterm = require('wezterm')

return {
  hasklug = wezterm.font_with_fallback({
    { family = 'Hasklug Nerd Font',      weight = 'Regular' },
    { family = 'Symbols Nerd Font Mono', scale = 1 },
  }),
  firacode = wezterm.font 'Fira Code',
  jetbrains = wezterm.font 'JetBrains Mono',
}
