{ config, ... }: {
  home.file.".config/alacritty/alacritty.toml".text = ''
    [font]
    normal = { family = "${config.handdara.fontterm or "Monospace"}" }
  '';
}
