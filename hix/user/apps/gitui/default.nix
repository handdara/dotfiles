{config, pkgs, ... }:
{
  home.file = {
    ".config/gitui/key_bindings.ron".source = ../../../../snd/gitui/key_bindings.ron;
    ".config/gitui/theme.ron".source = ../../../../snd/gitui/theme.ron;
  }; 
}
