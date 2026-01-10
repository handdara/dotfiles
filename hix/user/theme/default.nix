{config, pkgs, lib, ...}: let
    default-font = "FreeMono";
in {
    options = {
        handdara.lightworks = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether or not to use light mode.";
        };
        handdara.font = lib.mkOption {
            type = lib.types.str;
            default = default-font;
            description = "system font to use";
        };
        handdara.fontui = lib.mkOption {
            type = lib.types.str;
            default = default-font;
            description = "system font to use for ui elements (hint: add 'Propo' for nerd fonts)";
        };
        handdara.fontterm = lib.mkOption {
            type = lib.types.str;
            default = default-font;
            description = "terminal font to use";
        };
        handdara.fontsize = lib.mkOption {
            type = lib.types.ints.between 2 100;
            default = 12;
            description = "system font size";
        };
        handdara.transparency = lib.mkOption {
            type = lib.types.ints.between 2 100;
            default = 85;
            description = "default transparency";
        };
        handdara.shprompt = lib.mkOption {
            type = lib.types.str;
            default = "regular";
            description = "mode for starship prompt: regular, simple, off";
        };
    };
    config = {
        fonts.fontconfig = {
            enable = true;
            antialiasing = false;
            defaultFonts = {
                monospace = ["scientifica" default-font];
            };
        };
        gtk = {
            enable = true;
            font.name = config.handdara.fontui;
            font.size = config.handdara.fontsize;
            theme.name = "Chicago95";
            theme.package = pkgs.chicago95;
            iconTheme.name = "Chicago95";
            iconTheme.package = pkgs.chicago95;
            cursorTheme = {
                name = "Bibata-Tinted";
                size = 48;
                package = pkgs.bibata-cursors-translucent;
            };
        };
        qt = {
            enable = true;
            platformTheme.name = "gtk";
            style.name = "Chicago95";
        };
    };
}
