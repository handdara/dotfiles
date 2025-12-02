{...}: {
    programs.alacritty = {
        enable = true;
    };
    home.file.".config/alacritty/alacritty.toml".text = ''
        [font]
        normal = { family = "Terminess Nerd Font", style = "Mono" }
    '';
}
