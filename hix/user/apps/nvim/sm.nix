{pkgs, ...}: let
    nvim_dir = ../../../../fst/him/nvim-sm;
    handdara_dir = nvim_dir + /lua/handdara;
in {
    programs.neovim = {
        enable = true;
        viAlias = true;
        # package = pkgs_unstable.neovim-unwrapped;
        plugins = [
            pkgs.vimPlugins.fzf-lua
            pkgs.vimPlugins.mini-files
            pkgs.vimPlugins.nvim-surround
            pkgs.vimPlugins.nvim-treesitter
            pkgs.vimPlugins.nvim-web-devicons
            pkgs.vimPlugins.obsidian-nvim
            pkgs.vimPlugins.plenary-nvim
            pkgs.vimPlugins.undotree
            # colorthemes
            pkgs.vimPlugins.eva01-vim
            pkgs.vimPlugins.rose-pine
            pkgs.vimPlugins.vim-paper
            pkgs.vimPlugins.boo-colorscheme-nvim
            # treesitter parsers
            pkgs.vimPlugins.nvim-treesitter-parsers.asm
            pkgs.vimPlugins.nvim-treesitter-parsers.awk
            pkgs.vimPlugins.nvim-treesitter-parsers.bibtex
            pkgs.vimPlugins.nvim-treesitter-parsers.cmake
            pkgs.vimPlugins.nvim-treesitter-parsers.cpp
            pkgs.vimPlugins.nvim-treesitter-parsers.css
            pkgs.vimPlugins.nvim-treesitter-parsers.csv
            pkgs.vimPlugins.nvim-treesitter-parsers.fish
            pkgs.vimPlugins.nvim-treesitter-parsers.fortran
            pkgs.vimPlugins.nvim-treesitter-parsers.gitcommit
            pkgs.vimPlugins.nvim-treesitter-parsers.git_rebase
            pkgs.vimPlugins.nvim-treesitter-parsers.gitignore
            pkgs.vimPlugins.nvim-treesitter-parsers.gnuplot
            pkgs.vimPlugins.nvim-treesitter-parsers.haskell
            pkgs.vimPlugins.nvim-treesitter-parsers.html
            pkgs.vimPlugins.nvim-treesitter-parsers.ini
            pkgs.vimPlugins.nvim-treesitter-parsers.jq
            pkgs.vimPlugins.nvim-treesitter-parsers.json
            pkgs.vimPlugins.nvim-treesitter-parsers.just
            pkgs.vimPlugins.nvim-treesitter-parsers.kdl
            pkgs.vimPlugins.nvim-treesitter-parsers.latex
            pkgs.vimPlugins.nvim-treesitter-parsers.luadoc
            pkgs.vimPlugins.nvim-treesitter-parsers.make
            pkgs.vimPlugins.nvim-treesitter-parsers.nix
            pkgs.vimPlugins.nvim-treesitter-parsers.perl
            pkgs.vimPlugins.nvim-treesitter-parsers.python
            pkgs.vimPlugins.nvim-treesitter-parsers.r
            pkgs.vimPlugins.nvim-treesitter-parsers.regex
            pkgs.vimPlugins.nvim-treesitter-parsers.rust
            pkgs.vimPlugins.nvim-treesitter-parsers.sql
            pkgs.vimPlugins.nvim-treesitter-parsers.tcl
            pkgs.vimPlugins.nvim-treesitter-parsers.tmux
            pkgs.vimPlugins.nvim-treesitter-parsers.typst
            pkgs.vimPlugins.nvim-treesitter-parsers.yaml
            pkgs.vimPlugins.nvim-treesitter-parsers.zig
        ];
        extraPackages = [
            pkgs.python3
            pkgs.gcc
            pkgs.gnumake
            pkgs.pkg-config
        ];
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
        tinymist
    ];

    home.file = {
        ".config/nvim/init.lua".source = nvim_dir + /init.lua;
        ".config/nvim/lua/handdara/config" = {
            source = handdara_dir + /config;
            recursive = true;
        };
        ".config/nvim/after" = {
            source = nvim_dir + /after;
            recursive = true;
        };
    };
}
