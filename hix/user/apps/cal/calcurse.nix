{pkgs, ...}: {
  home.packages = [pkgs.calcurse];
  home.file = {
    ".config/calcurse" = {
      source = ./../../../../snd/calcurse;
      recursive = true;
    };
  };
}
