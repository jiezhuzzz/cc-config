{config, ...}: let
  localMountPoint = "${config.home.homeDirectory}/Storages";
in {
  programs.rclone = {
    enable = true;
    remotes = {
      nas = {
        config = {
          type = "sftp";
          host = "192.168.86.26";
          user = "nas";
          key_file = "${config.home.homeDirectory}/.ssh/personal.private";
        };
        mounts = {
          # The remote path to mount (empty string "" means root of the remote)
          "/storage/music" = {
            enable = true;
            mountPoint = "${localMountPoint}/nas";
            options = {
              # CLI flags for rclone mount (without leading --)
              dir-cache-time = "1h";
              vfs-cache-mode = "full";
            };
          };
        };
      };
    };
  };
}
