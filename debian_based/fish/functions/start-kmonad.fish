function start-kmonad
    cd ~/.dotfiles/debian_based/kmonad/keymap 
    set -Ux KBD_DEV (find /dev/input/by-path/*kbd* | fzf)
    set KBD_CONF (fd --glob -tf -d 1 -e kbd | fzf) 
    set KBDCFG (envsubst < $KBD_CONF)
    # printf "%s\n" $KBDCFG # uncomment to view the file used on startup
    kmonad (printf "%s\n" $KBDCFG | psub) &
    # if using hard coded filepath in the .kbd, usethe following and not the above
    # kmonad -d handdara.kbd & 
    set -Ux KMONAD_PID (jobs -lp)
    echo 'kmonad pid: '$KMONAD_PID
    echo $KMONAD_PID > ~/.local/share/fish/kmonad_pid.tmp
    disown $KMONAD_PID
    cd -
end
