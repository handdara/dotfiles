{ config, lib, pkgs, ... }:

let
  treesitterWithGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.c
    p.vim
    p.vimdoc
    p.bash
    p.comment
    p.css
    p.dockerfile
    p.fish
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.gowork
    p.hcl
    p.javascript
    p.jq
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.rust
    p.toml
    p.typescript
    p.vue
    p.yaml
  ]));

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in
{
  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
    rust-analyzer-unwrapped
    tree-sitter
  ];

  home.file = {
    ".config/nvim/lua" = {
      source = ../../../../fst/him/nvim-main/lua;
      recursive = true;
    };
    ".config/nvim/handdara-snips" = {
      source = ../../../../fst/him/nvim-main/handdara-snips;
      recursive = true;
    };
    ".config/nvim/init.lua".source = ../../../../fst/him/nvim-main/init.lua;
    ".config/nvim/lua/handdara/config/init.lua".text = ''
      require("handdara.config.telescope")
      require("handdara.config.treesitter")
      require("handdara.config.set")
      require("handdara.config.snippet")
      require("handdara.config.lsp")
      require("handdara.config.keymap")
      require("handdara.config.looks")
      require("handdara.config.minifiles")
      require("handdara.config.telekasten")
      require("handdara.config.oil")
      -- require("handdara.config.mkdnflow")
      vim.opt.runtimepath:append("${treesitter-parsers}")
    '';
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    viAlias = true;
    extraPackages = with pkgs; [
        cargo
        clang
        cmake
        gcc
        gnumake
        pkg-config
        python3
    ];
    plugins = [
     treesitterWithGrammars
    ];
  };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file.".local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };
}
