{pkgs, ...}: {
  imports = [
    ./hardware/audio.nix
    ./hardware/graphic.nix
    ./hardware/partition.nix
    ./hardware/network.nix
    ./host.nix
    ./fonts.nix
    # ./game.nix
    # ./launch.nix
  ];

  services.openssh = {
    enable = true;
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  services.vscode-server.enable = true;
  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.jie = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video" "audio"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDxEzB8rb/S0bPaTymoXEj0OFj7FXy2XTapYXLJBMBkj"
    ];
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
  ];

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
