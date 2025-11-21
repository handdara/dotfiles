{lib, ...}: {
    services.teamviewer.enable = lib.mkDefault false;
    specialisation.remote-access.configuration = {
        services.teamviewer.enable = lib.mkForce true;
    };
}
