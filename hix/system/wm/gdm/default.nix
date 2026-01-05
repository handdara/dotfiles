{lib, ...}: {
    specialisation.gdm.configuration = {
        services.xserver = {
            enable = lib.mkForce true;
            desktopManager.gnome.enable = true;
        };
    };
}
