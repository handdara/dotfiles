function manage
set -l options \
'vi-mode-on
vi-mode-off
reload-config
show-user-fish-keybinds
show-user-insert-mode-fish-keybinds
search-all-fish-keybinds'
set -l choice ( echo $options | fzf )
switch $choice
    case 'vi-mode-on'
        fish_vi_key_bindings
    case 'vi-mode-off'
        fish_default_key_bindings
    case 'reload-config'
        if source ~/.config/fish/config.fish
        else
            echo "error: fish config reload unsuccessful"
            return 1
        end
    case 'search-all-fish-keybinds'
        bind | fzf
    case 'show-user-fish-keybinds'
        # show non preset bindings
        bind                                          \
            | grep -v preset                          \
            # | sed -n 's/bind \(-m \([a-z]*\) \)*//ip' \
            # | sed -n 's/ / : /p'                      \
            # | sed -n 's/-/ /gp'                       \
            | sed    's/\\\\c/CTRL\+/'                \
            | sed    's/\\\\e/ ALT\+/'
    case 'show-user-insert-mode-fish-keybinds'
        # show non preset insert-mode bindings
        bind -M insert                          \
            | grep -v preset                    \
            | sed -n 's/\([^ ]* \)*\\\\/\\\\/p' \
            | sed -n 's/ / : /p'                \
            | sed -n 's/-/ /gp'                 \
            | sed    's/\\\\c/CTRL\+/'          \
            | sed    's/\\\\e/ ALT\+/'
    case '*'
        echo "error: unreachable"
        return 1
end
end
