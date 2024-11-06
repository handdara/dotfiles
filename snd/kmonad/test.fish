set -Ux KBD_DEV (find /dev/input/by-path/*kbd* | fzf)
set KBD_CFG_RAW (find -L ./keymap -type f| fzf) 
set KBD_CFG ( cat $KBD_CFG_RAW | string replace -r '\$KBD_DEV' $KBD_DEV )
kmonad (printf "%s\n" $KBD_CFG | psub)
