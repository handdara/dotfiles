{config, pkgs, ... }:
{
  home.file = {
    ".config/nvim" = {
      source = ../../../../fst/him/nvim-main;
      recursive = true;
    };
  };
}
