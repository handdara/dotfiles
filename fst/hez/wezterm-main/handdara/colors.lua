local cyberdream_colors_light = { -- cyberdream theme for wezterm
    foreground = "#16181a",
    background = "#ffffff",

    cursor_bg = "#16181a",
    cursor_fg = "#ffffff",
    cursor_border = "#16181a",

    selection_fg = "#16181a",
    selection_bg = "#acacac",

    scrollbar_thumb = "#ffffff",
    split = "#ffffff",

    ansi = { "#ffffff", "#d11500", "#008b0c", "#997b00", "#0057d1", "#a018ff", "#008c99", "#16181a" },
    brights = { "#acacac", "#d11500", "#008b0c", "#997b00", "#0057d1", "#a018ff", "#008c99", "#16181a" },
    indexed = { [16] = "#d17c00", [17] = "#d11500" },
}

local cyberdream_colors = { -- cyberdream theme for wezterm
    foreground = "#ffffff",
    background = "#16181a",

    cursor_bg = "#ffffff",
    cursor_fg = "#16181a",
    cursor_border = "#ffffff",

    selection_fg = "#ffffff",
    selection_bg = "#3c4048",

    scrollbar_thumb = "#16181a",
    split = "#16181a",

    ansi = { "#16181a", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
    brights = { "#3c4048", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
    indexed = { [16] = "#ffbd5e", [17] = "#ff6e5e" },
}

local default_colors = {
    -- The default text color
    foreground = '#FFFADE',
    -- The default background color
    background = '#000000',

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = '#47A8A1',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = 'black',
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = '#47A8A1',

    -- the foreground color of selected text
    selection_fg = '#18191E',
    -- the background color of selected text
    selection_bg = '#1D918B',

    -- The color of the scrollbar "thumb"; the portion that represents the current viewport
    scrollbar_thumb = '#222222',

    -- The color of the split lines between panes
    split = '#444444',

    ansi = { '#373C45', '#FF5050', '#44B273', '#ED722E', '#1D918B', '#D16BB7', '#00BFA4', '#8E8D8D' },
    brights = { '#CCCCCC', '#FF4D00', '#10B981', '#FFFF00', '#0DB9D7', '#D68EB2', '#5AD1AA', '#FFFADE' },

    -- -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = { [136] = '#FFFF00' },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = '#1D918B',
}

return {
    -- default_colors = default_colors,
    default_colors = cyberdream_colors,
    -- default_colors = cyberdream_colors_light,
}
