local wezterm = require 'wezterm'
local act = wezterm.action

return {
  keys = {
    { key = 'F11', mods = 'NONE',       action = act.ToggleFullScreen },
    { key = '-',   mods = 'ALT',        action = act.DecreaseFontSize },
    { key = '=',   mods = 'ALT',        action = act.IncreaseFontSize },
    { key = 'p',   mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
    { key = 'q',   mods = 'ALT|CTRL',   action = act.QuitApplication },
    { key = 'v',   mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
    { key = 'c',   mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
    -- key tables
    { key = 'p',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { key = 'f',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'launch_mode', one_shot = true } },
    -- tab & pane mgmt
    { key = 't',   mods = 'ALT|SHIFT',  action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'd',   mods = 'ALT',        action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'r',   mods = 'ALT',        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'w',   mods = 'ALT|CTRL',        action = act.CloseCurrentPane { confirm = false } },
    -- navigation
    { key = 'l',   mods = 'ALT|SHIFT',  action = act.ActivateTabRelative(1) },
    { key = 'h',   mods = 'ALT|SHIFT',  action = act.ActivateTabRelative(-1) },
    { key = 'h',   mods = 'ALT',        action = act.ActivatePaneDirection 'Left' },
    { key = 'l',   mods = 'ALT',        action = act.ActivatePaneDirection 'Right' },
    { key = 'k',   mods = 'ALT',        action = act.ActivatePaneDirection 'Up' },
    { key = 'j',   mods = 'ALT',        action = act.ActivatePaneDirection 'Down' },
    { key = 't',   mods = 'ALT',        action = act.ShowLauncherArgs { flags = 'FUZZY|TABS' } },
    {
      key = 'x',
      mods = 'ALT|SHIFT',
      action = act.SwitchToWorkspace { name = 'miscellaneous' },
    },
    {
      key = 'm',
      mods = 'ALT|SHIFT',
      action = act.SwitchToWorkspace {
        name = 'monitoring',
        spawn = {
          args = { 'htop' },
        },
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
      action = act.SwitchToWorkspace { name = 'code' },
    },
    {
      key = 'd',
      mods = 'ALT|SHIFT',
      action = act.SwitchToWorkspace { name = 'default' },
    },
    {
      key = 'e',
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
      { key = 'c',      action = act.ShowLauncherArgs { flags = 'FUZZY|COMMANDS' } },
      { key = 'd',      action = act.ShowLauncherArgs { flags = 'FUZZY|DOMAINS' } },
      { key = 'f',      action = act.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' } },
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
