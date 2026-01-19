{user_opts, ...}: {
  services.kmonad = {
    enable = true;
  };
  users.users.${user_opts.username}.extraGroups = ["input" "uinput"];
}
