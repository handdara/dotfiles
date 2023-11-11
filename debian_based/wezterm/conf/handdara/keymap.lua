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
    { key = 't',   mods = 'ALT|SHIFT',  action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w',   mods = 'ALT',        action = act.CloseCurrentPane { confirm = false } },
    { key = 'q',   mods = 'ALT|CTRL',   action = act.QuitApplication },
    { key = 'h',   mods = 'ALT',        action = act.ActivatePaneDirection 'Left' },
    { key = 'l',   mods = 'ALT',        action = act.ActivatePaneDirection 'Right' },
    { key = 'k',   mods = 'ALT',        action = act.ActivatePaneDirection 'Up' },
    { key = 'j',   mods = 'ALT',        action = act.ActivatePaneDirection 'Down' },
    { key = 'p',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { key = 'f',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'launch_mode', one_shot = true } },
    { key = 'v',   mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
    { key = 'c',   mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
    { key = 't',   mods = 'ALT',        action = act.ShowLauncherArgs { flags = 'FUZZY|TABS' } },
    {
      key = 'x',
      mods = 'ALT|SHIFT',
      action = act.SwitchToWorkspace {
        name = 'miscellaneous',
      },
    },
    {
      key = 's',
      mods = 'ALT|SHIFT',
      action = act.SwitchToWorkspace {
        name = 'spotify',
        spawn = {
          args = { 'fish', '-c', 'spt' }
        },
      },
    },
    {
      key = 'r',
      mods = 'ALT|SHIFT',
      action = act.SwitchToWorkspace {
        name = 'hpi',
        spawn = {
          args = { 'fish', '-c', 'hpiconnect' }
        },
      },
    },
    {
      key = 'w',
      mods = 'ALT|SHIFT',
      action = act.SwitchToWorkspace {
        name = 'work-notes',
        spawn = {
          args = { 'fish', '-c', 'mdh qw' },
          cwd = '~/ansible',
        },
      },
    },
    {
      key = 'c',
      mods = 'ALT|SHIFT',
      action = act.SwitchToWorkspace {
        name = 'code',
      },
    },
    {
      key = 'd',
      mods = 'ALT|SHIFT',
      action = act.SwitchToWorkspace {
        name = 'default',
      },
    },
    {
      key = 'p',
      mods = 'ALT|SHIFT',
      action = act.SwitchToWorkspace {
        name = 'personal-notes',
        spawn = {
          args = { 'fish', '-c', 'mdh qp' },
          cwd = '~/ansible',
        },
      },
    },
  },

  key_tables = {
    launch_mode = {
      { key = 'a',      action = act.ShowLauncher },
      { key = 'c',      action = act.ShowLauncherArgs { flags = 'FUZZY|COMMANDS' } },
      { key = 'd',      action = act.ShowLauncherArgs { flags = 'FUZZY|DOMAINS' } },
      { key = 'f',      action = act.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' } },
      -- { key = 't',      action = act.ShowLauncherArgs { flags = 'FUZZY|TABS' } },
      { key = 'w',      action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
      { key = 'Escape', action = 'PopKeyTable' },
    },
    resize_pane = {
      { key = 'h',      action = act.AdjustPaneSize { 'Left', 1 } },
      { key = 'l',      action = act.AdjustPaneSize { 'Right', 1 } },
      { key = 'k',      action = act.AdjustPaneSize { 'Up', 1 } },
      { key = 'j',      action = act.AdjustPaneSize { 'Down', 1 } },
      { key = 'Escape', action = 'PopKeyTable' },
    },
  }
}
