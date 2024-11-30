<!--
---
YY: 24
0M: 11
MINOR: 4
MICRO: 1
---
-->
# handdara's dotfiles

[![Version Badge][]](https://github.com/handdara/dotfiles/releases/latest )

`hix`: NixOS configuration files

`fst`: first layer: core tools. right now this is: neovim, wezterm, git & fish.

- `git`: git config
- `hez`: wezterm config
- `him`: neovim config
- `hish`: fish config

`snd`: secondary layer: tools that don't fit into core. their dotfiles are here

## usage

1.  install NixOS 
1.  enable flakes and set hostname
    1.  add `nix.settings.experimental-features = [ "nix-command" "flakes" ];` to `/etc/nixos/configuration.nix`
        and change the hostname on the line `networking.hostName = "<HOSTNAME-GOES-HERE>"; # Define your hostname.`
    1.  save and rebuild with `sudo nixos-rebuild switch`. then reboot
1.  installing home manager
    1.  add home manager channel by running 
        `nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager` 
        and then `nix-channel --update` *(might need to change out the home-manager release from 
        24.05 to unstable or whichever channel is being used)*
    1.  reboot
    1.  run `nix-shell '<home-manager>' -A install` to install home manager standalone
1.  personally I like to drop into a shell with some of my favorite utilities to do the rest
    `nix-shell -p neovim fish zoxide fzf eza git just --run "fish"`
1.  `git clone` this repo 
1.  make a new folder `dotfiles/hix/machines/<HOSTNAME-GOES-HERE>/` in this repo and copy 
    `/etc/nixos/hardware-configuration.nix` into it
1.  make a new file `dotfiles/hix/machines/<HOSTNAME-GOES-HERE>/bootloader.nix` and copy the bootloader
    code from `/etc/nixos/configuration.nix` into it
    - here's an ezxample 
      ```nix
      # bootloader.nix content:
      { config, pkgs, ... }:
      {
        boot.loader.grub.enable = true;
        boot.loader.grub.device = "/dev/nvme0n1";
        boot.loader.grub.useOSProber = true;
      }
      ```
1.  edit the `sysSettings.hostname` in `dotfiles/hix/flake.nix`:
    ```nix
    sysSettings = {
        system = "x86_64-linux";
        hostname = "<HOSTNAME-GOES-HERE>";
        # ... more code ...
    };
    ```
1.  run `just purge && just switch`

---

[Version Badge]:https://img.shields.io/badge/version-24.11.4.1-a47daa?style=for-the-badge&labelColor=616097
