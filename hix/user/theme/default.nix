{lib, ...}: 
let
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
    };
}
