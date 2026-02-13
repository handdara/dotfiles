{ pkgs, ... }:

let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://codeberg.org/handdara/scip/raw/tag/v20260212.0/pack.toml";
    packHash = "sha256-pxYu8IeRhhvre2tobwG4JsQLESj6Q5kW4S1gfyqWcBo=";
  };
in

{
  environment.systemPackages = [ pkgs.prismlauncher pkgs.packwiz ];
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.scip = {
      enable = true;
      autoStart = false;
      jvmOpts = "-Xmx8G -Xms2G";
      package = pkgs.neoforgeServers.neoforge-1_21_1-21_1_219;
      symlinks = {
        "mods" = "${modpack}/mods";
      };
      # files = {
      #   "config" = "${modpack}/config";
      #   "config/mod1.yml" = "${modpack}/config/mod1.yml";
      #   "config/mod2.conf" = "${modpack}/config/mod2.conf";
      #   # You can add files not on the modpack, of course
      #   "config/server-specific.conf".value = {
      #     example = "foo-bar";
      #   };
      # };
      serverProperties = {
        server-port = 9002;
        difficulty = 3;
        gamemode = 0;
        max-players = 10;
        motd = "can someone please teach me how to season my cast iron packs?!?";
        white-list = false;
      };
    };
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
