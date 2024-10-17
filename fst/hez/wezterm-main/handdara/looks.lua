local hc = require 'handdara.colors'
local hf = require 'handdara.fonts'

local function apply_to_config(config)
    -- set theme & opacity
    config.colors = hc.default_colors
    config.window_background_opacity = 0.75
    config.inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.75,
    }

    -- fonts and window settings
    local default_font = hf.hasklug
    local default_font_size = 13.0
    config.font = default_font
    config.font_size = default_font_size
    config.enable_tab_bar = false -- making the window layout simple, 99 times out of 100 scaling is handled
    config.window_frame = {
        font = hf.hasklug,
        font_size = default_font_size - 1,
    }

    config.window_decorations = "RESIZE" -- by my window manager even in the other cases, i usually just maximize

    config.window_padding = {
        left = 4,
        right = 4,
        top = 0,
        bottom = 0,
    }
    -- config.enable_wayland = true               -- i was using a os with wayland, but not atm, i'll uncomment if i go back
end

return {
    apply_to_config = apply_to_config,
}
