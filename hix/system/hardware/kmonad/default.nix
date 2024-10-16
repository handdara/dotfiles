{
  services.kmonad = {
    enable = true;
    # keyboards = {
    #   myKMonadOutput = {
    #     device = "/dev/input/by-id/my-keyboard-kbd";
    #     config = builtins.readFile /path/to/my/config.kbd;
    #   };
    # };
  }; 
  users.users.handdara.extraGroups = [ "input" "uinput" ];
}
