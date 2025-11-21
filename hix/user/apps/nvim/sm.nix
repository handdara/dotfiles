{pkgs, ...}: {
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
    ];
}
