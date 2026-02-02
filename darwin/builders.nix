{ config, pkgs, ... }:

{
  # Configure remote builders for Linux systems
  nix.buildMachines = [
    {
      # Existing aarch64-linux builder (local VM)
      hostName = "linux-builder";
      protocol = "ssh-ng";
      sshUser = "builder";
      sshKey = "/etc/nix/builder_ed25519";
      systems = ["aarch64-linux"];
      maxJobs = 4;
      speedFactor = 1;
      supportedFeatures = ["kvm" "benchmark" "big-parallel" "nixos-test"];
      mandatoryFeatures = [];
      publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUpCV2N4Yi9CbGFxdDFhdU90RStGOFFVV3JVb3RpQzVxQkorVXVFV2RWQ2Igcm9vdEBuaXhvcwo=";
    }
    {
      # x86_64-linux remote builder (192.5.86.200)
      hostName = "192.5.86.200";
      systems = ["x86_64-linux"];
      sshUser = "cc";
      sshKey = "/Users/jie/.ssh/cc.private";
      maxJobs = 8; # Adjust based on server's CPU cores
      speedFactor = 2; # Higher priority than local builder
      supportedFeatures = ["benchmark" "big-parallel" "nixos-test"];
    }
  ];

  # Enable distributed builds
  nix.distributedBuilds = true;

  nix.settings = {
    builders-use-substitutes = true;
  };

  # Optional: Configure the Linux builder VM (if using the built-in one)
  # nix.linux-builder = {
  #   enable = true;
  #   systems = [ "aarch64-linux" "x86_64-linux" ];
  #   maxJobs = 4;
  #   config = {
  #     virtualisation = {
  #       darwin-builder = {
  #         diskSize = 40 * 1024;
  #         memorySize = 8 * 1024;
  #       };
  #       cores = 6;
  #     };
  #   };
  # };
}
