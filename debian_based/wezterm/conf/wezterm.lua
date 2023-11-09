local wezterm = require 'wezterm'
local config = {}
local hkeys = require 'handdara.keymap'

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'rose-pine'

config.font = wezterm.font('HasklugNerdFontMono')

config.enable_wayland = true
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_frame = {
  font = wezterm.font('HasklugNerdFontMono'),
  font_size = 10.0,
}

config.window_background_opacity = 0.75
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.75,
}

config.default_prog = { 'fish' }

config.disable_default_key_bindings = true
config.keys = hkeys.keys
config.key_tables = hkeys.key_tables

config.unix_domains = {
  {
    name = 'handdara-ubuntu',
  },
}

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
config.default_gui_startup_args = { 'connect', 'handdara-ubuntu' }


return config
