{config, lib, ...}: {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia" "modesetting"];
    # boot.kernelParams = ["module_blacklist=i915"];
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
    hardware.nvidia.open = false; # Set to false to use the proprietary kernel module
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
