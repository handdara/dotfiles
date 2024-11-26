function fesh
    set PROJPATH '~/code:~/apps'
    set projdir (begin
        for dir in $PROJPATH
            fd --format '{//}' -e md -e txt -iHId 2 'readme' (string replace '~' $HOME $dir) \
            | string replace $HOME '~'
        end | fzf
    end)
    if not test $projdir
        echo "Cancelled!" >&2
        return 1
    else
        cd (string replace '~' $HOME $projdir)
        if test -e Session.vim
            nvim -S Session.vim
        else
            nvim
        end
    end
end
