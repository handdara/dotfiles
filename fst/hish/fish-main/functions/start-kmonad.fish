function start-kmonad
    cd ~/.config/kmonad
    set -Ux KBD_DEV (find /dev/input/by-path/*kbd* | fzf)
    set KBD_CFG_RAW (find -L . -type f| fzf) 
    # set KBDCFG (envsubst < $KBD_CONF)
    set KBD_CFG ( cat $KBD_CFG_RAW | string replace -r '\$KBD_DEV' $KBD_DEV )
    # printf "%s\n" $KBDCFG # uncomment to view the file used on startup
    kmonad (printf "%s\n" $KBD_CFG | psub) &
    # if using hard coded filepath in the .kbd, usethe following and not the above
    # kmonad -d handdara.kbd & 
    set -Ux KMONAD_PID (jobs -lp)
    echo 'kmonad pid: '$KMONAD_PID
    echo $KMONAD_PID > ~/.local/share/fish/kmonad_pid.tmp
    disown $KMONAD_PID
    cd -
end
