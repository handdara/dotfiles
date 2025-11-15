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
        nerd-fonts.departure-mono
        nerd-fonts.fantasque-sans-mono
        nerd-fonts.monofur
        nerd-fonts.bigblue-terminal
        nerd-fonts.terminess-ttf
        maple-mono.NF
        recursive
    ];
}
