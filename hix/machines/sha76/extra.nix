{ user_opts, ... }: {
  # see https://wiki.nixos.org/wiki/Laptop for more. each of the following
  # options should be one of: "ignore", "poweroff", "reboot", "halt", "kexec",
  # "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192;
      cores = 3;
    };
    users.users.${user_opts.username}.initialHashedPassword = "$y$j9T$VMBnrWXrevKVHuJkDP4z11$UIXwWcYS8H05Rl8c7wZpvb2LEr6duAqZRvXEWORhn5C";
  };
}
