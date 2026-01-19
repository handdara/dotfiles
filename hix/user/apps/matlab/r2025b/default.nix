{...}: {
  home.file = {
    ".config/matlab/nix.sh".text = ''
      INSTALL_DIR=$HOME/apps/MATLAB/R2025b/
    '';
  };
}
