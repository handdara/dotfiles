{...}: {
    home.file = {
        ".tmux.conf".text = ''
            set-option -g default-command bash
            set-option -g mode-keys vi
            set-option -g status-style bg=magenta,fg=white
            set-option -sg escape-time 10
            set-option -g focus-events on
            set-option -g display-time 750
            set-option -g status-left-length 20
            set-option -g status-justify centre
            set-option -g status-position top
            set -g default-terminal "tmux-256color"
            bind-key 'C-.' new-window "bash -ic mg; sleep 0.1"
            bind-key 'C-l' last-window
            bind-key 'C-;' last-pane
        '';
    };
}
