{lib, ...}: {
    specialisation.nvidia-sync.configuration = {
        hardware.nvidia.prime = {
            sync.enable = true;
            # reverseSync.enable = true;
        };
        offload = {
            enable = lib.mkForce false;
            enableOffloadCmd = lib.mkForce false;
        };
        system.nixos.tags = ["nvidia" "sync"];
    };
}
