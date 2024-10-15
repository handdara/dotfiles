{config, pkgs, ... }:
{
  home.file = {
    ".config/fish/config.fish".source = ../../../../fst/hish/fish-main/config.fish;
    ".config/fish/functions" = {
      source = ../../../../fst/hish/fish-main/functions;
      recursive = true;
    };
  };
}
