{ pkgs, ... }: {
  services = {
    picom.enable = true;
    xserver = {
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
  environment.systemPackages = [
    pkgs.xmobar
    pkgs.haskell-language-server
    pkgs.dmenu
  ];
}
