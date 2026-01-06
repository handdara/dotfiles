{config, ...}: {
    home.file.".Xresources".text = ''
        XTerm*faceName: ${config.handdara.font or "Monospace"}
        XTerm*faceSize: ${builtins.toString (config.handdara.fontsize or 14)}
        XTerm*foreground: ${
            if config.handdara.lightworks
            then "black"
            else "white"
        }
        XTerm*background: ${
            if config.handdara.lightworks
            then "white"
            else "black"
        }
        XTerm*cursorColor: ${
            if config.handdara.lightworks
            then "black"
            else "white"
        }
    '';
}
