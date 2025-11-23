flake-overlays: {
    pkgs,
    sys_opts,
    ...
} @ inputs: {
    imports =
        [
            ./machines/${sys_opts.hostname}/hardware-configuration.nix
            ./machines/${sys_opts.hostname}/bootloader.nix
            ./machines/${sys_opts.hostname}/networking.nix
            ./machines/${sys_opts.hostname}/gpu.nix
            # ./system/wm/gdm
            ./system/wm/awesomewm
            ./system/wm/plasma
            ./system/fonts/nerdfonts
            ./system/hardware/kmonad
            ./system/theme
            ./system/remote
            # ./system/hardware/displaylink
        ]
        ++ inputs.extraModules;

    nixpkgs.overlays = flake-overlays;

    nix.settings.experimental-features = ["nix-command" "flakes"];

    networking.hostName = sys_opts.hostname;
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Set your time zone.
    time.timeZone = sys_opts.timezone;

    # Select internationalisation properties.
    i18n.defaultLocale = sys_opts.locale;

    i18n.extraLocaleSettings = {
        LC_ADDRESS = sys_opts.locale;
        LC_IDENTIFICATION = sys_opts.locale;
        LC_MEASUREMENT = sys_opts.locale;
        LC_MONETARY = sys_opts.locale;
        LC_NAME = sys_opts.locale;
        LC_NUMERIC = sys_opts.locale;
        LC_PAPER = sys_opts.locale;
        LC_TELEPHONE = sys_opts.locale;
        LC_TIME = sys_opts.locale;
    };

    services.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${inputs.user_opts.username} = {
        isNormalUser = true;
        description = inputs.user_opts.name;
        extraGroups = ["networkmanager" "wheel"];
        useDefaultShell = true;
    };

    virtualisation.vmVariant = {
        # following configuration is added only when building VM with build-vm
        virtualisation = {
            memorySize = 8192;
            cores = 3;
        };
        users.users.${inputs.user_opts.username}.initialHashedPassword = "$y$j9T$JUfzgCrkYKRoLrIAVtJQ6/$7dfStm8xv38CGZP.LSuA4GEVVJyCuR8H1TRPCPc3D64";
    };

    # Install firefox for all users
    programs.firefox.enable = true;

    environment.shells = with pkgs; [fish bash zsh dash];
    programs.fish.enable = true;
    programs.bash.enableLsColors = false;
    users.defaultUserShell = pkgs.dash;
    users.users.root.shell = pkgs.dash;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # base system packages
    environment.systemPackages = with pkgs; [
        alacritty
        alsa-utils
        bc
        brightnessctl
        chafa
        fastfetch
        fim
        ghostty
        git
        libnotify
        mpv
        pandoc
        pass
        pastel
        pavucontrol
        pinentry-curses
        tree
        universal-ctags
        unzip
        vim
        wget
        xclip
        xlockmore
        zathura
        # see ./flake.nix input `nix-matlab`
        matlab
    ];

    programs.tmux.enable = true;
    programs.fzf.fuzzyCompletion = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    services.pcscd.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };
    services.xbanish.enable = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
}
