{
    config,
    pkgs,
    user_opts,
    ...
}: let
    # fish_light_theme = "Snow Day";
    fish_light_theme = "fish default";
    fish_dark_theme = "Just a Touch";
    bothThemes = import ../../../util/color;
    theme =
        if (config.handdara.lightworks == true)
        then bothThemes.light
        else bothThemes.dark;
in {
    home.file = {
        ".config/fish/config.fish".source = pkgs.substituteAll {
            src = ../../../../fst/hish/fish-main/config.fish;
            fish_theme =
                if theme.is_light or false
                then fish_light_theme
                else fish_dark_theme;
        };
        ".config/fish/functions" = {
            source = ../../../../fst/hish/fish-main/functions;
            recursive = true;
        };
    };
}
