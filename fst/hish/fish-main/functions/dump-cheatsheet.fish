function dump-cheatsheet
    set -l tempdir (mktemp -d)
    begin
        bind
        abbr
    end > $tempdir/cheatsheet.dump.txt
    echo $tempdir
end
