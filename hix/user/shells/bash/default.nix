{...}: {
    programs.bash = {
        enable = true;
        shellAliases = {
            z = "cd";
            e = "ls";
            ea = "ls -a";
            el = "eza -l";
            et = "eza --tree --group-directories-first";
            ed = "eza --tree --group-directories-first -D";
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
            fdfh = "fd -utf '' ~ | fzf -m";
            fdrh = "fd -utd '' ~ | fzf -m";
            "z-" = "z -";
            zt = "z $(mktemp -d)";
            zd = "z \"\$(fd -utd '' . | fzf || echo '/DNE')\"";
            zf = "z \"\$(fd -utf '' . | fzf | xargs dirname || echo '/DNE')\"";
            zz = "z \"\$(fd -utf -td '' . | fzf | xargs dirname || echo '/DNE')\"";
            zhd = "z \"\$(fd -utd '' ~ | fzf || echo '/DNE')\"";
            zhf = "z \"\$(fd -utf '' ~ | fzf | xargs dirname || echo '/DNE')\"";
            zh = "z \"\$(fd -utf -td '' ~ | fzf | xargs dirname || echo '/DNE')\"";
            zcd = "z \"\$(fd -utd '' ~/code | fzf || echo '/DNE')\"";
            zcf = "z \"\$(fd -utf --min-depth 2 '' ~/code | fzf | xargs dirname  || echo '/DNE')\"";
            zc = "z \"\$(fd -utf -td --min-depth 2 '' ~/code | fzf | xargs dirname || echo '/DNE')\"";
        };
        # bashrcExtra = ''
        #   export PATH="$PATH:~/.yarn/bin"
        #   eval "$(ssh-agent -s)"
        # '';
    };
}
