{ config, lib, pkgs, sysSettings, userSettings, ... }:

{
  imports =
    [ (./. + "/machines"+("/"+sysSettings.hostname)+"/hardware-configuration.nix") 
      ./system/fonts/nerdfonts/default.nix 
      ./system/hardware/kmonad/default.nix
    ] ++ 
    ( if sysSettings.useDisplayLink
        then [ ./system/hardware/displaylink/default.nix ]
        else [] 
    );

  # imports =
  #   [ # Include the results of the hardware scan.
  #     ( if sysSettings.hostname == "sha76"
  #         then ./machines/sha76/hardware-configuration.nix
  #         else abort "unrecognized sysSettings.hostname"
  #     )
  #   ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = sysSettings.hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = sysSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = sysSettings.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = sysSettings.locale;
    LC_IDENTIFICATION = sysSettings.locale;
    LC_MEASUREMENT = sysSettings.locale;
    LC_MONETARY = sysSettings.locale;
    LC_NAME = sysSettings.locale;
    LC_NUMERIC = sysSettings.locale;
    LC_PAPER = sysSettings.locale;
    LC_TELEPHONE = sysSettings.locale;
    LC_TIME = sysSettings.locale;
  };

  services.xserver = {
    enable = true; # Enable the X11 windowing system.
    displayManager.gdm.enable = true; # Enable the GNOME Desktop Environment.
    desktopManager.gnome.enable = true;
    displayManager.gdm.wayland = !sysSettings.useDisplayLink; # displaylink driver set up for x11
    xkb = { # Configure keymap in X11
      layout = "us";
      variant = "";
    };
  };

  services.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Install and set default shell to fish
  environment.shells = with pkgs; [ fish bash zsh ];
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # base system packages
  environment.systemPackages = with pkgs; [
    nvi
    vim
    neovim
    wget
    fzf
    git
    just
    wezterm
    unzip
    xclip
    neofetch
    megacmd
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
