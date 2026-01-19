{
  config,
  user_opts,
  ...
}: let
  bothThemes = import ../../../util/color;
  c =
    if (config.handdara.lightworks == true)
    then bothThemes.light
    else bothThemes.dark;
  mkText = import ../../../util/mkTheme;
  themeText = mkText c;
in {
  home.file = {
    ".local/share/theme/current.base16".text = themeText.base16;
  };
}
