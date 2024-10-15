{config, pkgs, ... }:
{
  home.file = {
    ".config/wezterm" = {
      source = ../../../../fst/hez/wezterm-main;
      recursive = true;
    };
  };
}
