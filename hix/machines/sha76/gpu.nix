{lib, ...}: {
    specialisation.nvidia-sync.configuration = {
        hardware.nvidia.prime = {
            sync.enable = true;
            # reverseSync.enable = true;
        };
        offload = {
            enable = lib.mkOverride 25 false;
            enableOffloadCmd = lib.mkOverride 25 false;
        };
        system.nixos.tags = ["nvidia" "sync"];
    };
}
