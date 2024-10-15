{config, pkgs, ... }:
{
  home.file = {
    ".config/nvim" = {
      source = ../../../../fst/him/nvim-main;
      recursive = true;
    };
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
  };
}
