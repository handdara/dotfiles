{ config
, pkgs
, lib
, ...
}:
let
  default-font = "FreeMono";
in
{
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
    handdara.uiscale = lib.mkOption {
      type = lib.types.numbers.between 0.5 3;
      default = 1;
      description = "scale ui elements by this, e.g. ui/terminal text";
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
    handdara.colortheme = lib.mkOption {
      type = lib.types.path;
      default = ../../util/color;
      description = "path to the color theme to use (from ../theme/ dir)";
    };
  };
  config = {
    home.packages = [ pkgs.themechanger ];
    # gtk =
    #   if config.handdara.lightworks then {
    #     enable = true;
    #     theme.name = "Chicago95";
    #     theme.package = pkgs.chicago95;
    #     iconTheme.name = "Chicago95";
    #     iconTheme.package = pkgs.chicago95;
    #   } else {
    #     theme.name = "Juno";
    #     theme.package = pkgs.juno-theme;
    #     iconTheme.name = "Juno";
    #     iconTheme.package = pkgs.juno-theme;
    #   };
    # home.pointerCursor = {
    #   gtk.enable = true;
    #   x11.enable = true;
    #   name = "Bibata-Original-Amber";
    #   size = 36;
    #   package = pkgs.bibata-cursors;
    #   # package = pkgs.bibata-cursors-translucent;
    # };
    # qt = {
    #   enable = true;
    #   platformTheme.name = "gtk";
    #   style.name = if config.handdara.lightworks then "Chicago95" else "Juno";
    # };
  };
}
