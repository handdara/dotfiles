{pkgs, ...}: {
    fonts.packages = with pkgs; [
        maple-mono.NF
        nerd-fonts._3270
        nerd-fonts.agave
        nerd-fonts.atkynson-mono
        nerd-fonts.bigblue-terminal
        nerd-fonts.blex-mono
        nerd-fonts.departure-mono
        nerd-fonts.fantasque-sans-mono
        nerd-fonts.hasklug
        nerd-fonts.heavy-data
        nerd-fonts.hurmit
        nerd-fonts.im-writing
        nerd-fonts.monofur
        nerd-fonts.monoid
        nerd-fonts.mononoki
        nerd-fonts.open-dyslexic
        nerd-fonts.proggy-clean-tt
        nerd-fonts.terminess-ttf
        recursive
    ];
}
