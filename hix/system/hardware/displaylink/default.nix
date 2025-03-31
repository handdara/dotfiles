{
    pkgs,
    lib,
    ...
}: {
    specialisation.ccrf.configuration = {
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
        services.xserver.videoDrivers = ["displaylink" "modesetting" "nvidia"];
        services.xserver.displayManager.sessionCommands = ''
          ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
        '';

        # see also hix/machines/sha76/gpu.nix for another use of this code, it's also where I copied it from
        hardware.graphics.enable = true;
        hardware.nvidia.open = true; # Set to false to use the proprietary kernel module
        hardware.nvidia.prime = {
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
            offload = {
                enable = true;
                enableOffloadCmd = true;
            };
        };
        system.nixos.tags = ["nvidia" "offload" "ccrf"];
        # services.xserver.desktopManager.gnome.enable = true;
        services.desktopManager.plasma6.enable = true;
    };
}
