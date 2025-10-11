{
  username,
  nixvim,
  catppuccin,
  ...
}: {
  imports = [
    ./hardware/audio.nix
    ./hardware/graphic.nix
    ./hardware/partition.nix
    ./hardware/network.nix
    ./host.nix
    ./fonts.nix
    ./game.nix
    ./launch.nix
  ];
  users.mutableUsers = false;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDxEzB8rb/S0bPaTymoXEj0OFj7FXy2XTapYXLJBMBkj"
    ];
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username}.imports = [
    nixvim.homeModules.nixvim
    catppuccin.homeModules.catppuccin
    ../home-manager/desktop.nix
  ];
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = true;
    # Required for containers under podman-compose to be able to talk to each other.
    defaultNetwork.settings.dns_enabled = true;
  };
  services.openssh = {
    enable = true;
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  services.vscode-server.enable = true;
  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;

  environment.sessionVariables = {
    PROTON_USE_NTSYNC = "1";
    ENABLE_HDR_WSI = "1";
    DXVK_HDR = "1";
    PROTON_ENABLE_NVAPI = "1";
    ENABLE_GAMESCOPE_WSI = "1";
    STEAM_MULTIPLE_XWAYLANDS = "1";
  };

  system.stateVersion = "25.11";
}
