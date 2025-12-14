{lib, ...}: {
    hardware.graphics.enable = lib.mkDefault true;
    services.xserver.videoDrivers = lib.mkDefault ["nvidia"];
    hardware.nvidia.open = lib.mkDefault false; # Set to false to use the proprietary kernel module
    # boot.kernelParams = ["module_blacklist=i915"];
    hardware.nvidia.prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
            enable = lib.mkForce true;
            enableOffloadCmd = lib.mkForce true;
        };
    };
    specialisation.nvidia-sync.configuration = {
        hardware.nvidia.prime = {
            sync.enable = true;
            # reverseSync.enable = true;
            offload = {
                enable = lib.mkOverride 0 false;
                enableOffloadCmd = lib.mkOverride 0 false;
            };
        };
        system.nixos.tags = ["nvidia-sync"];
    };
}
