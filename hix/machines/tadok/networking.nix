{...}: {
    # Enable networking
    networking.networkmanager.enable = true;

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    services.openssh.enable = true;
    services.openssh.settings.PermitRootLogin = "no";
    # users.users.youruser.openssh.authorizedKeys.keys = [ "your-ssh-public-key" ];

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
}
