{...}:
{
    programs.kitty = {
        enable = true;
        font = {
            name = "SpaceMono Nerd Font";
            size = 14;
        };
        settings = {
            cursor_shape = "block";
            cursor_blink_interval = 0;
            hide_window_decorations = true;
            clear_all_shortcuts = true;
        };
        extraConfig = ''
            background_opacity 0.9
        '';
        keybindings = {
            "ctrl+shift+v" = "paste_from_clipboard";
            "ctrl+shift+c" = "copy_to_clipboard";
            "f11" = "toggle_fullscreen";
            "ctrl+shift+p" = "kitty_shell overlay";
        };
    };
}
