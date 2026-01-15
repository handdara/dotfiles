{lib, ...}: {
    # Enable networking
    networking.networkmanager.enable = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # OpenSSH daemon config
    services.openssh = {
        enable = lib.mkDefault true;
        ports = [22 2222];
        settings = {
            PasswordAuthentication = false;
            PubkeyAuthentication = true;
            PermitRootLogin = "no";
        };
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # hardware.bluetooth.enable = true; # enables support for Bluetooth
    # hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    # services.blueman.enable = true;
}
