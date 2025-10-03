{pkgs, ...}: {
  imports = [
    ./hardware/auto-gen.nix
    ./hardware/partition.nix
    ./hardware/network.nix
    ../apps/transmission.nix
    ../apps/plex.nix
    ../apps/immich.nix
  ];
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = true;
    # Required for containers under podman-compose to be able to talk to each other.
    defaultNetwork.settings.dns_enabled = true;
  };
  services.openssh.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;

  system.stateVersion = "25.11";
}
