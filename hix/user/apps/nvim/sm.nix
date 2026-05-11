{ config
, pkgs
, nix-vimrc
, ...
}: {
  nixpkgs.overlays = [
    nix-vimrc.overlay
    (final: prev: {
      neovim = prev.neovim.override {
        extraLuaPreConfig = ''
          vim.cmd [[colorscheme ${
            if config.handdara.lightworks
            then "paper"
            else "nvimgelion"
          }]]
        '';
        extraLuaConfig = ''
          vim.cmd [[ClearBG]]
        '';
      };
    })
  ];
  home.packages = with pkgs; [
    bash-language-server
    fd
    lua-language-server # lua lang server
    marksman # markdown lang server
    neovim
    neovim-remote
    nil # nix lang server
    nixpkgs-fmt
    ripgrep
    rust-analyzer-unwrapped # rust lang server
    tinymist
    tree-sitter
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
