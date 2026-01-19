{ pkgs, ... }: {
  home.packages = [ pkgs.vdirsyncer ];
  home.file = {
    ".vdirsyncer/config".text = ''
      [general]
      status_path = "~/.vdirsyncer/status/"

      [pair icloud_calendar]
      a = "icloud_calendar_local"
      b = "icloud_calendar_remote"
      collections = ["from b", "from a"]
      metadata = ["color"]

      [storage icloud_calendar_local]
      type = "filesystem"
      path = "~/MEGA/ansible/6-assets/icloud_calendar/"

      fileext = ".ics"

      [storage icloud_calendar_remote]
      type = "caldav"
      url = "https://caldav.icloud.com"
      username.fetch = ["command", "pass", "apple/sha76-cal-sync-usernm"]
      password.fetch = ["command", "pass", "apple/sha76-cal-sync-passwd"]
    '';
  };
}
