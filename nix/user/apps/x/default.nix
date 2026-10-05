{ config, ... }:
let
  fontsize-scaled = builtins.ceil (config.handdara.uiscale * config.handdara.fontsize);
in
{
  xresources.extraConfig = ''
    XTerm*faceName: ${config.handdara.fontui or "Monospace"}
    XTerm*faceSize: ${builtins.toString fontsize-scaled}
    XTerm*foreground: ${
      if config.handdara.lightworks
      then "black"
      else "white"
    }
    XTerm*background: ${
      if config.handdara.lightworks
      then "white"
      else "black"
    }
    XTerm*cursorColor: ${
      if config.handdara.lightworks
      then "black"
      else "white"
    }
  '';
}
