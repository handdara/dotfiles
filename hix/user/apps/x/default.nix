{
    config,
    ...
}: {
    home.file.".Xresources".text = ''
        XTerm*faceName: ${config.handdara.fontnone or "Monospace"}
        XTerm*faceSize: ${builtins.toString (config.handdara.fontsize + 2)}
        XTerm*foreground: ${
            if (config.handdara.lightworks)
            then "black"
            else "white"
        }
        XTerm*background: black ${
            if (config.handdara.lightworks)
            then "white"
            else "black"
        }
        XTerm*cursorColor: white ${
            if (config.handdara.lightworks)
            then "black"
            else "white"
        }
    '';
}
