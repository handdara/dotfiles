# handdara's dotfiles

i think you should listen to _by storm's_ album _my ghost's go ghost_.

`nix`: Nix(OS) configuration files. almost the whole shebang.

`fst`: first layer: core tools. right now this is: neovim, and git, of which the former has been subsumed by [codeberg:handdara/nix-vimrc][], and the latter is quite barebones, to say the least.
basically, what i'm trying to say is moving to nix destroyed any need for this folder's old contents.
i should probably just remove it or merge it with `snd` but i left it on a whim and now i don't feel like changing that.

- `git`: git config
- `him`: neovim configs, all of these are older versions who've been subsumed by [codeberg:handdara/nix-vimrc][].

`snd`: secondary layer: tools that don't fit into core.[^1]

-   `awesomewm`: my window manager, i like it. don't love it. mostly because of the documentation, and for another reason whose precise definition eludes me tbh
-   ~`calcurse`~: not using this at the moment, instead i've been using [github:pimutils/khal][].[^2]
-   `ish`: an ios app[^3] that provides a linux like environment based on alpine (or maybe even
-   `kmonad`: an amazing keyboard remapping utility! also, it's written in haskell :)
-   `xmonad`: slowly building up a config by messing around with it every now and then 

## usage

_section needs updating, will get to it soon._

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
    - here's an example 
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

[^1]: now this basically just means i didn't feel like putting their dotfiles into a nix string.
[^2]: i like and would recommend both.
[^3]: yea yea i know, iphones: gross. the iSH project is pretty cool though and i've enjoyed my experience with it.

[codeberg:handdara/nix-vimrc]: https://codeberg.org/handdara/nix-vimrc
[github:pimutils/khal]: https://github.com/pimutils/khal
