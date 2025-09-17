{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics.enable = true;
  hardware.nvidia.open = true;
  hardware.nvidia-container-toolkit.enable = true;
}
