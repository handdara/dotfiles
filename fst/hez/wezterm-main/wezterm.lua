local wezterm       = require('wezterm')
local target_triple = wezterm.target_triple

local config        = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

require('handdara.looks').apply_to_config(config)

require('handdara.launch').apply_to_config(config, target_triple)

require('handdara.keymap').apply_to_config(config)

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
  -- window:gui_window():toast_notification('wezterm', 'started!', nil, 4000)
end)

return config
