function kill-kmonad
    cat /home/handdara/.local/share/fish/kmonad_pid.tmp | read KMONAD_PID_READ
    kill $KMONAD_PID || kill $KMONAD_PID_READ
end
