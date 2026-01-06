{config, ...}: let
    bothThemes = import ../../../util/color;
    theme =
        if config.handdara.lightworks
        then bothThemes.light
        else bothThemes.dark;
    name = theme.name;
    c = theme.hexcodes;
    overrides =
        if config.handdara.lightworks
        then {}
        else {
            bg = "120b0d";
        };
in {
    home.file = {
        ".config/ghostty/config".text = ''
            theme = ${name}
            font-family = ""
            font-family = "${config.handdara.fontterm}"
            font-size = ${builtins.toString (config.handdara.fontsize - 2)}
            cursor-style = block
            cursor-style-blink = false
            background-opacity = ${builtins.toString (config.handdara.transparency / 100.0)}
            window-padding-x = 2
            window-padding-y = 0
            window-decoration = false
            window-theme = auto
            confirm-close-surface = false
            shell-integration-features = no-cursor
            gtk-tabs-location = hidden
            keybind = ctrl+,=unbind
            keybind = ctrl+shift+a=unbind
            keybind = ctrl+alt+shift+t=toggle_tab_overview
            keybind = ctrl+alt+minus=toggle_tab_overview
            keybind = global:super+alt+shift+t=toggle_quick_terminal
            keybind = ctrl+alt+shift+enter=toggle_quick_terminal
        '';
        ".config/ghostty/themes/${name}".text = ''
            palette =  0=${theme.ghostty.palette0 or c.black}
            palette =  1=${theme.ghostty.palette1 or c.red}
            palette =  2=${theme.ghostty.palette2 or c.green}
            palette =  3=${theme.ghostty.palette3 or c.yellow}
            palette =  4=${theme.ghostty.palette4 or c.blue}
            palette =  5=${theme.ghostty.palette5 or c.magenta}
            palette =  6=${theme.ghostty.palette6 or c.cyan}
            palette =  7=${theme.ghostty.palette7 or c.white}
            palette =  8=${theme.ghostty.palette8 or c.bright_black}
            palette =  9=${theme.ghostty.palette9 or c.bright_red}
            palette = 10=${theme.ghostty.paletteA or c.bright_green}
            palette = 11=${theme.ghostty.paletteB or c.bright_yellow}
            palette = 12=${theme.ghostty.paletteC or c.bright_blue}
            palette = 13=${theme.ghostty.paletteD or c.bright_magenta}
            palette = 14=${theme.ghostty.paletteE or c.bright_cyan}
            palette = 15=${theme.ghostty.paletteF or c.bright_white}
            background = ${overrides.bg or theme.ghostty.bg or c.bg}
            foreground = ${c.fg}
            cursor-color = ${theme.ghostty.cursor_bg or "cell-foreground"}
            cursor-text = ${theme.ghostty.cursor_fg or "cell-background"}
            selection-background = 626880
            selection-foreground = c6d0f5
        '';
    };
}
