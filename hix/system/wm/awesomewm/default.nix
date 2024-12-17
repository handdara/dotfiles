{ pkgs, ... }: 
{
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
            xkb = { # Configure keymap in X11
                layout = "us";
                variant = "";
            };       
        };
        displayManager = {
            sddm.enable = true;
            defaultSession = "none+awesome";
        };
    };
    environment.systemPackages = with pkgs; [
        light
        xlockmore
    ];
}
