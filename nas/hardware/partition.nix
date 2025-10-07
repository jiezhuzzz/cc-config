let
  mkHDD = deviceID: {
    type = "disk";
    device = "/dev/disk/by-id/${deviceID}";
    content = {
      type = "gpt";
      partitions.zfs = {
        size = "100%";
        content = {
          type = "zfs";
          pool = "zstorage";
        };
      };
    };
  };
in {
  disko.devices = {
    disk = {
      ssd1 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_Green_SN350_1TB_22520U800527";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
      ssd2 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_Green_SN350_1TB_22520U803507";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
      hdd1 = mkHDD "ata-ST12000VN0008-2PH103_ZL2P31JY";
      hdd2 = mkHDD "ata-ST12000VN0008-2PH103_ZLW2JM3L";
      hdd3 = mkHDD "ata-ST12000VN0008-2PH103_ZLW2JZGQ";
      hdd4 = mkHDD "ata-ST12000VN0008-2PH103_ZTN1C4RV";
      hdd5 = mkHDD "ata-ST12000VN0008-2PH103_ZTN1CHSK";
      hdd6 = mkHDD "ata-ST12000VN0008-2PH103_ZTN1DT63";
    };

    zpool = {
      zroot = {
        type = "zpool";
        mode = "mirror";
        options.cachefile = "none";
        rootFsOptions = {
          canmount = "off";
          compression = "zstd";
          atime = "off";
        };
        datasets = {
          "root" = {
            type = "zfs_fs";
            options.mountpoint = "/";
          };
          "home" = {
            type = "zfs_fs";
            options.mountpoint = "/home";
          };
        };
      };

      zstorage = {
        type = "zpool";
        mode = "raidz2";
        options.cachefile = "none";
        rootFsOptions = {
          canmount = "off";
          atime = "off";
          compression = "lz4";
          "com.sun:auto-snapshot" = "false";
          recordsize = "1M";
        };
        datasets = {
          "storage" = {
            type = "zfs_fs";
            options.mountpoint = "/storage";
          };
          "photos" = {
            type = "zfs_fs";
            options.mountpoint = "/storage/photos";
          };
        };
      };
    };
  };
}
