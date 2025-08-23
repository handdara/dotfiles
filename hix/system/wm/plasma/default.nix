{lib, ...} @ inputs: {
    services = {
        xserver.enable = true;
        xserver.xkb = {
            # Configure keymap in X11
            layout = "us";
            variant = "";
        };
        displayManager.sddm.enable = lib.mkDefault true;
        displayManager.sddm.wayland.enable = lib.mkDefault true;
    };
    specialisation.plasma6.configuration = {
        services.desktopManager.plasma6.enable = true;
    };
    # specialisation.plasma6-x11.configuration = {
    #     services.desktopManager.plasma6.enable = true;
    #     services.displayManager.defaultSession = "plasmax11";
    #     services.displayManager.sddm.wayland.enable = lib.mkForce false;
    # };
}
