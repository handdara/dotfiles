{ pkgs, ... }: {
  services.jellyfin.enable = true;
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
    # pkgs.jellyfin-media-player # WARNING! possible vulerability: https://wiki.nixos.org/wiki/Jellyfin
  ];
}
