{
    pkgs,
    hostname,
    system-overlays,
    ...
} @ inputs: let
    locale = inputs.locale or "en_US.UTF-8";
in {
    imports =
        [
            ./machines/${hostname}/hardware-configuration.nix
            ./machines/${hostname}/bootloader.nix
            ./machines/${hostname}/battery.nix
            ./machines/${hostname}/networking.nix
            ./machines/${hostname}/extra.nix
            ./machines/${hostname}/gpu.nix
            ./system/wm/awesomewm
            ./system/wm/plasma
            ./system/wm/xmonad
            ./system/fonts/nerdfonts
            ./system/hardware/kmonad
            ./system/remote
            # ./system/hardware/displaylink
        ]
        ++ (inputs.extraModules or []);

    nixpkgs.overlays = system-overlays;

    nix.settings.experimental-features = ["nix-command" "flakes"];

    networking.hostName = hostname;

    # Set your time zone.
    time.timeZone = inputs.timezone;
    # Select internationalisation properties.
    i18n.defaultLocale = locale;

    i18n.extraLocaleSettings = {
        LC_ADDRESS = locale;
        LC_IDENTIFICATION = locale;
        LC_MEASUREMENT = locale;
        LC_MONETARY = locale;
        LC_NAME = locale;
        LC_NUMERIC = locale;
        LC_PAPER = locale;
        LC_TELEPHONE = locale;
        LC_TIME = locale;
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

    environment.shells = with pkgs; [fish bash zsh dash];
    programs.fish.enable = true;
    programs.bash.enableLsColors = false;
    users.defaultUserShell = pkgs.dash;
    users.users.root.shell = pkgs.dash;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # base system packages
    environment.systemPackages = [
        pkgs.acpi
        pkgs.alacritty
        pkgs.alsa-utils
        pkgs.asciinema
        pkgs.bat
        pkgs.bc
        pkgs.boxes
        pkgs.brightnessctl
        pkgs.btop
        pkgs.caligula
        pkgs.cdparanoia
        pkgs.chafa
        pkgs.croc
        pkgs.dust
        pkgs.eza
        pkgs.fastfetch
        pkgs.ffmpeg
        pkgs.flameshot
        pkgs.fortune
        pkgs.ghostty
        pkgs.gimp
        pkgs.git
        pkgs.graphite-gtk-theme
        pkgs.gvfs
        pkgs.imagemagick
        pkgs.isync
        pkgs.jq
        pkgs.just
        pkgs.lazygit
        pkgs.libnotify
        pkgs.linux-manual
        # pkgs.lxappearance
        pkgs.man-pages
        pkgs.man-pages-posix
        pkgs.matlab # see ./flake.nix input `nix-matlab`
        pkgs.megacmd
        pkgs.mouseless
        pkgs.mpv
        pkgs.msmtp
        pkgs.neomutt
        pkgs.noip
        pkgs.pandoc
        pkgs.pass
        pkgs.pastel
        pkgs.pavucontrol
        pkgs.pinentry-curses
        pkgs.redshift
        pkgs.stow
        pkgs.tealdeer
        pkgs.themechanger
        pkgs.toilet
        pkgs.universal-ctags
        pkgs.unzip
        pkgs.vim
        pkgs.vivaldi
        pkgs.w3m
        pkgs.watchexec
        pkgs.wget
        pkgs.wikiman
        pkgs.wiki-tui
        pkgs.xclip
        pkgs.xcolor
        pkgs.xfce.ristretto
        pkgs.xlockmore
        pkgs.yq
        pkgs.yt-dlp
        pkgs.zathura
        pkgs.zoxide
    ];

    # Install firefox for all users
    programs.firefox.enable = false;
    programs.fzf.fuzzyCompletion = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };
    programs.thunar = {
        enable = true;
        plugins = [pkgs.xfce.thunar-volman pkgs.xfce.thunar-archive-plugin];
    };

    programs.tmux.enable = true;

    documentation.enable = true;
    documentation.man.enable = true;
    documentation.doc.enable = true;
    documentation.dev.enable = true;
    documentation.info.enable = true;
    documentation.nixos.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    services.pcscd.enable = true;
    services.xbanish.enable = true;
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
}
