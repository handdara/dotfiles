{...}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "adapta";
      theme_background = false;
      vim_keys = true;
      rounded_corners = true;
    };
  };
}
