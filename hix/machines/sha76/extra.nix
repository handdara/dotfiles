{user_opts, ...}: {
    services.logind.lidSwitchExternalPower = "ignore";
    virtualisation.vmVariant = {
        # following configuration is added only when building VM with build-vm
        virtualisation = {
            memorySize = 8192;
            cores = 3;
        };
        users.users.${user_opts.username}.initialHashedPassword = "$y$j9T$VMBnrWXrevKVHuJkDP4z11$UIXwWcYS8H05Rl8c7wZpvb2LEr6duAqZRvXEWORhn5C";
    };
}
