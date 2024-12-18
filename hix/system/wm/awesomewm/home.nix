{...}: let
    awm_dir = ../../../../snd/awesomewm;
in {
    home.file = {
        ".config/awesome" = {
            source = awm_dir;
            recursive = true;
        };
    };
}
