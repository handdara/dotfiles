{config, ...}: {
  home.file.".config/alacritty/alacritty.toml".text = ''
    [font]
    normal = { family = "${config.handdara.fontui or "Monospace"}" }
  '';
}
