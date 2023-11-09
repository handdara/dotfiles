local wezterm = require 'wezterm'
local act = wezterm.action

return {
  keys = {
    { key = 'l',   mods = 'ALT|SHIFT',  action = act.ActivateTabRelative(1) },
    { key = 'h',   mods = 'ALT|SHIFT',  action = act.ActivateTabRelative(-1) },
    { key = 'F11', mods = 'NONE',       action = act.ToggleFullScreen },
    { key = 'd',   mods = 'ALT',        action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'r',   mods = 'ALT',        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-',   mods = 'ALT',        action = act.DecreaseFontSize },
    { key = '=',   mods = 'ALT',        action = act.IncreaseFontSize },
    { key = 'P',   mods = 'CTRL',       action = act.ActivateCommandPalette },
    { key = 'W',   mods = 'ALT',        action = act.CloseCurrentTab { confirm = true } },
    { key = 't',   mods = 'ALT',        action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w',   mods = 'ALT',        action = act.CloseCurrentPane { confirm = false } },
    { key = 'q',   mods = 'ALT|CTRL',   action = act.QuitApplication },
    { key = 'h',   mods = 'ALT',        action = act.ActivatePaneDirection 'Left' },
    { key = 'l',   mods = 'ALT',        action = act.ActivatePaneDirection 'Right' },
    { key = 'k',   mods = 'ALT',        action = act.ActivatePaneDirection 'Up' },
    { key = 'j',   mods = 'ALT',        action = act.ActivatePaneDirection 'Down' },
    { key = 'p',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { key = 'q',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'quick_mode', one_shot = true } },
    { key = 'm',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'move_mode', one_shot = false } },
    { key = 'v',   mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
    { key = 'c',   mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  },

  key_tables = {
    resize_pane = {
      { key = 'h',      action = act.AdjustPaneSize { 'Left', 1 } },
      { key = 'l',      action = act.AdjustPaneSize { 'Right', 1 } },
      { key = 'k',      action = act.AdjustPaneSize { 'Up', 1 } },
      { key = 'j',      action = act.AdjustPaneSize { 'Down', 1 } },
      { key = 'Escape', action = 'PopKeyTable' },
    },
    quick_mode = {
      { key = 'w',      action = act.SpawnCommandInNewTab { args = { 'fish', '-c', 'mdh qw' } } },
      { key = 'p',      action = act.SpawnCommandInNewTab { args = { 'fish', '-c', 'mdh qp' } } },
      { key = 'Escape', action = 'PopKeyTable' },
    },
    move_mode = {
      { key = 'h',      mods = 'SHIFT',        action = act.MoveTabRelative(-1) },
      { key = 'l',      mods = 'SHIFT',        action = act.MoveTabRelative(1) },
      { key = 'Escape', action = 'PopKeyTable' },
    }
  }
}
