{pkgs, ...}: {
    home.packages = with pkgs; [isync msmtp neomutt];
}
