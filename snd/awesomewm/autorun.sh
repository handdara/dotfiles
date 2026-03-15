#!/bin/sh
run() {
    if ! pgrep -f "$1"; then
        nohup "$@" >/dev/null 2>&1 &
    fi
}
run "volctl"
run "flameshot"
run "rm /tmp/nvimsocket"
