function manage
set -l options \
'vi-mode-on
vi-mode-off
reload-config
show-insert-mode-binds'
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
    case 'show-insert-mode-binds'
        fish_default_key_bindings
        bind -M insert | rg -v preset # show non preset insert-mode bindings
    case '*'
        echo "error: unreachable"
        return 1
end

end
