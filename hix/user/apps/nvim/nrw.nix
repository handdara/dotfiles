{ pkgs, pkgs_unstable, ... }:
{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    viAlias = true;
    package = pkgs_unstable.neovim-unwrapped;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    ripgrep
    fd
  ];

  home.file = {
    ".config/nvim/init.lua".source = ../../../../fst/him/nvim-nrw/init.lua;
  };
}
