{lib, ...}: {
    specialisation.nvidia-offload.configuration = {
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
        system.nixos.tags = ["nvidia" "offload"];
    };
    specialisation.nvidia-sync.configuration = {
        hardware.graphics.enable = true;
        services.xserver.videoDrivers = ["nvidia"];
        hardware.nvidia.open = false; # Set to false to use the proprietary kernel module
        boot.kernelParams = ["module_blacklist=i915"];
        hardware.nvidia.prime = {
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
            # sync.enable = true;
            reverseSync.enable = true;
        };
        system.nixos.tags = ["nvidia" "sync"];
    };
}
