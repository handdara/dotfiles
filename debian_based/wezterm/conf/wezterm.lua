local wezterm  = require 'wezterm'
local handdara = require 'handdara'

local config   = {}

-- recommended by docs
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- set theme & opacity
config.colors = handdara.colors
config.window_background_opacity = 0.75
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.75,
}

-- set general font
config.font = handdara.font
config.font_size = 14.0

-- making the window layout simple, 99 times out of 100 scaling is handled 
--   by my window manager even in the other cases, i usually just maximize
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_frame = {
  font = handdara.font,
  font_size = 12.0,
}
config.window_padding = {
  left = 4,
  right = 4,
  top = 0,
  bottom = 0,
}
-- i was using a os with wayland, but not atm, i'll uncomment if i go back
-- config.enable_wayland = true

-- open to fish
config.default_prog = { 'fish' }

-- i like to only use my own keymaps, i'll add more over time but it's pretty minimal rn
config.disable_default_key_bindings = true
config.keys = handdara.keys
config.key_tables = handdara.key_tables

-- domains
config.unix_domains = handdara.unix_domains

-- startup
config.default_gui_startup_args = {
  'connect',
  handdara.startup_domain,
  'fish',
  '-i',
  '-C',
  'neofetch',
}

return config
