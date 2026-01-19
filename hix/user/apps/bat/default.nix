{config, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme =
        if config.handdara.lightworks
        then "ansi"
        else "base16";
    };
  };
}
