{
  pkgs,
  lib,
  ...
}: {
  services = {
    picom.enable = true;
    xserver = {
      enable = true;
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks # is the package manager for Lua modules
          luadbi-mysql # Database abstraction layer
        ];
      };
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
  services.displayManager.ly.enable = lib.mkDefault true;
}
