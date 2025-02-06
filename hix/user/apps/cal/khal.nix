{pkgs, ...}: {
    home.packages = with pkgs; [khal];
    home.file = {
        ".config/khal/config".text = ''
          [calendars]
          [[Obligations]]
          path = ~/MEGA/ansible/6-assets/icloud_calendar/home
        '';
    };
}
