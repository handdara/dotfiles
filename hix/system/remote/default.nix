{lib, ...}: {
    specialisation.no-remote-access.configuration = {
        services.teamviewer.enable = lib.mkForce false;
        system.nixos.tags = ["nvidia" "offload"];
    };
    services.teamviewer.enable = lib.mkDefault true;
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = false; # Set to false to use the proprietary kernel module
    # boot.kernelParams = ["module_blacklist=i915"];
    hardware.nvidia.prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
            enable = true;
            enableOffloadCmd = true;
        };
    };
}
