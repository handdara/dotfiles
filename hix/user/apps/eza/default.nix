{config, pkgs, ... }:
{
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
