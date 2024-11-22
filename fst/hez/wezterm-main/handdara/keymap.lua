local wezterm = require 'wezterm'
local act = wezterm.action
local ws = require 'handdara.workspaces'

local key_wksps = {
    ['q'] = false, ['w'] = false, ['e'] = ws.personal_notes, ['r'] = ws.monitoring, ['t'] = false, ['y'] = false, ['u'] = false, ['i'] = false, ['o'] = false, ['p'] = false,
        ['a'] = false, ['s'] = false, ['d'] = false, ['f'] = false, ['g'] = ws.mega, ['h'] = false, ['j'] = false, ['k'] = false, ['l'] = false,
            ['z'] = false, ['x'] = ws.misc, ['c'] = ws.config, ['v'] = false, ['b'] = false, ['n'] = false, ['m'] = false,
}

local wksp_keytable = {
    { key = 'q', action = 'PopKeyTable' },
}
for k, v in pairs(key_wksps) do
    local wksp
    if v == false then
        wksp = ws.mk_dev_wksp(k)
    else
        wksp = v
    end
    key_wksps[k] = wksp -- key_wksps is used later
    table.insert(wksp_keytable, { key = k, action = act.SwitchToWorkspace(wksp), })
end

local key_tables = {
    launch_mode = {
        { key = 'q', action = 'PopKeyTable' },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'c', action = act.ShowLauncherArgs { flags = 'FUZZY|COMMANDS' } },
        { key = 'd', action = act.ShowLauncherArgs { flags = 'FUZZY|DOMAINS' } },
        { key = 'f', action = act.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' } },
        { key = 'w', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
        { key = 't', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS' } },
    },
    quit_mode = {
        { key = 'q',      action = 'PopKeyTable' },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'w',      mods = 'ALT',          action = act.CloseCurrentPane { confirm = false } },
        { key = 'q',      mods = 'ALT',          action = act.QuitApplication },
    },
    pane_mode = {
        { key = 'q', action = 'PopKeyTable' },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'h', action = act.AdjustPaneSize { 'Left', 10 } },
        { key = 'l', action = act.AdjustPaneSize { 'Right', 10 } },
        { key = 'k', action = act.AdjustPaneSize { 'Up', 4 } },
        { key = 'j', action = act.AdjustPaneSize { 'Down', 4 } },
        { key = 'H', action = act.AdjustPaneSize { 'Left', 1 } },
        { key = 'L', action = act.AdjustPaneSize { 'Right', 1 } },
        { key = 'K', action = act.AdjustPaneSize { 'Up', 1 } },
        { key = 'J', action = act.AdjustPaneSize { 'Down', 1 } },
        { key = 'd', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = 'r', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = 'r', mods = 'SHIFT', action = act.RotatePanes 'Clockwise' },
    },
    tab_mode = {
        { key = 'q', action = 'PopKeyTable' },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 'l', action = act.ActivateTabRelative(1) },
        { key = 'h', action = act.ActivateTabRelative(-1) },
    },
    scroll_mode = {
        { key = 'q', action = 'PopKeyTable' },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'k', action = act.ScrollByLine(-1) },
        { key = 'j', action = act.ScrollByLine(1) },
        { key = 'u', action = act.ScrollByPage(-0.5) },
        { key = 'd', action = act.ScrollByPage(0.5) },
        { key = 'g', action = act.ScrollToTop },
        { key = 'g', mods = 'SHIFT',                 action = act.ScrollToBottom },
    },
    test_mode = wksp_keytable,
}

local keys = {
    { key = 'F11', mods = 'NONE',       action = act.ToggleFullScreen },
    { key = '-',   mods = 'ALT',        action = act.DecreaseFontSize },
    { key = '=',   mods = 'ALT',        action = act.IncreaseFontSize },
    { key = 'p',   mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
    { key = 'v',   mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
    { key = 'c',   mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
    -- key tables
    { key = 'p',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'pane_mode', one_shot = false } },
    { key = 'f',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'launch_mode', one_shot = true } },
    { key = 'u',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'scroll_mode', one_shot = false } },
    { key = 's',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'test_mode', one_shot = true } },
    { key = 'q',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'quit_mode', one_shot = true } },
    { key = 't',   mods = 'ALT',        action = act.ActivateKeyTable { name = 'tab_mode', one_shot = true } },
    -- navigation
    { key = 'h',   mods = 'ALT',        action = act.ActivatePaneDirection 'Left' },
    { key = 'l',   mods = 'ALT',        action = act.ActivatePaneDirection 'Right' },
    { key = 'k',   mods = 'ALT',        action = act.ActivatePaneDirection 'Up' },
    { key = 'j',   mods = 'ALT',        action = act.ActivatePaneDirection 'Down' },
    { key = '1',   mods = 'CTRL',       action = act.ActivateTab(0), },
    { key = '2',   mods = 'CTRL',       action = act.ActivateTab(1), },
    { key = '3',   mods = 'CTRL',       action = act.ActivateTab(2), },
    { key = '4',   mods = 'CTRL',       action = act.ActivateTab(3), },
    { key = '5',   mods = 'CTRL',       action = act.ActivateTab(4), },
    { key = '6',   mods = 'CTRL',       action = act.ActivateTab(5), },
    { key = '7',   mods = 'CTRL',       action = act.ActivateTab(6), },
    { key = '8',   mods = 'CTRL',       action = act.ActivateTab(7), },
    { key = '9',   mods = 'CTRL',       action = act.ActivateTab(8), },
}

for i = 1, 9, 1 do
    local k = tostring(i)
    table.insert(keys, { key = k, mods = 'CTRL', action = act.ActivateTab(i - 1) })
end

for _, value in ipairs({'x', 'm', 'w', 'c', 'e', 'a', 's', 'd', 'f', 'g'}) do
    table.insert(keys,
        { key = value,   mods = 'ALT|CTRL',   action = act.SwitchToWorkspace(key_wksps[value]), }
    )
end

local function apply_to_config(config)
    config.disable_default_key_bindings = true -- i like to only use my own keymaps, i'll add more over time but it's pretty minimal rn
    config.keys = keys
    config.key_tables = key_tables
end

return {
    apply_to_config = apply_to_config,
}
