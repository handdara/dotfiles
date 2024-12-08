{...}:
{
    sys = {
        hostname = "theseus";
        system = "x86_64-linux";
        timezone = "America/New_York";
        locale = "en_US.UTF-8";
        useDisplayLink = false;
        useWayland = false;
    };
    user = rec {
        username = "handdara";
        name = username;
        email = "${username}.core@proton.me";
        which_nvim = "nrw";
        term_invert = false;
    };
}
