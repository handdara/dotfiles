{...}: {
    services.redshift.enable = true;
    # services.redshift.tray = true;
    services.redshift.dawnTime = "6:00-7:45";
    # services.redshift.duskTime = "18:00-19:00";
    services.redshift.duskTime = "20:00-21:00";
}
