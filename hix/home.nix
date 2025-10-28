{
    user_opts,
    nix-vimrc,
    ...
}: {
    imports = [
        ./system/wm/awesomewm/home.nix
        ./user/apps/alacritty
        ./user/apps/bat
        ./user/apps/bc
        ./user/apps/btop
        ./user/apps/cal
        ./user/apps/chafa
        ./user/apps/ctags
        ./user/apps/desmume
        ./user/apps/eza
        ./user/apps/fim
        ./user/apps/fortune
        ./user/apps/fzf
        ./user/apps/ghostty
        ./user/apps/jqyq
        ./user/apps/just
        ./user/apps/kmonad
        ./user/apps/lazygit
        ./user/apps/mail
        ./user/apps/matlab
        ./user/apps/megacmd
        ./user/apps/neofetch
        ./user/apps/nvim
        ./user/apps/pandoc
        ./user/apps/pastel
        # ./user/apps/r
        # ./user/apps/redshift
        ./user/apps/starship
        ./user/apps/tealdeer
        ./user/apps/tmux
        ./user/apps/vim
        ./user/apps/vivaldi
        ./user/apps/w3m
        ./user/apps/watchexec
        ./user/apps/wiki-tui
        ./user/apps/write
        ./user/apps/xcolor
        ./user/apps/zathura
        ./user/apps/zotero
        ./user/apps/zoxide
        ./user/misc/theme
        ./user/shells/bash
        ./user/theme
    ];

    home.username = user_opts.username;
    home.homeDirectory = "/home/" + user_opts.username;

    handdara.lightworks = false;

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [nix-vimrc.overlay];

    programs.home-manager.enable = true; # Let Home Manager install and manage itself.

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.05"; # Please read the comment before changing.
}
