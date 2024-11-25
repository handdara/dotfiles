{ opts, ... }:
{
    imports = [
        ./user/apps/bat
        ./user/apps/btop
        ./user/apps/eza
        ./user/apps/fzf
        ./user/apps/gpg
        ./user/apps/just
        ./user/apps/kmonad
        ./user/apps/megacmd
        ./user/apps/neofetch
        ./user/apps/nvim/nrw.nix
        ./user/apps/pandoc
        ./user/apps/starship
        ./user/apps/vim
        ./user/apps/vivaldi
        ./user/apps/wezterm
        ./user/apps/zoxide
        ./user/shells/bash
        ./user/shells/fish
    ];

    home.username = opts.user.username;
    home.homeDirectory = "/home/"+opts.user.username;

    nixpkgs.config.allowUnfree = true;

    programs.home-manager.enable = true; # Let Home Manager install and manage itself.

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.05"; # Please read the comment before changing.
}
