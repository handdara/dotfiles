{config, pkgs, ... }:
{
  home.file = {
    ".config/starship.toml".source = ../../../../snd/starship/starship.toml;
  };
}
