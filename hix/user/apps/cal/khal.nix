{pkgs, ...}: {
    home.packages = with pkgs; [khal];
    home.file = {
        ".config/khal/config".text = ''
          [calendars]
          [[obl]]
          path = ~/MEGA/ansible/6-assets/icloud_calendar/home
          [[rem]]
          path = ~/MEGA/ansible/6-assets/icloud_calendar/A20717B0-A788-4C5E-947F-817AF7457F97
        '';
    };
}
