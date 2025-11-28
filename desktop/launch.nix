{username, ...}: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 0;
    limine.maxGenerations = 5;
  };
  boot.kernelParams = ["quiet"];
  boot.initrd.systemd.enable = true;
  boot.initrd.verbose = false;
  boot.plymouth.enable = true;
  boot.consoleLogLevel = 0;
  # systemd.extraConfig = "DefaultTimeoutStopSec=5s";

  services.getty.autologinUser = username;
  services.greetd = {
    enable = true;
    settings.default_session = {
      user = username;
      command = "steam-gamescope > /dev/null 2>&1";
    };
  };
}
