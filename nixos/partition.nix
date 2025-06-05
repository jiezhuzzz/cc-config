{
  disko.devices = {
    disk = {
      zero = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            primary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
      one = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            # boot = {
            #   size = "512M";
            #   type = "EF00";
            #   content = {
            #     type = "mdraid";
            #     name = "boot";
            #   };
            # };
            primary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };
    # mdadm = {
    #   boot = {
    #     type = "mdadm";
    #     level = 1;
    #     metadata = "1.0";
    #     content = {
    #       type = "filesystem";
    #       format = "vfat";
    #       mountpoint = "/boot";
    #       mountOptions = ["umask=0077"];
    #     };
    #   };
    # };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            lvm_type = "raid0";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
        };
      };
    };
  };
}
