{pkgs, ...}: {
    environment.systemPackages = [pkgs.prismlauncher];
    services.minecraft-servers = {
        enable = true;
        eula = true;
        openFirewall = true;
        # environmentFile = ../../../../../.config/minecraft-servers/env.sh;
        servers.vanilla = {
            enable = true;
            jvmOpts = "-Xmx8G -Xms2G";
            package = pkgs.vanillaServers.vanilla-1_21_11;
        };
    };
}
