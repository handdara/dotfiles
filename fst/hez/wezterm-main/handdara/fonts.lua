local wezterm = require('wezterm')

return {
  hasklig = wezterm.font_with_fallback({
    { family = 'Hasklig',                weight = 'Regular' },
    { family = 'Symbols Nerd Font Mono', scale = 1 },
  }),
  firacode = wezterm.font 'Fira Code',
  jetbrains = wezterm.font 'JetBrains Mono',
}
