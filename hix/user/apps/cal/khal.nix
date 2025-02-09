{pkgs, ...}: {
    home.packages = with pkgs; [khal];
    home.file = {
        ".config/khal/config".text = ''
          [calendars]
          [[obl]]
          priority = 20
          path = ~/MEGA/ansible/6-assets/icloud_calendar/home
          [[rem]]
          priority = 20
          path = ~/MEGA/ansible/6-assets/icloud_calendar/A20717B0-A788-4C5E-947F-817AF7457F97
          [keybindings]
          save = ctrl s
          external_edit = ctrl e
        '';
    };
}
