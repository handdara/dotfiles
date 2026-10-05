{ ... }: {
  home.file = {
    ".config/xmonad/xmonad.hs".source = ../../../../snd/xmonad/xmonad.hs;
    ".config/xmobar/xmobarrc".source = ../../../../snd/xmonad/xmobarrc;
  };
}
