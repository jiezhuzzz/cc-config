{
  networking.networkmanager.enable = true;
  networking.hostName = "steamer";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
}
