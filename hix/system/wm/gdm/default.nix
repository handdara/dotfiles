{...} @ inputs: {
    services.xserver = {
        enable = true; # Enable the X11 windowing system. displaylink driver set up for x11
        displayManager.gdm.enable = true; # Enable the GNOME Display Manager
        # displayManager.gdm.wayland = inputs.sys_opts.useWayland;
        xkb = {
            # Configure keymap in X11
            layout = "us";
            variant = "";
        };
    };
    specialisation = {
        gdm.configuration = {
            services.xserver.desktopManager.gnome.enable = true;
        };
    };
}
