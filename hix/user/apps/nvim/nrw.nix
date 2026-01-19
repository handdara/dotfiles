{pkgs, ...}: let
  nvim_dir = ../../../../fst/him/nvim-nrw;
  handdara_dir = nvim_dir + /lua/handdara;
  plugin_dir = handdara_dir + /plugins;
  get_plugin_path = f: let
    ps = toString plugin_dir;
    fs = "${ps}/${f}";
  in
    builtins.toPath fs;
  get_handdara_path = f: let
    hs = toString handdara_dir;
    fs = "${hs}/${f}";
  in
    builtins.toPath fs;
  inc_plugin = f: let
    fext = f + ".lua";
    cpath = get_handdara_path fext;
  in
    {".config/nvim/lua/handdara/plugins/${fext}".source = get_plugin_path fext;}
    // (
      if pkgs.lib.pathExists cpath
      then {".config/nvim/lua/handdara/${fext}".source = cpath;}
      else {}
    );
in {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    viAlias = true;
    package = pkgs.neovim-unwrapped;
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
    chafa # terminal graphics dependency for telescope-media-files.nvim
    imagemagick # telescope-media-files.nvim dependency
    poppler_utils # telescope-media-files.nvim optional dependency
    libnotify # notify-nvim plugin dep
    tinymist
  ];

  home.file =
    {
      ".config/nvim/init.lua".source = nvim_dir + /init.lua;
      # ".config/nvim/lazy-lock.json".source = nvim_dir + /lazy-lock.json;
      ".config/nvim/lua/handdara/config" = {
        source = handdara_dir + /config;
        recursive = true;
      };
      ".config/nvim/lua/handdara/snippets" = {
        source = handdara_dir + /snippets;
        recursive = true;
      };
      ".config/nvim/lua/handdara/util" = {
        source = handdara_dir + /util;
        recursive = true;
      };
      ".config/nvim/colors" = {
        source = nvim_dir + /colors;
        recursive = true;
      };
      ".config/nvim/after" = {
        source = nvim_dir + /after;
        recursive = true;
      };
      ".config/nvim/lua/handdara/plugins/init.lua".source = get_plugin_path "init.lua";
      ".config/nvim/lua/handdara/init.lua".source = get_handdara_path "init.lua";
    }
    // inc_plugin "mini_files"
    // inc_plugin "lualine"
    // inc_plugin "git"
    # // inc_plugin "telekasten"
    // inc_plugin "obsidian"
    // inc_plugin "colorizer"
    // inc_plugin "undotree"
    // inc_plugin "whichkey"
    // inc_plugin "lspconfig"
    // inc_plugin "treesitter"
    // inc_plugin "surround"
    // inc_plugin "lazydev"
    // inc_plugin "colors"
    // inc_plugin "carrot"
    // inc_plugin "pomo"
    // inc_plugin "completion"
    // inc_plugin "luasnip"
    // inc_plugin "telescope";
}
