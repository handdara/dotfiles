{ pkgs
, config
, ...
}: {
  programs.zathura = {
    enable = true;
    options = {
      font = "${config.handdara.font} normal ${builtins.toString (config.handdara.fontsize)}";
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
