local M = {}

M.cyberdream_colors_light = { -- cyberdream theme for wezterm
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

M.cyberdream_colors = { -- cyberdream theme for wezterm
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

return M
