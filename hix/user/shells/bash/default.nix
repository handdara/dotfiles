{pkgs, ...}: {
    home.packages = [pkgs.blesh];
    programs.bash = {
        enable = true;
        shellAliases = {
            z = "cd";
            e = "ls";
            ea = "ls -a";
            el = "eza -l";
            et = "eza --tree --group-directories-first";
            ed = "eza --tree -D --group-directories-first";
            ela = "ls -la";
            ga = "git add";
            gs = "git status";
            gcom = "git commit";
            gdh = "git diff HEAD";
            j = "just";
            xc = "xclip -rmlastnl -selection clipboard";
            xcn = "xclip -selection clipboard";
            xp = "xclip -selection clipboard -o";
            fdf = "__h_fd f";
            fdr = "__h_fd d";
            fdi = "__h_fdi";
            fdfh = "__h_fd f ~";
            fdrh = "__h_fd d ~";
            fdih = "__h_fdi ~";
            fdfm = "__h_fd f ~/MEGA";
            fdrm = "__h_fd d ~/MEGA";
            fdim = "__h_fdi ~/MEGA";
            "z-" = "z -";
            viman = "__h_nvim -Rc 'set ft=man'";
            zt = "z $(mktemp -d)";
            zd = "z \"\$(fd -utd '' . | fzf || pwd)\"";
            zf = "z \"\$(fd -utf '' . | fzf | xargs __h_dirname || pwd)\"";
            zz = "z \"\$(fd -utf -td '' . | fzf | xargs __h_dirname || pwd)\"";
            zhd = "z \"\$(fd -utd '' ~ | fzf || pwd)\"";
            zhf = "z \"\$(fd -utf '' ~ | fzf | xargs __h_dirname || pwd)\"";
            zh = "z \"\$(fd -utf -td '' ~ | fzf | xargs __h_dirname || pwd)\"";
            zm = "z \"\$(fd -utf -td '' ~/MEGA | fzf | xargs __h_dirname || pwd)\"";
            cat = "bat";
            cal = "cal -mv";
            mkrem = "khal new -a rem";
            mkobl = "khal new -a obl";
            tempvim = "nvim -n --clean -u NONE -i NONE";
            n = "__h_nvim";
            editor = "__h_nvim";
            lzg = "lazygit";
            lfg = "lazygit; fg";
        };
        bashrcExtra = ''
            export _ZO_MAXAGE=100000
            export historySize=100000
            export historyFileSize=10000000
        '';
        initExtra = ''
            source -- $(blesh-share)/ble.sh
            eval "$(fzf --bash)"
            eval "$(zoxide init bash )"
        '';
    };
}
