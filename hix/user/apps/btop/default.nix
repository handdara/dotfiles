{...}: let
    theme = import ../../../util/color;
in {
    programs.btop = {
        enable = true;
        settings = {
            color_theme =
                if theme.is_light
                then "paper"
                else "adapta";
            theme_background = false;
            vim_keys = true;
            rounded_corners = true;
        };
    };
}
