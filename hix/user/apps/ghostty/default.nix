{pkgs_unstable, ...}: let
    theme = import ./../../../util/color;
    c = theme.hexcodes;
in {
    home.packages = [pkgs_unstable.ghostty];
    home.file = {
        ".config/ghostty/config".text = ''
          theme = marrissa
          font-family = Hurmit Nerd Font
          cursor-style = block
          cursor-style-blink = false
          background-opacity = 0.70
          command = fish
          window-decoration = false
          window-theme = dark
          confirm-close-surface = false
          shell-integration-features = no-cursor
          gtk-tabs-location = hidden
          keybind = ctrl+shift+a=unbind
          keybind = ctrl+,=unbind
        '';
        ".config/ghostty/themes/marrissa".text = ''
          palette = 0=${c.black}
          palette = 1=${c.red}
          palette = 2=${c.green}
          palette = 3=${c.yellow}
          palette = 4=${c.blue}
          palette = 5=${c.magenta}
          palette = 6=${c.cyan}
          palette = 7=${c.white}
          palette =  8=${c.bright_black}
          palette =  9=${c.bright_red}
          palette = 10=${c.bright_green}
          palette = 11=${c.bright_yellow}
          palette = 12=${c.bright_blue}
          palette = 13=${c.bright_magenta}
          palette = 14=${c.bright_cyan}
          palette = 15=${c.bright_white}
          background = ${c.bg}
          foreground = ${c.fg}
          cursor-color = f2d5cf
          selection-background = 626880
          selection-foreground = c6d0f5
          keybind = ctrl+alt+shift+t=toggle_tab_overview
        '';
    };
}
