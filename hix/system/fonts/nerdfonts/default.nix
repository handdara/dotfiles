{config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.nerdfonts
  ];
}
