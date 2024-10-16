{ config, pkgs, sysSettings, userSettings, ... }:
{
  imports = [
    ./user/shells/bash/default.nix
    ./user/shells/fish/default.nix
    ./user/apps/wezterm/default.nix
    ./user/apps/nvim/default.nix
    ./user/apps/starship/default.nix
    ./user/apps/gitui/default.nix
    ./user/apps/btop/default.nix
    ./user/apps/zoxide/default.nix
    ./user/apps/eza/default.nix
    ./user/apps/bat/default.nix
  ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = userSettings.editor;
  };

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
}
