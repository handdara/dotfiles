{lib, ...}: {
    specialisation.no-remote-access.configuration = {
        services.teamviewer.enable = lib.mkForce false;
    };
    services.teamviewer.enable = lib.mkDefault true;
    hardware.graphics.enable = lib.mkDefault true;
    services.xserver.videoDrivers = lib.mkDefault ["nvidia"];
    hardware.nvidia.open = lib.mkDefault false; # Set to false to use the proprietary kernel module
    # boot.kernelParams = ["module_blacklist=i915"];
    hardware.nvidia.prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
            enable = lib.mkDefault true;
            enableOffloadCmd = lib.mkDefault true;
        };
    };
    system.nixos.tags = lib.mkDefault ["nvidia" "offload"];
}
