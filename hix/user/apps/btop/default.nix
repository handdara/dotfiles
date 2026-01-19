{config, ...}: let
  bothThemes = import ../../../util/color;
  theme =
    if (config.handdara.lightworks == true)
    then bothThemes.light
    else bothThemes.dark;
in {
  programs.btop = {
    enable = true;
    settings = {
      color_theme =
        if theme.is_light
        then "paper"
        else "TTY";
      theme_background = false;
      vim_keys = true;
      rounded_corners = true;
    };
  };
}
