local wezterm = require('wezterm')

local hColors = require('handdara.colors')
local hKeymap = require('handdara.keymap')
local hDomain = require('handdara.domain')
local hLaunch = require('handdara.launch')
local hFonts  = require('handdara.fonts')
local hWksp   = require('handdara.workspaces')
-- local hMachines = require('handdara.machines')

local function mkConfig(xclipFound)
  local config = {}
  if wezterm.config_builder then
    config = wezterm.config_builder()
  end

  local launchTable = hLaunch.mkLaunchTable(xclipFound)
  local wkspTbl = hWksp.mkWkspTbl(launchTable)
  local keys = hKeymap.mkKeys(wkspTbl)
  local keyTbls = hKeymap.mkKeyTbls(wkspTbl)

  -- set theme & opacity
  config.colors = hColors.colors
  config.window_background_opacity = 0.75
  config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.75,
  }

  -- fonts and window settings
  local default_font = hFonts.hasklug
  local default_font_size = 13.0
  config.font = default_font
  config.font_size = default_font_size
  config.enable_tab_bar = false        -- making the window layout simple, 99 times out of 100 scaling is handled
  config.window_decorations = "RESIZE" -- by my window manager even in the other cases, i usually just maximize
  config.window_frame = {
    font = hFonts.hasklug,
    font_size = default_font_size,
  }
  config.window_padding = {
    left = 4,
    right = 4,
    top = 0,
    bottom = 0,
  }
  config.enable_wayland = true               -- i was using a os with wayland, but not atm, i'll uncomment if i go back

  config.disable_default_key_bindings = true -- i like to only use my own keymaps, i'll add more over time but it's pretty minimal rn
  config.keys = keys
  config.key_tables = keyTbls

  config.default_prog = launchTable.shells.fish.args
  config.unix_domains = hDomain.unix_domains
  config.launch_menu = launchTable.launch_menu
  if wezterm.target_triple == "x86_64-windows-msvc" then
    config.default_domain = hDomain.wsl_domain
  else
    config.default_gui_startup_args = {
      'connect',
      hDomain.startup_domain,
      'fish',
      '-i',
      '-C',
      'neofetch',
    }
  end

  return config
end

return {
  mkConfig = mkConfig,
}
