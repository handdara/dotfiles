{
    config,
    pkgs,
    nix-vimrc,
    ...
}: {
    nixpkgs.overlays = [
        nix-vimrc.overlay
        (final: prev: {
            neovim = prev.neovim.override {
                extraLuaPreConfig = ''
                    vim.cmd [[colorscheme ${
                        if config.handdara.lightworks
                        then "paper"
                        else "monalisa"
                    }]]
                '';
                extraLuaConfig = ''
                    vim.cmd [[ClearBG]]
                '';
            };
        })
    ];
    home.packages = with pkgs; [
        neovim
        ripgrep
        fd
        tree-sitter
        lua-language-server # lua lang server
        marksman # markdown lang server
        rust-analyzer-unwrapped # rust lang server
        nil # nix lang server
        tinymist
        bash-language-server
        neovim-remote
    ];
    home.sessionVariables = {
        EDITOR = "nvim";
    };
}
