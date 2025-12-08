{
    user_opts,
    config,
    nix-vimrc,
    ...
}: {
    imports = [
        ./system/wm/awesomewm/home.nix
        ./user/apps/alacritty
        ./user/apps/asciinema
        ./user/apps/bat
        ./user/apps/bc
        ./user/apps/btop
        ./user/apps/cal
        ./user/apps/chafa
        ./user/apps/croc
        ./user/apps/ctags
        ./user/apps/desmume
        ./user/apps/eza
        ./user/apps/fim
        ./user/apps/flameshot
        ./user/apps/fzf
        ./user/apps/ghostty
        ./user/apps/imagemagick
        ./user/apps/jqyq
        ./user/apps/just
        ./user/apps/kmonad
        ./user/apps/lazygit
        ./user/apps/libnotify
        # ./user/apps/lxappearance
        ./user/apps/mail
        ./user/apps/matlab
        ./user/apps/megacmd
        ./user/apps/misc-cli
        ./user/apps/mouseless
        ./user/apps/mpv
        ./user/apps/nvim
        ./user/apps/pastel
        # ./user/apps/r
        ./user/apps/redshift
        ./user/apps/starship
        ./user/apps/tealdeer
        ./user/apps/tmux
        ./user/apps/vim
        ./user/apps/vivaldi
        ./user/apps/w3m
        ./user/apps/watchexec
        ./user/apps/wiki-tui
        ./user/apps/xcolor
        ./user/apps/yt-dlp
        ./user/apps/pdfs
        ./user/apps/zoxide
        ./user/misc/theme
        ./user/shells/bash
        ./user/theme
    ];

    handdara = {
        lightworks = false;
        font = "iMWritingMono Nerd Font"; # Terminess Nerd Font | BlexMono Nerd Font | AtkynsonMono NF | FantasqueSansM Nerd Font Bold
        fontsize = 14;
    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [
        nix-vimrc.overlay
        (final: prev: {
            neovim = prev.neovim.override {
                extraLuaPreConfig = ''
                    vim.cmd [[colorscheme ${
                        if config.handdara.lightworks
                        then "delek"
                        else "monalisa"
                    }]]
                '';
            };
        })
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home = rec {
        username = user_opts.username;
        homeDirectory = "/home/" + username;
        sessionPath = [
            "${homeDirectory}/.local/scripts"
        ];
        sessionVariables = {
            SUDO_ASKPASS = "\"$HOME\"/.local/scripts/__h_sha76passwd";
        };

        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        stateVersion = "24.05";
    }; # Please read the comment before changing.
}
