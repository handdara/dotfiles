{user_opts, ...}: {
    services.kmonad = {
        enable = true;
        # keyboards = {
        #   myKMonadOutput = {
        #     device = "/dev/input/by-id/my-keyboard-kbd";
        #     config = builtins.readFile /path/to/my/config.kbd;
        #   };
        # };
    };
    users.users.${user_opts.username}.extraGroups = ["input" "uinput"];
}
