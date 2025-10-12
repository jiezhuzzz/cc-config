{config, ...}: let
  localMountPoint = "${config.home.homeDirectory}/Storages";
in {
  programs.rclone = {
    enable = true;
  };
}
