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
    ];
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
    ".config/nvim/lua/handdara/config" = {
      source = ../../../../fst/him/nvim-nrw/lua/handdara/config;
      recursive = true;
    };
    ".config/nvim/lua/handdara/plugins/init.lua".source = get_plugin_path "init.lua";
    ".config/nvim/lua/handdara/plugins/telescope.lua".source = get_plugin_path "telescope.lua";
    ".config/nvim/lua/handdara/plugins/mini_files.lua".source = get_plugin_path "mini_files.lua";
  };
}
