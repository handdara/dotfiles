{lib, ...}: {
    services.teamviewer.enable = lib.mkDefault false;
    specialisation.lightworks.configuration = {
        services.teamviewer.enable = lib.mkForce true;
    };
}
