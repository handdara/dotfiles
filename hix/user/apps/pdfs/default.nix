{ pkgs
, config
, ...
}:
let
  fontsize-scaled = builtins.ceil (config.handdara.uiscale * config.handdara.fontsize);
in
{
  programs.zathura = {
    enable = true;
    options = {
      font = "${config.handdara.font} normal ${builtins.toString fontsize-scaled}";
      recolor-keephue = true;
    };
  };
  programs.pandoc.enable = true;
  home.packages = [
    pkgs.poppler-utils
    pkgs.styluslabs-write
    pkgs.zotero
  ];
}
