{ ... }: {
  services.teamviewer.enable = true;
  # In /etc/nixos/configuration.nix
  virtualisation.docker = {
    enable = true;
  };
  # Add to the docker group to run w/o sudo
  users.users.estraven.extraGroups = [ "docker" ];
}
