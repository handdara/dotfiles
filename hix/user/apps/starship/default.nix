{config, pkgs, ... }:
{
  home.file = {
    ".config/starship.toml".source = ../../../../snd/starship/starship.toml;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
