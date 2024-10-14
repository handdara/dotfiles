{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "handdara";
  home.homeDirectory = "/home/handdara";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/fish/config.fish".source = ../../fst/hish/fish-main/config.fish;
    ".config/fish/functions" = {
      source = ../../fst/hish/fish-main/functions;
      recursive = true;
    };
    ".config/nvim" = {
      source = ../../fst/him/nvim-main;
      recursive = true;
    };
    ".config/wezterm" = {
      source = ../../fst/hez/wezterm-main;
      recursive = true;
    };
    ".config/starship.toml".source = ../../snd/starship/starship.toml;
    ".config/gitui/key_bindings.ron".source = ../../snd/gitui/key_bindings.ron;
    ".config/gitui/theme.ron".source = ../../snd/gitui/theme.ron;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/handdara/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      z = "cd";
      e = "ls";
      ea = "ls -a";
      ela = "ls -la";
      ga = "git add";
      gs = "git status";
      gcom = "git commit";
      gdh = "git diff HEAD";
      j = "just";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
  };
}
