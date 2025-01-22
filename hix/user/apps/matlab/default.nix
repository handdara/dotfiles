{...}: {
    home.file = {
        ".config/matlab/nix.sh".text = ''
          INSTALL_DIR=$HOME/apps/matlab/R2022b/
        '';
    };
}
