{lib, ...}: {
  specialisation.no-remote-access.configuration = {
    services.teamviewer.enable = lib.mkForce false;
    services.openssh.enable = lib.mkForce false;
  };
  services.teamviewer.enable = lib.mkDefault true;
}
