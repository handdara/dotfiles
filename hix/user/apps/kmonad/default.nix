{config, pkgs, ... }:
{
  home.file = {
    ".config/kmonad/" = {
      source = ../../../../snd/kmonad/keymap;
      recursive = true;
    };
  };
}
