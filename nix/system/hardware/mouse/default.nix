{ ... }: {
  services.libinput = {
    enabled = true;
    mouse.accelProfile = "flat";
  };
}
