{pkgs, ...}: {
    fonts.packages = with pkgs; [
        nerdfonts
        maple-mono
    ];
}
