# see:
#   - https://nixos.wiki/wiki/Sway
#   - https://github.com/diinki/diinki-retrofuture
#   - https://github.com/diinki/diinki-retrofuture/archive/f8133fe792785f26354a95807dd32aeadd749e5d.zip
{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        grim # screenshot functionality
        slurp # screenshot functionality
        wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
        mako # notification system developed by swaywm maintainer
        wofi
        nemo
        nautilus
        kitty
        dconf-editor
        eww
    ];

    programs.nautilus-open-any-terminal.enable = true;
    programs.nautilus-open-any-terminal.terminal = "kitty";
    # programs.nautilus-open-any-terminal.terminal = "ghostty";

    # Enable the gnome-keyring secrets vault.
    # Will be exposed through DBus to programs willing to store secrets.
    services.gnome.gnome-keyring.enable = true;

    # enable sway window manager
    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };

    programs.waybar.enable = true;
    programs.dconf.enable = true;
}
