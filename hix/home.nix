{ config
, pkgs
, user_opts
, ...
}: {
  imports = [
    ./system/wm/awesomewm/home.nix
    ./user/apps/alacritty
    ./user/apps/bat
    ./user/apps/btop
    ./user/apps/cal
    # ./user/apps/desmume
    ./user/apps/eza
    ./user/apps/fzf
    ./user/apps/ghostty
    ./user/apps/kmonad
    ./user/apps/lazygit
    ./user/apps/mouseless
    # ./user/apps/megasync
    ./user/apps/nvim
    # ./user/apps/r
    ./user/apps/starship
    ./user/apps/tmux
    # ./user/apps/vim # atm using the vimrc from github:handdara/nix-vimrc
    ./user/apps/x
    ./user/apps/xmonad
    ./user/apps/pdfs
    ./user/apps/zoxide
    ./user/misc/theme
    ./user/shells/bash
    ./user/theme
  ];

  handdara = rec {
    lightworks = true;
    font = "scientifica";
    # font = "MonaspiceAr NF";
    # font = "Maple Mono NF";
    fontui = font + " Bold";
    # fontui = "Miracode";
    # fontui = "MonaspiceKr NF";
    # fontterm = font;
    # fontterm = "scientifica";
    # fontterm = "Miracode";
    # fontterm = "Hasklug Nerd Font";
    fontterm = "Maple Mono NF";
    fontsize = 16;
    transparency = if lightworks then 50 else 80;
    shprompt = "simple";
  };

  # Setting default applications on x11
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "inode/directory" = "thunar.desktop";
      "application/pdf" = "org.pwmt.zathura.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
      "image/jpeg" = "org.xfce.ristretto.desktop";
      "image/png" = "org.xfce.ristretto.desktop";
      "image/webp" = "org.xfce.ristretto.desktop";
      "application/vnd.oasis.opendocument.presentation" = "impress.desktop";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home = rec {
    username = user_opts.username;
    homeDirectory = "/home/" + username;
    sessionPath = [
      "${homeDirectory}/.local/scripts"
      "${homeDirectory}/.local/bin"
    ];
    sessionVariables = {
      SUDO_ASKPASS = "\"$HOME\"/.local/scripts/__h_passwd";
      STACHE_DIR = "\"$HOME\"/.stache";
      EDITOR = "nvim";
      MANPAGER = "__h_nvim -c 'Man!' -o -";
    };

    packages = [
      pkgs.nps
      pkgs.youtube-tui
    ];

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05";
  }; # Please read the comment before changing.
}
