{lib, ...}: {
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
