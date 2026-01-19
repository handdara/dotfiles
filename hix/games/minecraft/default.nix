{pkgs, ...}: {
  environment.systemPackages = [pkgs.prismlauncher];
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    # environmentFile = ../../../../../.config/minecraft-servers/env.sh;
    servers.estre = {
      enable = true;
      autoStart = false;
      jvmOpts = "-Xmx8G -Xms2G";
      package = pkgs.vanillaServers.vanilla-1_21_11;
      # whitelist = {
      #     username1 = "00000000-0000-0000-0000-000000000000";
      # };
      serverProperties = {
        server-port = 9001;
        difficulty = 3;
        gamemode = 0;
        max-players = 10;
        motd = "estre? i barely know 'er!";
        white-list = true;
      };
    };
  };
}
