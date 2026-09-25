{ pkgs, ... }: {
  home.packages = [ pkgs.blesh ];
  programs.bash = {
    enable = true;
    shellAliases = {
      cal = "cal -mv";
      cat = "bat --color=never";
      ea = "ls -a";
      ed = "eza --tree -D --group-directories-first";
      editor = "__h_nvim";
      ela = "ls -la";
      el = "eza -l";
      e = "ls";
      et = "eza --tree --group-directories-first";
      fdf = "__h_fd f";
      fdfh = "__h_fd f ~";
      fdfm = "__h_fd f ~/MEGA";
      fdi = "__h_fdi";
      fdih = "__h_fdi ~";
      fdim = "__h_fdi ~/MEGA";
      fdr = "__h_fd d";
      fdrh = "__h_fd d ~";
      fdrm = "__h_fd d ~/MEGA";
      ga = "git add";
      gcom = "git commit";
      gd = "git diff";
      gs = "git status --short";
      j = "just";
      lfg = "lazygit; fg";
      lzg = "lazygit";
      mkobl = "khal new -a obl";
      mkrem = "khal new -a rem";
      n = "__h_nvim";
      tempvim = "nvim -n --clean -u NONE -i NONE";
      viman = "nvim -Rc 'set ft=man'";
      xcn = "xclip -selection clipboard";
      xc = "xclip -rmlastnl -selection clipboard";
      xp = "xclip -selection clipboard -o";
      z = "cd";
      zd = "z \"\$(fd -utd '' . | fzf || pwd)\"";
      zf = "z \"\$(fd -utf '' . | fzf | xargs __h_dirname || pwd)\"";
      zhd = "z \"\$(fd -utd '' ~ | fzf || pwd)\"";
      zhf = "z \"\$(fd -utf '' ~ | fzf | xargs __h_dirname || pwd)\"";
      zh = "z \"\$(fd -utf -td '' ~ | fzf | xargs __h_dirname || pwd)\"";
      zm = "z \"\$(fd -utf -td '' ~/MEGA | fzf | xargs __h_dirname || pwd)\"";
      zt = "z $(mktemp -d)";
      "z-" = "z -";
      zz = "z \"\$(fd -utf -td '' . | fzf | xargs __h_dirname || pwd)\"";
    };
    bashrcExtra = ''
      export _ZO_MAXAGE=100000
      export historySize=100000
      export historyFileSize=10000000
    '';
    initExtra = ''
      if [ ! $H_DISABLE_BLESH ]; then
        source -- $(blesh-share)/ble.sh
      fi
      eval "$(fzf --bash)"
      eval "$(zoxide init bash )"
    '';
  };
}
