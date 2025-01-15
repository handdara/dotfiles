function manage
    set -l options {\
    'vi-on: turn fish\'s vi mode on',\
    'vi-off: turn fish\'s vi mode off',\
    'rlconf: reload config.fish',\
    'binds: search all fish keybinds',\
    'ubinds: show user fish keybinds',\
    'uibinds: show user insert mode fish keybinds',\
    'kbd-on: start kmonad',\
    'kbd-off: kill kmonad',\
    'fd-proc: search through procs',\
    'kill-proc: search through procs and kill result',\
    'xlock: lock screen',\
    'sc0: set screen backlight to 0',\
    'sc10: set screen backlight to 10',\
    'sc25: set screen backlight to 25',\
    'sc50: set screen backlight to 50',\
    'sc75: set screen backlight to 75',\
    'sc100: set screen backlight to 100',\
    'lowpow: run commands for conserving battery power',\
    'tlp: start tlp in automatically selected mode',\
    'netmgr: start nmtui',\
    'cheatsheet: NOT IMPLEMENTED YET search through cheatsheet'}
    set -l choice ( for o in $options; echo $o; end | fzf | awk -F: '{print $1}' )

    switch $choice
    case 'vi-on'
        fish_vi_key_bindings
    case 'vi-off'
        fish_default_key_bindings
    case 'rlconf'
        if source ~/.config/fish/config.fish
        else
            echo "error: fish config reload unsuccessful"
            return 1
        end
    case 'binds'
        bind | fzf
    case 'ubinds'
        # show non preset bindings
        bind                                          \
        | grep -v preset                          \
        # | sed -n 's/bind \(-m \([a-z]*\) \)*//ip' \
        # | sed -n 's/ / : /p'                      \
        # | sed -n 's/-/ /gp'                       \
        | sed    's/\\\\c/CTRL\+/'                \
        | sed    's/\\\\e/ ALT\+/'
    case 'uibinds'
        # show non preset insert-mode bindings
        bind -M insert                          \
        | grep -v preset                    \
        | sed -n 's/\([^ ]* \)*\\\\/\\\\/p' \
        | sed -n 's/ / : /p'                \
        | sed -n 's/-/ /gp'                 \
        | sed    's/\\\\c/CTRL\+/'          \
        | sed    's/\\\\e/ ALT\+/'
    case 'kbd-on'
        start-kmonad
    case 'kbd-off'
        kill-kmonad
    case 'fd-proc'
        set -gx MG_LAST_PROC_ID (ps -e | fzf | sed 's/\( \+\)\([0-9]*\)\( \+.*\)/\\2/' )
        echo $MG_LAST_PROC_ID | xclip -selection clipboard
    case 'kill-proc'
        set -gx MG_LAST_PROC_ID (ps -e | fzf | sed 's/\( \+\)\([0-9]*\)\( \+.*\)/\\2/' )
        kill -9 $MG_LAST_PROC_ID
    case 'xlock'
        xlock -mode thornbird
    case 'sc0'
        brightnessctl set 0%
    case 'sc10'
        brightnessctl set 10%
    case 'sc25'
        brightnessctl set 25%
    case 'sc50'
        brightnessctl set 50%
    case 'sc75'
        brightnessctl set 75%
    case 'sc100'
        brightnessctl set 100%
    case 'lowpow'
        brightnessctl set 0%
        sudo tlp bat
    case 'tlp'
        sudo tlp start
    case 'netmgr'
        nmtui
    case 'bluemgr'
        blueman-manager
    case 'vol'
        pavucontrol
    case '*'
        echo "error: unreachable"
        return 1
    end
end
