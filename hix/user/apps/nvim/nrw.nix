{ pkgs, pkgs_unstable, ... }:
let
  plugin_dir = ../../../../fst/him/nvim-nrw/lua/handdara/plugins;
  get_plugin_path = p:
    let  
      ps = toString plugin_dir;
      fs = "${ps}/${p}";
    in
    builtins.toPath fs;
in
{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    viAlias = true;
    package = pkgs_unstable.neovim-unwrapped;
    extraPackages = with pkgs; [
      python3
      gcc
      gnumake
      pkg-config
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    tree-sitter
    lua-language-server # lua lang server
    marksman # markdown lang server
    rust-analyzer-unwrapped # rust lang server
    nil # nix lang server
    zls # zig lang server
  ];

  home.file = {
    ".config/nvim/init.lua".source = ../../../../fst/him/nvim-nrw/init.lua;
    # ".config/nvim/lazy-lock.json".source = ../../../../fst/him/nvim-nrw/lazy-lock.json;
    ".config/nvim/lua/handdara/config" = {
      source = ../../../../fst/him/nvim-nrw/lua/handdara/config;
      recursive = true;
    };
    ".config/nvim/lua/handdara/plugins/init.lua".source = get_plugin_path "init.lua";
    ".config/nvim/lua/handdara/plugins/telescope.lua".source = get_plugin_path "telescope.lua";
    ".config/nvim/lua/handdara/plugins/treesitter.lua".source = get_plugin_path "treesitter.lua";
    ".config/nvim/lua/handdara/plugins/mini_files.lua".source = get_plugin_path "mini_files.lua";
    ".config/nvim/lua/handdara/plugins/surround.lua".source = get_plugin_path "surround.lua";
    ".config/nvim/lua/handdara/plugins/whichkey.lua".source = get_plugin_path "whichkey.lua";
    ".config/nvim/lua/handdara/plugins/lazydev.lua".source = get_plugin_path "lazydev.lua";
    ".config/nvim/lua/handdara/plugins/lspconfig.lua".source = get_plugin_path "lspconfig.lua";
    ".config/nvim/lua/handdara/plugins/undotree.lua".source = get_plugin_path "undotree.lua";
    ".config/nvim/lua/handdara/plugins/telekasten.lua".source = get_plugin_path "telekasten.lua";
  };
}
