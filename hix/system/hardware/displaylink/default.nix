{config, pkgs, lib, ... }:
{
  # ALERT: This uses unfree software, here is a helpful log report:
  # ***
  # In order to install the DisplayLink drivers, you must first
  # comply with DisplayLink's EULA and download the binaries and
  # sources from here:
  #
  # https://www.synaptics.com/products/displaylink-graphics/downloads/ubuntu-5.8
  #
  # Once you have downloaded the file, please use the following
  # commands and re-run the installation:
  #
  # mv $PWD/"DisplayLink USB Graphics Software for Ubuntu5.8-EXE.zip" $PWD/displaylink-580.zip
  # nix-prefetch-url file://$PWD/displaylink-580.zip
  # ***
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  '';
}

