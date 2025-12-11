{lib, ...}: {
    specialisation.nvidia-sync.configuration = {
        hardware.nvidia.prime = {
            sync.enable = true;
            # reverseSync.enable = true;
        };
        offload = {
            enable = false;
            enableOffloadCmd = false;
        };
        system.nixos.tags = ["nvidia-sync"];
    };
}
