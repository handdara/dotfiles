{ userSettings, ... }:
{
  imports = [
    ./user/shells/bash
    ./user/shells/fish
    ./user/apps/wezterm
    ./user/apps/nvim/nrw.nix
    ./user/apps/fzf
    ./user/apps/starship
    ./user/apps/gitui
    ./user/apps/btop
    ./user/apps/zoxide
    ./user/apps/eza
    ./user/apps/bat
    # ./user/apps/megasync
    ./user/apps/megacmd
    ./user/apps/neofetch
    ./user/apps/kmonad
    ./user/apps/pandoc
    ./user/apps/vim
    ./user/apps/gpg
  ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
