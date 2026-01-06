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
            description = "system font to use";
        };
        handdara.fontterm = lib.mkOption {
            type = lib.types.str;
            default = default-font;
            description = "system font to use";
        };
        handdara.fontsize = lib.mkOption {
            type = lib.types.ints.between 2 100;
            default = 12;
            description = "system font size";
        };
    };
}
