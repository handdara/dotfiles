{pkgs, ...}: {
    fonts.packages = with pkgs; [
        nerd-fonts.monoid
        nerd-fonts.hasklug
        nerd-fonts.open-dyslexic
        nerd-fonts.hurmit
        nerd-fonts.im-writing
        nerd-fonts.heavy-data
        nerd-fonts.blex-mono
        nerd-fonts.atkynson-mono
        nerd-fonts.agave
        nerd-fonts._3270
        maple-mono.NF
    ];
}
