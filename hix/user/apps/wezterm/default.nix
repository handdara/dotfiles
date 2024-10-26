{/* config, */ pkgs, ... }:
{
  home.packages = [ pkgs.wezterm ];
  home.file = {
    ".config/wezterm" = {
      source = ../../../../fst/hez/wezterm-main;
      recursive = true;
    };
  };
}
