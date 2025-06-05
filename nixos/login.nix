{
  services.getty.autologinUser = "jie";
  services.greetd = {
    enable = true;
    settings.default_session = {
      user = "jie";
      command = "steam-gamescope > /dev/null 2>&1";
    };
  };
}
