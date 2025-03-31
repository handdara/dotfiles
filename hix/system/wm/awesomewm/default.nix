{pkgs, ...}: {
    services = {
        picom.enable = true;
        xserver = {
            windowManager.awesome = {
                enable = true;
                luaModules = with pkgs.luaPackages; [
                    luarocks # is the package manager for Lua modules
                    luadbi-mysql # Database abstraction layer
                ];
            };
        };
    };
}
