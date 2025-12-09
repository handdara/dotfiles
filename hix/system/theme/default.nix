{lib, ...}: {
    options = {
        handdara.lightworks = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether or not to use light mode.";
        };
    };
    config = {
        # handdara.lightworks = lib.mkDefault false;
        # specialisation.lightworks.configuration = {
        #     handdara.lightworks = lib.mkForce true;
        # };
    };
}
