{pkgs, ...}: {
    home.packages = [pkgs.blesh];
    programs.bash = {
        enable = true;
        historySize = 100000;
        historyFileSize = 10000000;
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
            fdf = "fd -utf '' . | fzf -m";
            fdr = "fd -utd '' . | fzf -m";
            fdi = "fd -utf -e png -e jpg -e jpeg '' . | __h_pick_imgs";
            fdfh = "fd -utf '' ~ | fzf -m";
            fdrh = "fd -utd '' ~ | fzf -m";
            fdih = "fd -utf -e png -e jpg -e jpeg '' ~ | __h_pick_imgs";
            "z-" = "z -";
            vpdf = "zathura";
            vimg = "fim";
            viman = "nvim -Rc 'set ft=man'";
            zt = "z $(mktemp -d)";
            zd = "z \"\$(fd -utd '' . | fzf || echo '/DNE')\"";
            zf = "z \"\$(fd -utf '' . | fzf | xargs dirname || echo '/DNE')\"";
            zz = "z \"\$(fd -utf -td '' . | fzf | xargs dirname || echo '/DNE')\"";
            zhd = "z \"\$(fd -utd '' ~ | fzf || echo '/DNE')\"";
            zhf = "z \"\$(fd -utf '' ~ | fzf | xargs dirname || echo '/DNE')\"";
            zh = "z \"\$(fd -utf -td '' ~ | fzf | xargs dirname || echo '/DNE')\"";
            zm = "z \"\$(fd -utf -td '' ~/MEGA | fzf | xargs dirname || echo '/DNE')\"";
            zcd = "z \"\$(fd -utd '' ~/code | fzf || echo '/DNE')\"";
            zcf = "z \"\$(fd -utf --min-depth 2 '' ~/code | fzf | xargs dirname  || echo '/DNE')\"";
            zc = "z \"\$(fd -utf -td --min-depth 2 '' ~/code | fzf | xargs dirname || echo '/DNE')\"";
            cat = "bat";
            cal = "cal -mv";
            mkrem = "khal new -a rem";
            mkobl = "khal new -a obl";
            tempvim = "nvim -n --clean -u NONE -i NONE";
            editor = "nvr --remote-wait-silent";
            lzg = "lazygit";
            lfg = "lazygit; fg";
        };
        bashrcExtra = ''
            export SUDO_ASKPASS=$HOME/.local/scripts/__h_sha76passwd
            export PATH="~/.local/bin:$PATH"
            export PATH="~/.local/scripts:$PATH"
            export EDITOR="nvr --remote-wait-silent"
            export _ZO_MAXAGE=100000
        '';
        initExtra = ''
            source -- $(blesh-share)/ble.sh
            eval "$(fzf --bash)"
            eval "$(zoxide init bash )"
        '';
    };
}
