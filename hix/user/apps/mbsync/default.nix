{...}: {
    programs.mbsync = {
        enable = true;
        groups = {
            inboxes = {
                account1 = ["Inbox"];
                account2 = ["Inbox"];
            };
        };
        extraConfig = ''
          # extra config
        '';
    };
    # home.file = {
    #     ".mbsyncrc".text = ''
    #     # testing
    #     '';
    # };
}
