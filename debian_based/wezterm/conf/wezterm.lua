local wezterm = require 'wezterm'
local config = {}
local hkeys = require 'handdara.keymap'

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'rose-pine'

config.font = wezterm.font('HasklugNerdFontMono')

config.enable_wayland = true
config.use_fancy_tab_bar = true
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
  font = wezterm.font('HasklugNerdFontMono'),
  font_size = 10.0,
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#333333',
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

return config
