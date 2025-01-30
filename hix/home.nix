{user_opts, ...}: {
    imports = [
        ./system/wm/awesomewm/home.nix
        ./user/apps/alacritty
        ./user/apps/bat
        ./user/apps/btop
        ./user/apps/calcurse
        ./user/apps/eza
        ./user/apps/fim
        ./user/apps/fzf
        ./user/apps/ghostty
        ./user/apps/jqyq
        ./user/apps/just
        ./user/apps/kmonad
        ./user/apps/mail
        ./user/apps/matlab
        ./user/apps/megacmd
        ./user/apps/neofetch
        ./user/apps/nvim
        ./user/apps/pandoc
        # ./user/apps/r
        ./user/apps/starship
        ./user/apps/tealdeer
        ./user/apps/vim
        ./user/apps/vivaldi
        ./user/apps/watchexec
        ./user/apps/wezterm
        ./user/apps/wiki-tui
        ./user/apps/write
        ./user/apps/zathura
        ./user/apps/zoxide
        ./user/misc/theme
        ./user/shells/bash
        ./user/shells/fish
    ];

    home.username = user_opts.username;
    home.homeDirectory = "/home/" + user_opts.username;

    nixpkgs.config.allowUnfree = true;

    programs.home-manager.enable = true; # Let Home Manager install and manage itself.

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.05"; # Please read the comment before changing.
}
