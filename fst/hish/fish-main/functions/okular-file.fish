function okular-file
    if test -n "$argv[1]"
        echo 'opening with okular: '$argv[1]
        okular $argv[1] &
    else
        echo 'error: no file given'
    end
end
