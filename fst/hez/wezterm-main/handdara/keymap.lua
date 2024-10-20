local wezterm = require 'wezterm'
local act = wezterm.action
local hWksp = require 'handdara.workspaces'

local key_tables = {
  launch_mode = {
    { key = 'c',      action = act.ShowLauncherArgs { flags = 'FUZZY|COMMANDS' } },
    { key = 'd',      action = act.ShowLauncherArgs { flags = 'FUZZY|DOMAINS' } },
    { key = 'f',      action = act.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' } },
    { key = 'w',      action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
  },
  resize_pane = {
    { key = 'h',      action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'l',      action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'k',      action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'j',      action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
  },
  scroll_mode = {
    { key = 'k',      action = act.ScrollByLine(-1) },
    { key = 'j',      action = act.ScrollByLine(1) },
    { key = 'u',      action = act.ScrollByPage(-0.5) },
    { key = 'd',      action = act.ScrollByPage(0.5) },
    { key = 'g',      action = act.ScrollToTop },
    { key = 'g',      mods = 'SHIFT',                 action = act.ScrollToBottom },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
  },
  -- search_mode = {
  --   { key = 'Enter',  mods = 'NONE', action = act.CopyMode 'PriorMatch' },
  --   { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
  --   { key = 'n',      mods = 'CTRL', action = act.CopyMode 'NextMatch' },
  --   { key = 'p',      mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
  --   { key = 'r',      mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
  --   { key = 'u',      mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
  --   {
  --     key = 'PageUp',
  --     mods = 'NONE',
  --     action = act.CopyMode 'PriorMatchPage',
  --   },
  --   {
  --     key = 'PageDown',
  --     mods = 'NONE',
  --     action = act.CopyMode 'NextMatchPage',
  --   },
  --   { key = 'UpArrow',   mods = 'NONE', action = act.CopyMode 'PriorMatch' },
  --   { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
  -- },
}

local keys = {
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
  { key = 'u',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'scroll_mode', one_shot = false } },
  -- tab & pane mgmt
  { key = 't',   mods = 'ALT|SHIFT',  action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'd',   mods = 'ALT',        action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'r',   mods = 'ALT',        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'w',   mods = 'ALT|CTRL',   action = act.CloseCurrentPane { confirm = false } },
  -- navigation
  { key = 'l',   mods = 'ALT|SHIFT',  action = act.ActivateTabRelative(1) },
  { key = 'h',   mods = 'ALT|SHIFT',  action = act.ActivateTabRelative(-1) },
  { key = 'h',   mods = 'ALT',        action = act.ActivatePaneDirection 'Left' },
  { key = 'l',   mods = 'ALT',        action = act.ActivatePaneDirection 'Right' },
  { key = 'k',   mods = 'ALT',        action = act.ActivatePaneDirection 'Up' },
  { key = 'j',   mods = 'ALT',        action = act.ActivatePaneDirection 'Down' },
  { key = 't',   mods = 'ALT',        action = act.ShowLauncherArgs { flags = 'FUZZY|TABS' } },
  { key = 'x',   mods = 'ALT|SHIFT',  action = act.SwitchToWorkspace(hWksp.misc), },
  { key = 'm',   mods = 'ALT|SHIFT',  action = act.SwitchToWorkspace(hWksp.monitoring), },
  { key = 'w',   mods = 'ALT|SHIFT',  action = act.SwitchToWorkspace(hWksp.work_notes), },
  { key = 'c',   mods = 'ALT|SHIFT',  action = act.SwitchToWorkspace(hWksp.config), },
  { key = 'd',   mods = 'ALT|SHIFT',  action = act.SwitchToWorkspace(hWksp.development), },
  { key = 'e',   mods = 'ALT|SHIFT',  action = act.SwitchToWorkspace(hWksp.personal_notes), },
  { key = 's',   mods = 'ALT|SHIFT',  action = act.SwitchToWorkspace(hWksp.mega), },
  -- { key = 's',   mods = 'ALT|SHIFT',  action = act.SwitchToWorkspace(hWksp.spotify), },
  -- { key = 'r',   mods = 'ALT|SHIFT',  action = act.SwitchToWorkspace(hWksp.hpi), },
}

local copy_mode = {
  { key = 'w',      mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
  { key = 'Enter',  mods = 'NONE',  action = act.CopyMode 'MoveToStartOfNextLine', },
  { key = 'Escape', mods = 'NONE',  action = act.CopyMode 'Close' },
  { key = 'Space',  mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' }, },
  { key = '$',      mods = 'NONE',  action = act.CopyMode 'MoveToEndOfLineContent', },
  { key = ',',      mods = 'NONE',  action = act.CopyMode 'JumpReverse' },
  { key = '_',      mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLine' },
  { key = ';',      mods = 'NONE',  action = act.CopyMode 'JumpAgain' },
  -- { key = 'f',      mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = false } }, },
  -- got to here
  { key = 'H',      mods = 'NONE',  action = act.CopyMode 'MoveToViewportTop' },
  { key = 'L',      mods = 'NONE',  action = act.CopyMode 'MoveToViewportBottom', },
  { key = 'M',      mods = 'NONE',  action = act.CopyMode 'MoveToViewportMiddle', },
  { key = 'O',      mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEndHoriz', },
  { key = 'T',      mods = 'NONE',  action = act.CopyMode { JumpBackward = { prev_char = true } }, },
  { key = 'V',      mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Line' }, },
  { key = '^',      mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLineContent', },
  { key = 'b',      mods = 'NONE',  action = act.CopyMode 'MoveBackwardWord' },
  { key = 'e',      mods = 'NONE',  action = act.CopyMode 'MoveForwardWordEnd', },
  { key = 'f',      mods = 'NONE',  action = act.CopyMode { JumpForward = { prev_char = false } }, },
  { key = 'g',      mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackTop', },
  { key = 'h',      mods = 'NONE',  action = act.CopyMode 'MoveLeft' },
  { key = 'j',      mods = 'NONE',  action = act.CopyMode 'MoveDown' },
  { key = 'k',      mods = 'NONE',  action = act.CopyMode 'MoveUp' },
  { key = 'l',      mods = 'NONE',  action = act.CopyMode 'MoveRight' },
  { key = 'o',      mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEnd', },
  { key = 'q',      mods = 'NONE',  action = act.CopyMode 'Close' },
  { key = 't',      mods = 'NONE',  action = act.CopyMode { JumpForward = { prev_char = true } }, },
  { key = 'v',      mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' }, },
  { key = 'w',      mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
  { key = 'v',      mods = 'CTRL',  action = act.CopyMode { SetSelectionMode = 'Block' }, },
  { key = 'u',      mods = 'CTRL',  action = act.CopyMode { MoveByPage = -0.5 }, },
  { key = 'b',      mods = 'CTRL',  action = act.CopyMode 'PageUp' },
  { key = 'c',      mods = 'CTRL',  action = act.CopyMode 'Close' },
  { key = 'd',      mods = 'CTRL',  action = act.CopyMode { MoveByPage = 0.5 }, },
  -- { key = 'g',      mods = 'CTRL',  action = act.CopyMode 'Close' },
  { key = 'f',      mods = 'CTRL',  action = act.CopyMode 'PageDown' },
  { key = 'b',      mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord', },
  { key = 'g',      mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom', },
  { key = 'H',      mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop', },
  { key = 'L',      mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom', },
  { key = 'M',      mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle', },
  { key = 'O',      mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz', },
  { key = 'T',      mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = true } }, },
  { key = 'V',      mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' }, },
  { key = '^',      mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent', },
  { key = 'b',      mods = 'ALT',   action = act.CopyMode 'MoveBackwardWord' },
  { key = 'f',      mods = 'ALT',   action = act.CopyMode 'MoveForwardWord' },
  { key = 'm',      mods = 'ALT',   action = act.CopyMode 'MoveToStartOfLineContent', },
  {
    key = 'y',
    mods = 'NONE',
    action = act.Multiple {
      { CopyTo = 'ClipboardAndPrimarySelection' },
      { CopyMode = 'Close' },
    },
  },
  { key = 'PageUp',     mods = 'NONE', action = act.CopyMode 'PageUp' },
  { key = 'PageDown',   mods = 'NONE', action = act.CopyMode 'PageDown' },
  { key = 'End',        mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent', },
  { key = 'Home',       mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine', },
  { key = 'LeftArrow',  mods = 'NONE', action = act.CopyMode 'MoveLeft' },
  { key = 'LeftArrow',  mods = 'ALT',  action = act.CopyMode 'MoveBackwardWord', },
  { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight', },
  { key = 'RightArrow', mods = 'ALT',  action = act.CopyMode 'MoveForwardWord', },
  { key = 'UpArrow',    mods = 'NONE', action = act.CopyMode 'MoveUp' },
  { key = 'DownArrow',  mods = 'NONE', action = act.CopyMode 'MoveDown' },
}

local function apply_to_config(config)
  config.disable_default_key_bindings = true -- i like to only use my own keymaps, i'll add more over time but it's pretty minimal rn
  config.keys = keys
  config.key_tables = key_tables
end

return {
  apply_to_config = apply_to_config,
}
