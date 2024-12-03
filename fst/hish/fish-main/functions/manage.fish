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
    case '*'
        echo "error: unreachable"
        return 1
end
end
