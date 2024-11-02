{ userSettings, ... }:
{
  imports = [
    ./user/shells/bash/default.nix
    ./user/shells/fish/default.nix
    ./user/apps/wezterm/default.nix
    # ./user/apps/nvim/default.nix
    ./user/apps/nvim/nrw.nix # nixos rewrite #1
    ./user/apps/fzf/default.nix
    ./user/apps/starship/default.nix
    ./user/apps/gitui/default.nix
    ./user/apps/btop/default.nix
    ./user/apps/zoxide/default.nix
    ./user/apps/eza/default.nix
    ./user/apps/bat/default.nix
    # ./user/apps/megasync/default.nix
    ./user/apps/megacmd/default.nix
    ./user/apps/neofetch/default.nix
    ./user/apps/kmonad/default.nix
    ./user/apps/pandoc/default.nix
    ./user/apps/vim/default.nix
    ./user/apps/gpg/default.nix
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
