{...}: let
    c = import ../../../util/color;
    mkText = import ../../../util/mkTheme;
    themeText = mkText c;
in {
    home.file = {
        ".local/share/theme/current.base16".text = themeText.base16;
    };
}
