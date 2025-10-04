{...}: {
    home.file = {
        ".tmux.conf".text = ''
          set-option -g mode-keys vi
          set-option -g status-style bg=magenta,fg=white
          set-option -g display-time 750
          set-option -g status-left-length 20
          set-option -g status-justify centre
          set-option -g detach-on-destroy no-detached
          set -g default-terminal "tmux-256color"
        '';
    };
}
