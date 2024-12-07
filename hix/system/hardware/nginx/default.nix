{config, pkgs, lib, ...}@inputs:
{
    services.nginx = {
        enable = true;
    };
}
