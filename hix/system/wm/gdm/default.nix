{...} @ inputs: {
    services.xserver = {
        enable = true; # Enable the X11 windowing system. displaylink driver set up for x11
        displayManager.gdm.enable = true; # Enable the GNOME Display Manager
        desktopManager.gnome.enable = true;
        displayManager.gdm.wayland = inputs.sys_opts.useWayland;
        xkb = {
            # Configure keymap in X11
            layout = "us";
            variant = "";
        };
    };
}
