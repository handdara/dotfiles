{pkgs, opts, ... }:
let
    fish_light_theme = "Snow Day";
    fish_dark_theme = "Just a Touch";
in {
    home.file = {
        ".config/fish/config.fish".source = pkgs.substituteAll {
            src = ../../../../fst/hish/fish-main/config.fish;
            fish_theme = if opts.user.term_invert or false then fish_light_theme else fish_dark_theme;
        };
        ".config/fish/functions" = {
            source = ../../../../fst/hish/fish-main/functions;
            recursive = true;
        };
    };
}
