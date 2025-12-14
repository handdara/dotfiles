{lib, ...} @ inputs: {
    specialisation.gdm.configuration = {
        services.xserver = {
            enable = lib.mkForce true; # Enable the X11 windowing system. displaylink driver set up for x11
            desktopManager.gnome.enable = true;
        };
    };
}
