{lib, ...} @ inputs: {
    specialisation.gdm.configuration = {
        services.displayManager.sddm.enable = lib.mkForce false;
        services.displayManager.sddm.wayland.enable = lib.mkForce false;
        services.xserver = {
            enable = lib.mkForce true; # Enable the X11 windowing system. displaylink driver set up for x11
            displayManager.gdm.enable = lib.mkForce true; # Enable the GNOME Display Manager
            desktopManager.gnome.enable = true;
        };
    };
}
